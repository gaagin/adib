'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const vm = require('node:vm');

test('filter state and whitelisted view settings are cached locally and synced to the account API', async () => {
  const source = fs.readFileSync(path.join(__dirname, '..', 'filter-memory.js'), 'utf8');
  class MockStorage {
    constructor() { this.items = new Map(); }
    getItem(key) { return this.items.has(String(key)) ? this.items.get(String(key)) : null; }
    setItem(key, value) { this.items.set(String(key), String(value)); }
  }
  let sent;
  const localStorage = new MockStorage();
  const window = {
    Storage: MockStorage,
    localStorage,
    console: { warn() {} },
    ADIBAccount: { user: { id: 'person-1' }, ready: Promise.resolve() },
    fetch: async (url, options) => {
      assert.equal(url, '/api/user/preferences');
      sent = JSON.parse(options.body);
      return { ok: true, json: async () => ({ updatedAt: Date.now() }) };
    },
  };
  const context = {
    window,
    localStorage,
    Storage: MockStorage,
    Date,
    Set,
    JSON,
    Object,
    String,
    Number,
    Array,
    RegExp,
    Promise,
    clearTimeout,
    setTimeout: () => 1,
  };
  vm.runInNewContext(source, context);
  window.ADIBFilters.write('calendar', { view: 'week', status: 'open' });
  window.ADIBFilters.setValue('ela-theme', 'dark');

  assert.deepEqual(JSON.parse(localStorage.getItem('adib-user-preferences-v1')).filters.calendar, {
    view: 'week',
    status: 'open',
  });
  assert.equal(localStorage.getItem('ela-theme'), 'dark');
  assert.equal(window.ADIBFilters.getValue('ela-theme'), 'dark');

  await window.ADIBFilters.sync();
  assert.equal(sent.settings.filters.calendar.view, 'week');
  assert.equal(sent.settings.values['ela-theme'], 'dark');
});