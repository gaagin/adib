'use strict';

const fs = require('node:fs');
const path = require('node:path');

const VERSION = 1;
const PAGE_TITLE = 'ADIB — настройки пользователя';
const BLOCK_MARKER = 'ADIB_USER_PREFERENCES_V1\n';
const MAX_BYTES = 64 * 1024;
const MAX_TEXT = 4000;
const VALUE_KEYS = new Set([
  'ela-theme',
  'adib-chat-palette-v1',
  'adib-side-collapsed',
  'adib-completed-collapsed',
  'adib-home-hide-details',
  'adib-task-sort-key',
  'adib-task-sort-desc',
  'ela-kanban-group-prefs-v1',
  'ela-kanban-column-prefs-v1',
  'ela-personal-kanban-group-by-v1',
  'ela-personal-kanban-view-v1',
  'ela-equipment-kanban-view-v1',
]);

function isObject(value) {
  return Boolean(value) && typeof value === 'object' && !Array.isArray(value);
}

function cleanTree(value, depth = 0) {
  if (depth > 6) throw Object.assign(new Error('Settings nesting is too deep'), { statusCode: 400 });
  if (value === null || typeof value === 'boolean' || typeof value === 'number') return value;
  if (typeof value === 'string') {
    if (value.length > MAX_TEXT) throw Object.assign(new Error('Setting value is too long'), { statusCode: 400 });
    return value;
  }
  if (Array.isArray(value)) {
    if (value.length > 500) throw Object.assign(new Error('Too many items in setting'), { statusCode: 400 });
    return value.map(item => cleanTree(item, depth + 1));
  }
  if (isObject(value)) {
    const entries = Object.entries(value);
    if (entries.length > 200) throw Object.assign(new Error('Too many fields in setting'), { statusCode: 400 });
    return Object.fromEntries(entries.map(([key, child]) => {
      if (key.length > 120 || /[\u0000-\u001f]/.test(key)) throw Object.assign(new Error('Invalid setting key'), { statusCode: 400 });
      return [key, cleanTree(child, depth + 1)];
    }));
  }
  throw Object.assign(new Error('Unsupported setting value'), { statusCode: 400 });
}

function allowedValueKey(key) {
  return VALUE_KEYS.has(key) || /^adib-calendar-hour-height:(month|week|three|day|year|agenda)$/.test(key);
}

function cleanSettings(input) {
  if (!isObject(input)) throw Object.assign(new Error('Settings object is required'), { statusCode: 400 });
  const filters = {};
  if (isObject(input.filters)) {
    for (const [screen, value] of Object.entries(input.filters)) {
      if (!/^[a-z0-9:_-]{1,120}$/i.test(screen)) continue;
      if (!isObject(value)) continue;
      filters[screen] = cleanTree(value);
    }
  }
  const values = {};
  if (isObject(input.values)) {
    for (const [key, value] of Object.entries(input.values)) {
      if (!allowedValueKey(key) || typeof value !== 'string' || value.length > MAX_TEXT) continue;
      values[key] = value;
    }
  }
  const clean = { version: VERSION, filters, values };
  if (Buffer.byteLength(JSON.stringify(clean), 'utf8') > MAX_BYTES) {
    throw Object.assign(new Error('Settings are too large'), { statusCode: 413 });
  }
  return clean;
}

function hasSettings(settings) {
  return Boolean(settings && (
    Object.keys(settings.filters || {}).length ||
    Object.keys(settings.values || {}).length
  ));
}

function richTextChunks(text) {
  const chunks = [];
  for (let offset = 0; offset < text.length; offset += 1800) {
    chunks.push({
      type: 'text',
      text: { content: text.slice(offset, offset + 1800) },
    });
  }
  return chunks.length ? chunks : [{ type: 'text', text: { content: '' } }];
}

function blockText(block) {
  return (block?.[block?.type]?.rich_text || [])
    .map(part => part.plain_text || part.text?.content || '')
    .join('');
}

function unwrapNotionSettings(blocks) {
  const candidates = (blocks || []).filter(block =>
    block?.type === 'code' &&
    block.code?.language === 'json' &&
    blockText(block).startsWith(BLOCK_MARKER)
  );
  for (const block of candidates.reverse()) {
    try {
      const parsed = JSON.parse(blockText(block).slice(BLOCK_MARKER.length));
      return { settings: cleanSettings(parsed.settings), updatedAt: Number(parsed.updatedAt) || 0 };
    } catch { /* Ignore a manually edited or incomplete copy. */ }
  }
  return null;
}

class UserPreferencesStore {
  constructor({ file, notion, listBlocks, parentPageForUser, now = () => Date.now(), logger = console } = {}) {
    Object.assign(this, { file, notion, listBlocks, parentPageForUser, now, logger });
    this.state = { version: VERSION, users: {} };
    this.queues = new Map();
    if (file && fs.existsSync(file)) {
      try {
        const parsed = JSON.parse(fs.readFileSync(file, 'utf8'));
        if (parsed.version === VERSION && isObject(parsed.users)) this.state = parsed;
      } catch (error) {
        this.logger.warn?.('User preferences store could not be read:', error.message);
      }
    }
  }

  save() {
    if (!this.file) return;
    fs.mkdirSync(path.dirname(this.file), { recursive: true });
    const temporary = this.file + '.tmp';
    fs.writeFileSync(temporary, JSON.stringify(this.state), { mode: 0o600 });
    fs.renameSync(temporary, this.file);
  }

  async parentId(user) {
    const result = await this.parentPageForUser?.(user);
    return String(result?.id || result || '').replace(/-/g, '').toLowerCase();
  }

  async findPage(parentId) {
    if (!parentId || !this.listBlocks) return null;
    const children = await this.listBlocks(parentId);
    const match = children.find(block =>
      block?.type === 'child_page' &&
      String(block.child_page?.title || '').trim() === PAGE_TITLE
    );
    return match ? { id: match.id } : null;
  }

  async loadFromNotion(user, record = {}) {
    try {
      const parentId = await this.parentId(user);
      if (!parentId) return null;
      const page = record.notionPageId
        ? { id: record.notionPageId }
        : await this.findPage(parentId);
      if (!page?.id) return null;
      const data = unwrapNotionSettings(await this.listBlocks(page.id));
      if (!data) return null;
      return { ...data, notionPageId: page.id };
    } catch (error) {
      this.logger.warn?.('User preferences Notion restore deferred:', error.message);
      return { unavailable: true };
    }
  }

  async get(user) {
    const id = String(user?.id || '').trim();
    if (!id) throw Object.assign(new Error('Authenticated user is required'), { statusCode: 401 });
    const record = this.state.users[id];
    if (record?.settings) {
      return {
        ok: true,
        settings: record.settings,
        updatedAt: Number(record.updatedAt) || 0,
        notionSynced: Boolean(record.notionPageId),
      };
    }
    const restored = await this.loadFromNotion(user, record || {});
    if (restored?.unavailable) {
      return { ok: true, settings: { version: VERSION, filters: {}, values: {} }, updatedAt: 0, notionSynced: false };
    }
    if (restored) {
      this.state.users[id] = {
        settings: restored.settings,
        updatedAt: restored.updatedAt,
        notionPageId: restored.notionPageId,
      };
      this.save();
      return { ok: true, settings: restored.settings, updatedAt: restored.updatedAt, notionSynced: true };
    }
    const empty = { version: VERSION, filters: {}, values: {} };
    this.state.users[id] = { settings: empty, updatedAt: 0 };
    this.save();
    return { ok: true, settings: empty, updatedAt: 0, notionSynced: false };
  }

  async ensurePage(user, record) {
    if (record.notionPageId) return { id: record.notionPageId };
    const parentId = await this.parentId(user);
    if (!parentId) return null;
    const existing = await this.findPage(parentId);
    if (existing) return existing;
    const page = await this.notion('/pages', {
      method: 'POST',
      body: JSON.stringify({
        parent: { page_id: parentId },
        properties: { title: { title: [{ type: 'text', text: { content: PAGE_TITLE } }] } },
      }),
    });
    return page?.id ? { id: page.id, url: page.url || '' } : null;
  }

  async writeNotionPage(pageId, settings, updatedAt) {
    const children = await this.listBlocks(pageId);
    const existing = [...children].reverse().find(block =>
      block?.type === 'code' &&
      block.code?.language === 'json' &&
      blockText(block).startsWith(BLOCK_MARKER)
    );
    const content = BLOCK_MARKER + JSON.stringify({ settings, updatedAt });
    const code = { rich_text: richTextChunks(content), language: 'json' };
    if (existing) {
      try {
        await this.notion('/blocks/' + encodeURIComponent(existing.id), {
          method: 'PATCH',
          body: JSON.stringify({ code }),
        });
        return;
      } catch (error) {
        this.logger.warn?.('Updating the ADIB settings block failed; replacing it:', error.message);
      }
    }
    const result = await this.notion('/blocks/' + encodeURIComponent(pageId) + '/children', {
      method: 'PATCH',
      body: JSON.stringify({
        children: [{ object: 'block', type: 'code', code }],
      }),
    });
    const created = result?.results?.[0];
    if (!created?.id) throw new Error('Notion did not confirm the settings block');
    if (existing) {
      try {
        await this.notion('/blocks/' + encodeURIComponent(existing.id), {
          method: 'DELETE',
        });
      } catch (error) {
        this.logger.warn?.('Old ADIB settings block could not be removed:', error.message);
      }
    }
  }

  put(user, input) {
    const id = String(user?.id || '').trim();
    if (!id) return Promise.reject(Object.assign(new Error('Authenticated user is required'), { statusCode: 401 }));
    const settings = cleanSettings(input);
    const previous = this.queues.get(id) || Promise.resolve();
    const current = previous.catch(() => {}).then(async () => {
      const updatedAt = this.now();
      const record = { ...(this.state.users[id] || {}), settings, updatedAt };
      this.state.users[id] = record;
      this.save();
      let notionSynced = false;
      let pageUrl = '';
      try {
        const page = await this.ensurePage(user, record);
        if (page?.id) {
          await this.writeNotionPage(page.id, settings, updatedAt);
          record.notionPageId = page.id;
          pageUrl = page.url || '';
          notionSynced = true;
          this.save();
        }
      } catch (error) {
        this.logger.warn?.('User preferences saved to the persistent app store; Notion mirror deferred:', error.message);
      }
      return { ok: true, settings, updatedAt, notionSynced, ...(pageUrl ? { pageUrl } : {}) };
    });
    this.queues.set(id, current);
    return current.finally(() => {
      if (this.queues.get(id) === current) this.queues.delete(id);
    });
  }
}

module.exports = {
  UserPreferencesStore,
  cleanSettings,
  hasSettings,
  unwrapNotionSettings,
  PAGE_TITLE,
  BLOCK_MARKER,
};