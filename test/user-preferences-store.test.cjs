'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const {
  UserPreferencesStore,
  cleanSettings,
  PAGE_TITLE,
  BLOCK_MARKER,
} = require('../user-preferences-store');

function temporaryFile() {
  const directory = fs.mkdtempSync(path.join(os.tmpdir(), 'adib-user-prefs-'));
  return {
    file: path.join(directory, 'user-preferences.json'),
    cleanup: () => fs.rmSync(directory, { recursive: true, force: true }),
  };
}

function mockNotion() {
  const pages = new Map();
  const calls = [];
  let nextId = 1;
  const notion = async (endpoint, options = {}) => {
    const body = options.body ? JSON.parse(options.body) : {};
    calls.push({ endpoint, method: options.method || 'GET', body });
    if (endpoint === '/pages' && options.method === 'POST') {
      const id = 'settings-page-' + nextId++;
      pages.set(id, []);
      return { id, url: 'https://notion.test/' + id, object: 'page' };
    }
    const addChild = endpoint.match(/^\/blocks\/([^/]+)\/children$/);
    if (addChild && options.method === 'PATCH') {
      const id = 'settings-block-' + nextId++;
      const block = { id, ...body.children[0] };
      pages.get(decodeURIComponent(addChild[1])).push(block);
      return { results: [block] };
    }
    const updateBlock = endpoint.match(/^\/blocks\/([^/]+)$/);
    if (updateBlock && options.method === 'PATCH') {
      for (const blocks of pages.values()) {
        const block = blocks.find(item => item.id === decodeURIComponent(updateBlock[1]));
        if (block) {
          block.code = body.code;
          return block;
        }
      }
    }
    if (updateBlock && options.method === 'DELETE') {
      for (const blocks of pages.values()) {
        const index = blocks.findIndex(item => item.id === decodeURIComponent(updateBlock[1]));
        if (index >= 0) blocks.splice(index, 1);
      }
      return { ok: true };
    }
    throw new Error('Unexpected Notion mock request: ' + endpoint + ' ' + options.method);
  };
  const listBlocks = async id => {
    if (pages.has(id)) return pages.get(id);
    const childPage = [...pages.keys()].find(pageId => parentIds.get(pageId) === id);
    return childPage ? [{ id: childPage, type: 'child_page', child_page: { title: PAGE_TITLE } }] : [];
  };
  const parentIds = new Map();
  const createPage = notion;
  const notionWithParent = async (endpoint, options = {}) => {
    const result = await createPage(endpoint, options);
    if (endpoint === '/pages' && options.method === 'POST') {
      const body = JSON.parse(options.body);
      parentIds.set(result.id, body.parent.page_id);
    }
    return result;
  };
  return { notion: notionWithParent, listBlocks, calls, pages, parentIds };
}

test('preferences are validated and limited to known settings keys', () => {
  const settings = cleanSettings({
    filters: { calendar: { view: 'week', query: 'repair' }, invalid: 'nope' },
    values: { 'ela-theme': 'dark', 'not-a-setting': 'ignore me' },
  });
  assert.deepEqual(settings, {
    version: 1,
    filters: { calendar: { view: 'week', query: 'repair' } },
    values: { 'ela-theme': 'dark' },
  });
  assert.throws(() => cleanSettings({ filters: { view: { query: 'x'.repeat(5000) } } }), /too long/i);
});

test('stores preferences separately per authenticated account and mirrors each to its own Notion page', async () => {
  const temp = temporaryFile();
  try {
    const notion = mockNotion();
    const store = new UserPreferencesStore({
      file: temp.file,
      notion: notion.notion,
      listBlocks: notion.listBlocks,
      parentPageForUser: user => user.personalPageId,
      now: (() => { let now = 1000; return () => ++now; })(),
      logger: { warn() {} },
    });
    const alice = { id: 'alice-account', personalPageId: 'alice-personal' };
    const bob = { id: 'bob-account', personalPageId: 'bob-personal' };
    const aliceSettings = { filters: { calendar: { view: 'week' } }, values: { 'ela-theme': 'dark' } };
    const bobSettings = { filters: { calendar: { view: 'month' } }, values: { 'ela-theme': 'light' } };

    assert.equal((await store.put(alice, aliceSettings)).notionSynced, true);
    assert.equal((await store.put(bob, bobSettings)).notionSynced, true);
    assert.deepEqual((await store.get(alice)).settings.filters.calendar, { view: 'week' });
    assert.deepEqual((await store.get(bob)).settings.filters.calendar, { view: 'month' });
    assert.equal(notion.pages.size, 2);
    assert.deepEqual([...notion.parentIds.values()].sort(), ['alicepersonal', 'bobpersonal']);

    const restored = new UserPreferencesStore({
      file: temp.file,
      notion: notion.notion,
      listBlocks: notion.listBlocks,
      parentPageForUser: user => user.personalPageId,
      logger: { warn() {} },
    });
    assert.equal((await restored.get(alice)).settings.values['ela-theme'], 'dark');
  } finally {
    temp.cleanup();
  }
});

test('can recover a settings page from Notion when the app volume has no copy', async () => {
  const temp = temporaryFile();
  try {
    const notion = mockNotion();
    const user = { id: 'account-1', personalPageId: 'personal-1' };
    const first = new UserPreferencesStore({
      file: temp.file,
      notion: notion.notion,
      listBlocks: notion.listBlocks,
      parentPageForUser: item => item.personalPageId,
      logger: { warn() {} },
    });
    await first.put(user, { filters: { home: { sort: 'date' } }, values: {} });
    fs.rmSync(temp.file);
    const restored = new UserPreferencesStore({
      file: temp.file,
      notion: notion.notion,
      listBlocks: notion.listBlocks,
      parentPageForUser: item => item.personalPageId,
      logger: { warn() {} },
    });
    const result = await restored.get(user);
    assert.deepEqual(result.settings.filters.home, { sort: 'date' });
    assert.equal(result.notionSynced, true);
    assert.ok(notion.calls.some(call => call.endpoint === '/blocks/settings-page-1/children'));
  } finally {
    temp.cleanup();
  }
});

test('Notion mirror failure does not discard the durable per-user copy', async () => {
  const temp = temporaryFile();
  try {
    const store = new UserPreferencesStore({
      file: temp.file,
      notion: async () => { throw new Error('temporary Notion failure'); },
      listBlocks: async () => [],
      parentPageForUser: () => 'personal-1',
      logger: { warn() {} },
    });
    const result = await store.put(
      { id: 'account-1', personalPageId: 'personal-1' },
      { filters: { calendar: { view: 'day' } }, values: {} },
    );
    assert.equal(result.notionSynced, false);
    assert.deepEqual((await store.get({ id: 'account-1' })).settings.filters.calendar, { view: 'day' });
  } finally {
    temp.cleanup();
  }
});
test('chat palette is retained by the server settings allowlist', () => {
  const clean = cleanSettings({ values: { 'adib-chat-palette-v1': 'mint', unrelated: 'drop' } });
  assert.equal(clean.values['adib-chat-palette-v1'], 'mint');
  assert.equal(clean.values.unrelated, undefined);
  for (const client of ['account-client.js', 'filter-memory.js']) {
    assert.match(fs.readFileSync(path.join(__dirname, '..', client), 'utf8'), /'adib-chat-palette-v1'/);
  }
});
