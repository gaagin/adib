'use strict';

const UUID = /^[a-f0-9]{32}$/i;

function richText(value) {
  const text = String(value || '').slice(0, 1900);
  return { rich_text: text ? [{ text: { content: text } }] : [] };
}

function asIso(value) {
  const numeric = typeof value === 'number' ? value : Date.parse(value);
  if (!Number.isFinite(numeric)) throw new Error('Invalid timer session timestamp');
  return new Date(numeric).toISOString();
}

function taskRelationName(sourceKey) {
  return sourceKey === 'personal'
    ? 'Задача (Мои задачи)'
    : sourceKey === 'todo'
      ? 'Задача (ToDo)'
      : sourceKey === 'gorulen'
        ? 'Задача (Gorulen isler)'
        : '';
}

function notionPageId(value) {
  const compact = String(value || '').replace(/-/g, '');
  if (!/^[a-f0-9]{32}$/i.test(compact)) return '';
  return `${compact.slice(0, 8)}-${compact.slice(8, 12)}-${compact.slice(12, 16)}-${compact.slice(16, 20)}-${compact.slice(20)}`;
}

function pageTitle(page, propertyName) {
  return (page?.properties?.[propertyName]?.title || [])
    .map(item => item.plain_text || item.text?.content || '')
    .join('');
}

class TimerSessionLog {
  constructor({ notion, queryDatabase, dataSourceId }) {
    Object.assign(this, { notion, queryDatabase, dataSourceId });
  }

  async record(session) {
    if (!session?.id || !session.notionLogEligible) return { skipped: true };
    const id = String(session.id);
    const existing = await this.queryDatabase('', this.dataSourceId, {
      page_size: 1,
      filter: { property: 'ID сеанса', rich_text: { equals: id } },
    });
    if (existing?.length) return { id: existing[0].id, existing: true };

    const sourceKey = session.sourceKey || 'personal';
    const sourceName = sourceKey === 'personal'
      ? 'Мои задачи'
      : sourceKey === 'todo'
        ? 'ToDo'
        : sourceKey === 'gorulen'
          ? 'Gorulen isler'
          : '';
    const relationName = taskRelationName(sourceKey);
    const startedAt = asIso(session.startedAt);
    const endedAt = asIso(session.endedAt);
    const minutes = Math.max(0, Number(session.seconds) || 0) / 60;
    const title = String(session.title || 'Сеанс').slice(0, 1900);
    const properties = {
      Сеанс: { title: [{ text: { content: title } }] },
      Начало: { date: { start: startedAt } },
      Завершение: { date: { start: endedAt } },
      'Длительность, мин': { number: minutes },
      'Тип таймера': { select: { name: session.kind === 'work' ? 'Рабочий таймер' : 'Pomodoro' } },
      Режим: { select: { name: session.mode === 'break' ? 'Перерыв' : 'Работа' } },
      Исполнитель: richText(session.worker || session.actorName || ''),
      'ID сеанса': richText(id),
      'Полный Pomodoro': { checkbox: session.fullPomodoro === true },
      'Причина завершения': richText(session.completionReason || ''),
    };
    if (sourceName) properties['База задачи'] = { select: { name: sourceName } };
    const taskId = String(session.taskId || '');
    if (relationName && UUID.test(taskId.replace(/-/g, ''))) {
      properties[relationName] = { relation: [{ id: taskId }] };
    }

    const page = await this.notion('/pages', {
      method: 'POST',
      body: JSON.stringify({
        parent: { data_source_id: this.dataSourceId },
        properties,
      }),
    });
    return { id: page.id, existing: false };
  }

  async renameTask(taskId, sourceKey, title) {
    const id = notionPageId(taskId);
    const relationName = taskRelationName(sourceKey);
    const nextTitle = String(title || '').trim().slice(0, 1900);
    if (!id || !relationName || !nextTitle || !this.dataSourceId) {
      return { updated: 0, skipped: true };
    }

    const pages = await this.queryDatabase('', this.dataSourceId, {
      page_size: 100,
      filter: { property: relationName, relation: { contains: id } },
    });
    let updated = 0;
    for (const page of pages || []) {
      if (!page?.id || pageTitle(page, 'Сеанс') === nextTitle) continue;
      await this.notion('/pages/' + encodeURIComponent(page.id), {
        method: 'PATCH',
        body: JSON.stringify({
          properties: {
            Сеанс: { title: [{ text: { content: nextTitle } }] },
          },
        }),
      });
      updated++;
    }
    return { updated, skipped: false };
  }

  async remove(session) {
    if (!session?.id) return { deleted: 0 };
    const id = String(session.id);
    let pages = [];
    if (session.notionPageId && session.notionPageId !== 'recorded') {
      pages = [{ id: String(session.notionPageId) }];
    } else if (this.dataSourceId) {
      pages = await this.queryDatabase('', this.dataSourceId, {
        page_size: 100,
        filter: { property: 'ID сеанса', rich_text: { equals: id } },
      });
    }
    for (const page of pages || []) {
      if (!page?.id) continue;
      await this.notion('/pages/' + encodeURIComponent(page.id), {
        method: 'PATCH',
        body: JSON.stringify({ archived: true }),
      });
    }
    return { deleted: (pages || []).length };
  }
}

module.exports = { TimerSessionLog, asIso };