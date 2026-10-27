'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const { WorkTimerStore } = require('../work-timer');

test('confirming a work session appends the Gorulen is entry and retries do not duplicate it', async t => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'adib-work-done-'));
  t.after(() => fs.rmSync(dir, { recursive: true, force: true }));
  const taskId = '12345678123412341234123456789abc';
  const startedAt = Date.parse('2026-10-27T07:00:58.000Z');
  const endedAt = Date.parse('2026-10-27T07:25:13.000Z');
  const calls = [];
  const page = {
    id: taskId,
    parent: { data_source_id: 'todo-ds' },
    properties: { 'Gorulen is': { type: 'rich_text', rich_text: [{ plain_text: 'Old record' }] } },
  };
  const store = new WorkTimerStore({
    file: path.join(dir, 'work.json'),
    now: () => endedAt + 1,
    notion: async (url, options = {}) => {
      calls.push([url, options]);
      if (options.method === 'GET') return structuredClone(page);
      if (options.method === 'PATCH') {
        const body = JSON.parse(options.body);
        page.properties['Gorulen is'].rich_text = body.properties['Gorulen is'].rich_text;
        return { id: taskId };
      }
      throw new Error('Unexpected Notion request');
    },
    sources: () => [{ key: 'todo', ds: 'todo-ds', doneWorkName: 'Gorulen is', doneWorkType: 'rich_text' }],
  });
  store.data.tasks[taskId] = { id: taskId, baseSeconds: 0, dirty: false };
  store.data.sessions.push({
    id: 'session-1',
    taskId,
    sourceKey: 'todo',
    title: 'Repair machine',
    actorId: 'worker-1',
    worker: 'Ilqar',
    status: 'pending',
    startedAt,
    endedAt,
    seconds: (endedAt - startedAt) / 1000,
    revision: 2,
  });
  store.save();

  const body = {
    action: 'save',
    sessionId: 'session-1',
    revision: 2,
    startedAt,
    endedAt,
    operationId: 'done-work-save-01',
    doneWorkEntry: 'Sensor yoxlanıldı',
  };
  const result = await store.action(body, { id: 'worker-1', name: 'Ilqar' });
  assert.equal(result.session.status, 'saved');
  assert.match(result.doneWork, /^Old record\n/);
  assert.match(result.doneWork, /Ilqar — Sensor yoxlanıldı$/);
  assert.equal(result.doneWorkTaskId, taskId);
  assert.equal(calls.filter(([url, options]) => url === `/pages/${taskId}` && options.method === 'PATCH').length, 1);

  const retry = await store.action(body, { id: 'worker-1', name: 'Ilqar' });
  assert.equal(retry.session.status, 'saved');
  assert.equal(calls.filter(([url, options]) => url === `/pages/${taskId}` && options.method === 'PATCH').length, 1);
});

test('work note is limited to the configured text property', async t => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'adib-work-done-invalid-'));
  t.after(() => fs.rmSync(dir, { recursive: true, force: true }));
  const taskId = '12345678123412341234123456789abc';
  const store = new WorkTimerStore({
    file: path.join(dir, 'work.json'),
    now: () => 5000,
    notion: async () => ({
      id: taskId,
      parent: { data_source_id: 'todo-ds' },
      properties: { 'Gorulen is': { type: 'number', number: 0 } },
    }),
    sources: () => [{ key: 'todo', ds: 'todo-ds', doneWorkName: 'Gorulen is', doneWorkType: 'rich_text' }],
  });
  store.data.tasks[taskId] = { id: taskId, baseSeconds: 0, dirty: false };
  store.data.sessions.push({
    id: 'session-2',
    taskId,
    sourceKey: 'todo',
    actorId: 'worker-1',
    worker: 'Ilqar',
    status: 'pending',
    startedAt: 1000,
    endedAt: 4000,
    seconds: 3,
    revision: 1,
  });
  await assert.rejects(
    store.action({
      action: 'save', sessionId: 'session-2', revision: 1, startedAt: 1000,
      endedAt: 4000, operationId: 'done-work-save-02', doneWorkEntry: 'Done',
    }, { id: 'worker-1', name: 'Ilqar' }),
    /mətn sahəsi tapılmadı/,
  );
  assert.equal(store.data.sessions[0].status, 'pending');
});