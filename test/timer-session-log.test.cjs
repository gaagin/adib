'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');
const { TimerSessionLog } = require('../timer-session-log');
const { WorkTimerStore } = require('../work-timer');
const { SharedPomodoroStore } = require('../pomodoro-shared');
const { PomodoroSessions } = require('../pomodoro-sessions');

test('timer session log writes task relation and idempotency key', async () => {
  const calls = [];
  const log = new TimerSessionLog({
    dataSourceId: 'session-ds',
    queryDatabase: async (...args) => {
      calls.push(['query', ...args]);
      return [];
    },
    notion: async (...args) => {
      calls.push(['create', ...args]);
      return { id: 'new-page' };
    },
  });
  const result = await log.record({
    id: 'session-1',
    notionLogEligible: true,
    taskId: '12345678-1234-1234-1234-123456789abc',
    sourceKey: 'todo',
    kind: 'work',
    mode: 'work',
    title: 'Repair conveyor',
    startedAt: Date.parse('2026-10-18T08:00:00.000Z'),
    endedAt: Date.parse('2026-10-18T08:40:00.000Z'),
    seconds: 2400,
    worker: 'Araz',
  });
  assert.equal(result.id, 'new-page');
  const [query, , ds, options] = calls[0];
  assert.equal(query, 'query');
  assert.equal(ds, 'session-ds');
  assert.equal(options.filter.property, 'ID сеанса');
  assert.equal(options.filter.rich_text.equals, 'session-1');
  const create = calls[1][2];
  const data = JSON.parse(create.body);
  assert.equal(data.parent.data_source_id, 'session-ds');
  assert.equal(data.properties['Длительность, мин'].number, 40);
  assert.deepEqual(data.properties['Задача (ToDo)'].relation, [{ id: '12345678-1234-1234-1234-123456789abc' }]);
  assert.equal(data.properties['Тип таймера'].select.name, 'Рабочий таймер');
});

test('timer session log reuses existing page after a retry', async () => {
  let creates = 0;
  const log = new TimerSessionLog({
    dataSourceId: 'session-ds',
    queryDatabase: async () => [{ id: 'already-created' }],
    notion: async () => { creates += 1; throw new Error('must not create twice'); },
  });
  const result = await log.record({
    id: 'session-2',
    notionLogEligible: true,
    startedAt: '2026-10-18T08:00:00.000Z',
    endedAt: '2026-10-18T08:25:00.000Z',
    seconds: 1500,
  });
  assert.deepEqual(result, { id: 'already-created', existing: true });
  assert.equal(creates, 0);
});

test('saved work timer sessions are logged once and remain persisted', async () => {
  const fs = require('node:fs');
  const os = require('node:os');
  const path = require('node:path');
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'adib-session-log-'));
  const calls = [];
  try {
    const store = new WorkTimerStore({
      file: path.join(dir, 'work.json'),
      now: () => Date.now(),
      notion: async () => ({}),
      sources: () => [],
      saveSession: async (session) => { calls.push(session.id); return { id: 'notion-row' }; },
    });
    store.data.sessions.push({ id: 'work-1', status: 'saved', notionLogEligible: true });
    await store.flush();
    assert.deepEqual(calls, ['work-1']);
    assert.equal(store.data.sessions[0].notionPageId, 'notion-row');
    await store.flush();
    assert.deepEqual(calls, ['work-1']);
  } finally {
    fs.rmSync(dir, { recursive: true, force: true });
  }
});

test('finished Pomodoro work session is logged after the task update', async () => {
  const start = Date.parse('2026-10-18T08:00:00.000Z');
  const store = new SharedPomodoroStore();
  const taskId = '12345678123412341234123456789abc';
  const timer = {
    id: taskId, title: 'Repair conveyor', mode: 'work', duration: 25,
    plannedDuration: 25, startedAt: new Date(start).toISOString(),
    endsAt: start + 25 * 60_000, running: true, sessionId: 'pomo-1',
    actorId: 'worker-1', worker: 'Araz',
  };
  store.put(timer);
  const order = [];
  const manager = new PomodoroSessions({
    store,
    loadTask: async () => ({ id: taskId, title: 'Repair conveyor' }),
    patchTask: async () => { order.push('task'); },
    saveSession: async (session) => { order.push('log'); return { id: 'notion-pomo' }; },
    now: () => start + 25 * 60_000,
  });
  await manager.finish(timer);
  assert.deepEqual(order, ['task', 'log']);
  assert.equal(store.sessions[0].notionPageId, 'notion-pomo');
  assert.equal(store.sessions[0].notionLogEligible, true);
});