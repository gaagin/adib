const { test } = require('node:test');
const assert = require('node:assert/strict');
const DayPlan = require('../calendar-day-plan.js');

const key = (task) => String(task.date || '').slice(0, 10);

test('Pomodoro progress totals completed and live work sessions, excluding cancelled and break rows', () => {
  const progress = DayPlan.pomodoroProgress(
    { id: 'a', pomodoroMinutes: 20, pomodoroCount: 2 },
    [
      { taskId: 'a', kind: 'pomodoro', mode: 'work', status: 'saved', seconds: 900 },
      { taskId: 'a', kind: 'pomodoro', mode: 'work', status: 'running', seconds: 300 },
      { taskId: 'a', kind: 'pomodoro', mode: 'break', status: 'saved', seconds: 300 },
      { taskId: 'a', kind: 'pomodoro', status: 'cancelled', completionReason: 'cancelled', seconds: 1200 },
      { taskId: 'other', kind: 'pomodoro', status: 'saved', seconds: 600 },
    ],
    true,
  );
  assert.equal(progress.sessionCount, 2);
  assert.equal(progress.completedMinutes, 20);
  assert.equal(progress.runningMinutes, 5);
  assert.equal(progress.minutes, 25);
});

test('Pomodoro focus raises the displayed estimate live and excludes cancelled time', () => {
  const below = DayPlan.withPomodoroProgress(
    { id: 'a', estimateMinutes: 60 },
    [{ taskId: 'a', kind: 'pomodoro', mode: 'work', status: 'saved', seconds: 3500 }],
    true,
  );
  assert.equal(below.estimateMinutes, 60);
  const over = DayPlan.withPomodoroProgress(
    { id: 'a', estimateMinutes: 60 },
    [{ taskId: 'a', kind: 'pomodoro', mode: 'work', status: 'saved', seconds: 3661 }],
    true,
  );
  assert.equal(over.estimateMinutes, 62);
  assert.equal(over.pomodoroProgress.autoAdjusted, true);
  const running = DayPlan.withPomodoroProgress(
    { id: 'a', estimateMinutes: 60 },
    [{ taskId: 'a', kind: 'pomodoro', mode: 'work', status: 'running', seconds: 3661 }],
    true,
  );
  assert.equal(running.estimateMinutes, 62);
  const cancelled = DayPlan.withPomodoroProgress(
    { id: 'a', estimateMinutes: 60 },
    [{ taskId: 'a', kind: 'pomodoro', mode: 'work', status: 'cancelled', completionReason: 'cancelled', seconds: 7200 }],
    true,
  );
  assert.equal(cancelled.estimateMinutes, 60);
  assert.equal(cancelled.pomodoroProgress.minutes, 0);
});

test('day plan uses estimated minutes and reports remaining capacity', () => {
  const result = DayPlan.build([
    { id: 'a', date: '2026-10-15', estimateMinutes: 90 },
    { id: 'b', date: '2026-10-15', estimateMinutes: 120 },
    { id: 'other', date: '2026-10-16', estimateMinutes: 60 },
  ], '2026-10-15', { dayKey: key });
  assert.equal(result.taskCount, 2);
  assert.equal(result.dayCapacityMinutes, 540);
  assert.equal(result.totalMinutes, 210);
  assert.equal(result.freeMinutes, 330);
  assert.equal(result.blocks[0].start, 0);
  assert.equal(result.blocks[1].start, 90);
  assert.equal(result.full, false);
});

test('work window is nine hours from 09:00 through 18:00', () => {
  const window = DayPlan.workWindow('2026-10-21', '2026-10-21', 9 * 60);
  assert.equal(window.startHour, 9);
  assert.equal(window.endHour, 18);
  assert.equal(window.totalMinutes, 540);
  assert.equal(window.elapsedMinutes, 0);
  assert.equal(window.capacityMinutes, 540);
});

test('elapsed time reduces the available work window for today', () => {
  const beforeStart = DayPlan.workWindow('2026-10-21', '2026-10-21', 8 * 60 + 59);
  assert.equal(beforeStart.state, 'before');
  assert.equal(beforeStart.capacityMinutes, 540);

  const midday = DayPlan.workWindow('2026-10-21', '2026-10-21', 12 * 60 + 30);
  assert.equal(midday.elapsedMinutes, 210);
  assert.equal(midday.startMinute, 210);
  assert.equal(midday.capacityMinutes, 330);

  const afterEnd = DayPlan.workWindow('2026-10-21', '2026-10-21', 18 * 60 + 15);
  assert.equal(afterEnd.state, 'after');
  assert.equal(afterEnd.elapsedMinutes, 540);
  assert.equal(afterEnd.capacityMinutes, 0);
});

test('past days have no remaining capacity and future days keep the full window', () => {
  const past = DayPlan.workWindow('2026-10-20', '2026-10-21', 12 * 60);
  const future = DayPlan.workWindow('2026-10-22', '2026-10-21', 12 * 60);
  assert.equal(past.state, 'past');
  assert.equal(past.capacityMinutes, 0);
  assert.equal(past.elapsedMinutes, 540);
  assert.equal(future.state, 'future');
  assert.equal(future.capacityMinutes, 540);
  assert.equal(future.elapsedMinutes, 0);
});

test('tasks start at the current point and overflow beyond 18:00', () => {
  const result = DayPlan.build([
    { id: 'a', date: '2026-10-21', estimateMinutes: 180 },
    { id: 'b', date: '2026-10-21', estimateMinutes: 240 },
  ], '2026-10-21', {
    totalCapacityMinutes: 540,
    startMinute: 210,
    dayKey: key,
  });
  assert.equal(result.startMinute, 210);
  assert.equal(result.capacityMinutes, 330);
  assert.equal(result.totalMinutes, 420);
  assert.equal(result.blocks[0].start, 210);
  assert.equal(result.blocks[0].visibleMinutes, 180);
  assert.equal(result.blocks[1].start, 390);
  assert.equal(result.blocks[1].visibleMinutes, 150);
  assert.equal(result.blocks[1].overflowMinutes, 90);
  assert.equal(result.overflowMinutes, 90);
  assert.equal(result.firstOverflow.id, 'b');
});

test('completed, child, session, and unestimated tasks do not consume capacity', () => {
  const result = DayPlan.build([
    { id: 'done', date: '2026-10-15', estimateMinutes: 100, completed: true },
    { id: 'child', date: '2026-10-15', parentId: 'p', estimateMinutes: 90 },
    { id: 'session', date: '2026-10-15', estimateMinutes: 50, workSession: {} },
    { id: 'unknown', date: '2026-10-15', title: 'No estimate' },
    { id: 'open', date: '2026-10-15', estimateMinutes: 40 },
  ], '2026-10-15', {
    dayKey: key,
    isDone: (task) => task.completed === true,
  });
  assert.equal(result.taskCount, 2);
  assert.equal(result.totalMinutes, 40);
  assert.deepEqual(result.unknown.map((task) => task.id), ['unknown']);
});

test('a full day with no overflow offers the last task as a move candidate', () => {
  const result = DayPlan.build([
    { id: 'exact', date: '2026-10-15', estimateMinutes: 480 },
  ], '2026-10-15', { capacityMinutes: 480, dayKey: key });
  assert.equal(result.full, true);
  assert.equal(result.overflowMinutes, 0);
  assert.equal(result.firstOverflow.id, 'exact');
});

test('when the work window is over, unfinished tasks are overflow and not drawn', () => {
  const result = DayPlan.build([
    { id: 'late', date: '2026-10-20', estimateMinutes: 60 },
  ], '2026-10-20', {
    totalCapacityMinutes: 540,
    startMinute: 540,
    dayKey: key,
  });
  assert.equal(result.capacityMinutes, 0);
  assert.equal(result.blocks[0].visibleMinutes, 0);
  assert.equal(result.overflowMinutes, 60);
  assert.equal(result.overflow[0].task.id, 'late');
});

test('task picker lists unfinished visible parent tasks and excludes completed, child, session and already-estimated tasks for that day', () => {
  const tasks = [
    { id: 'a', title: 'Later', date: '2026-10-16' },
    { id: 'b', title: 'Today, no estimate', date: '2026-10-15' },
    { id: 'c', title: 'Already planned', date: '2026-10-15', estimateMinutes: 30 },
    { id: 'd', title: 'Done', date: '2026-10-16', completed: true },
    { id: 'e', title: 'Child', date: '2026-10-16', parentId: 'p' },
    { id: 'f', title: 'Session', date: '2026-10-16', workSession: {} },
    { id: 'g', title: 'Hidden', date: '2026-10-16' },
  ];
  const result = DayPlan.selectableTasks(tasks, '2026-10-15', {
    dayKey: key,
    isDone: (task) => task.completed === true,
    isVisible: (task) => task.id !== 'g',
  });
  assert.deepEqual(result.map((task) => task.id), ['a', 'b']);
});
