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

function pageRichText(page, propertyName) {
  return (page?.properties?.[propertyName]?.rich_text || [])
    .map(item => item.plain_text || item.text?.content || '')
    .join('');
}

function pageSelect(page, propertyName) {
  return page?.properties?.[propertyName]?.select?.name || '';
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

  async listPomodoro() {
    if (!this.dataSourceId) return [];
    const pages = await this.queryDatabase('', this.dataSourceId, {
      page_size: 100,
      filter: { property: 'Тип таймера', select: { equals: 'Pomodoro' } },
      sorts: [{ property: 'Начало', direction: 'descending' }],
    });
    const relationBySource = {
      personal: 'Задача (Мои задачи)',
      todo: 'Задача (ToDo)',
      gorulen: 'Задача (Gorulen isler)',
    };
    const sourceByName = {
      'Мои задачи': 'personal',
      ToDo: 'todo',
      'Gorulen isler': 'gorulen',
    };
    return (pages || []).map(page => {
      const properties = page?.properties || {};
      const sourceKey = sourceByName[pageSelect(page, 'База задачи')] || 'personal';
      const relationName = relationBySource[sourceKey];
      const startedAt = Date.parse(properties.Начало?.date?.start || '');
      const endedAt = Date.parse(properties.Завершение?.date?.start || '');
      const minutes = Number(properties['Длительность, мин']?.number);
      const id = pageRichText(page, 'ID сеанса') || page.id;
      const taskId = properties[relationName]?.relation?.[0]?.id || '';
      if (!id || !Number.isFinite(startedAt) || !Number.isFinite(endedAt) || endedAt < startedAt) return null;
      const completionReason = pageRichText(page, 'Причина завершения');
      if (completionReason === 'cancelled') return null;
      return {
        id,
        notionPageId: page.id,
        taskId,
        title: pageTitle(page, 'Сеанс') || 'Pomodoro',
        sourceKey,
        kind: 'pomodoro',
        mode: pageSelect(page, 'Режим') === 'Перерыв' ? 'break' : 'work',
        worker: pageRichText(page, 'Исполнитель'),
        status: 'saved',
        startedAt,
        endedAt,
        seconds: Number.isFinite(minutes) ? Math.max(0, Math.round(minutes * 60)) : 0,
        fullPomodoro: properties['Полный Pomodoro']?.checkbox === true,
        completionReason,
        notionLogEligible: true,
        notionSyncPending: false,
      };
    }).filter(Boolean);
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