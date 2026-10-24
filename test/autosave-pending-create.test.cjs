'use strict';
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const vm = require('node:vm');

function loadAutosave(response = { ok: true, json: async () => ({ ok: true, id: 'task-1' }) }) {
  const store = new Map();
  const events = [];
  const localStorage = {
    getItem(key) { return store.has(key) ? store.get(key) : null; },
    setItem(key, value) { store.set(key, String(value)); },
    removeItem(key) { store.delete(key); }
  };
  const root = {
    dispatchEvent(event) { events.push(event.type); },
    addEventListener() {},
    confirm() { return true; },
    alert() {}
  };
  const sandbox = {
    window: root,
    location: { origin: 'https://adib.test' },
    localStorage,
    document: { documentElement: {}, createElement() { return {}; }, body: { append() {} } },
    navigator: { onLine: true },
    Event: class { constructor(type) { this.type = type; } },
    MutationObserver: class { observe() {} },
    setTimeout() { return 1; },
    clearTimeout() {},
    fetch: async () => response,
    crypto: { randomUUID: () => 'test-uuid' },
    console
  };
  vm.runInNewContext(fs.readFileSync(path.join(__dirname, '..', 'autosave.js'), 'utf8'), sandbox, { filename: 'autosave.js' });
  return { api: root.ADIBAutosave, localStorage, events, key: 'adib-autosave-v1:https://adib.test' };
}

function pendingRecord(title = 'Test 3', operationId = 'op-1', extra = {}) {
  return {
    'draft-key': {
      endpoint: '/api/task',
      body: { title, autosaveOperationId: operationId, sourceKey: 'equipment', ...extra },
      fresh: true,
      requested: true,
      attempted: true,
      blocked: false,
      error: 'Access denied'
    }
  };
}

test('definite ACCESS_DENIED create response leaves the draft retryable', async () => {
  const app = loadAutosave({ ok: false, json: async () => ({ error: 'Access denied', code: 'ACCESS_DENIED' }) });
  app.localStorage.setItem(app.key, JSON.stringify(pendingRecord()));
  await app.api.sendRecord('draft-key');
  const saved = JSON.parse(app.localStorage.getItem(app.key));
  assert.equal(saved['draft-key'].blocked, false);
  assert.match(saved['draft-key'].error, /Access denied/);
});

test('pending create appears in equipment list and can be removed locally', () => {
  const app = loadAutosave();
  app.localStorage.setItem(app.key, JSON.stringify(pendingRecord('Test 3', 'op-2')));
  const draft = app.api.merge([], 'equipment').find(task => task.title === 'Test 3');
  assert.equal(draft.id, 'local-create-op-2');
  assert.equal(app.api.discard(draft.id), true);
  assert.deepEqual(JSON.parse(app.localStorage.getItem(app.key)), {});
  assert.ok(app.events.includes('adib-create-data'));
});
