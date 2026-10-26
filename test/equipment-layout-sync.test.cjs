const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const vm = require('node:vm');
const { test } = require('node:test');

const root = path.join(__dirname, '..');
const runtime = fs.readFileSync(path.join(root, 'realtime-runtime.js'), 'utf8');
const html = fs.readFileSync(path.join(root, 'ela-nov-paketleme-dynamic.html'), 'utf8');

test('equipment layout writes are serialized, coalesced, and sent with keepalive', async () => {
  const start = runtime.indexOf('async function writeRemotePosition(a,position){');
  const end = runtime.indexOf('\nfunction updateSyncUi()', start);
  assert.ok(start >= 0 && end > start, 'layout write functions should exist');

  let resolveFirst;
  let firstStarted;
  const started = new Promise(resolve => { firstStarted = resolve; });
  const firstResponse = new Promise(resolve => { resolveFirst = resolve; });
  const writes = [];
  const item = { id: 'equipment-1', x: 1, y: 2, width: 100, height: 80, planId: null };
  const pendingLayouts = new Map();
  const syncError = { textContent: '' };
  const context = {
    CONFIG: { syncUrl: '/api/plan-snapshot' },
    location: { href: 'https://adib.example/' },
    URL,
    state: { plans: [], equipment: [item] },
    pendingLayouts,
    layoutSaveQueues: new Map(),
    window: { ADIBEquipmentPomodoroTasks: [] },
    document: { getElementById: () => syncError },
    localStorage: { getItem: () => '{}', setItem() {} },
    writeSnapshotCache() {},
    setTimeout() {},
    fetch: async (_url, options) => {
      const payload = JSON.parse(options.body);
      writes.push({ payload, options });
      if (writes.length === 1) {
        firstStarted();
        await firstResponse;
      }
      return {
        ok: true,
        json: async () => ({
          ok: true,
          values: { x: payload.x, y: payload.y, width: payload.width, height: payload.height },
          confirmedFromNotion: { x: payload.x, y: payload.y, width: payload.width, height: payload.height }
        })
      };
    }
  };
  vm.runInNewContext(`${runtime.slice(start, end)}\nglobalThis.saveRemotePosition = saveRemotePosition;`, context);

  const first = { x: 10, y: 20, width: 100, height: 80, planId: null };
  const latest = { x: 30, y: 40, width: 100, height: 80, planId: null };
  pendingLayouts.set(item.id, first);
  const saving = context.saveRemotePosition(item, first);
  await started;
  pendingLayouts.set(item.id, latest);
  const savingLatest = context.saveRemotePosition(item, latest);
  assert.equal(saving, savingLatest, 'same equipment should share a serialized write queue');
  resolveFirst();
  await saving;

  assert.equal(writes.length, 2, 'the latest move should be written after the in-flight request');
  assert.deepEqual(writes.map(write => write.payload.x), [10, 30]);
  assert.deepEqual(writes.map(write => write.payload.y), [20, 40]);
  assert.ok(writes.every(write => write.options.keepalive === true), 'writes should survive navigation away from the canvas');
  assert.equal(pendingLayouts.has(item.id), false, 'confirmed layout should clear pending local state');
});

test('equipment canvas references the versioned layout-write runtime', () => {
  assert.match(html, /realtime-runtime\.js\?v=layout-write-through-v2/);
  assert.match(html, /id="syncError" class="error" role="status" aria-live="polite"/);
  assert.match(runtime, /Koordinatlar Notion-a saxlanılır…/);
});
