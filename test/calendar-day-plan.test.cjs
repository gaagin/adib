const { test } = require("node:test");
const assert = require("node:assert/strict");
const DayPlan = require("../calendar-day-plan");

const key = (task) => String(task.date || "").slice(0, 10);

test("day plan uses estimated minutes and reports remaining capacity", () => {
  const result = DayPlan.build(
    [
      { id: "a", date: "2026-10-15", estimateMinutes: 90 },
      { id: "b", date: "2026-10-15", estimateMinutes: 120 },
      { id: "other", date: "2026-10-16", estimateMinutes: 60 },
    ],
    "2026-10-15",
    { dayKey: key },
  );

  assert.equal(result.taskCount, 2);
  assert.equal(result.totalMinutes, 210);
  assert.equal(result.freeMinutes, 270);
  assert.equal(result.blocks[0].start, 0);
  assert.equal(result.blocks[1].start, 90);
  assert.equal(result.full, false);
});

test("day plan flags overflow and points to a task that can be moved", () => {
  const result = DayPlan.build(
    [
      { id: "a", date: "2026-10-15", estimateMinutes: 300 },
      { id: "b", date: "2026-10-15", estimateMinutes: 240 },
    ],
    "2026-10-15",
    { dayKey: key },
  );

  assert.equal(result.totalMinutes, 540);
  assert.equal(result.filledMinutes, 480);
  assert.equal(result.freeMinutes, 0);
  assert.equal(result.overflowMinutes, 60);
  assert.equal(result.firstOverflow.id, "b");
  assert.equal(result.blocks[1].visibleMinutes, 180);
});

test("completed, child, session, and unestimated tasks do not consume capacity", () => {
  const result = DayPlan.build(
    [
      { id: "done", date: "2026-10-15", estimateMinutes: 100, completed: true },
      { id: "child", date: "2026-10-15", parentId: "p", estimateMinutes: 90 },
      { id: "session", date: "2026-10-15", estimateMinutes: 50, workSession: {} },
      { id: "unknown", date: "2026-10-15", title: "No estimate" },
      { id: "open", date: "2026-10-15", estimateMinutes: 40 },
    ],
    "2026-10-15",
    {
      dayKey: key,
      isDone: (task) => task.completed === true,
    },
  );

  assert.equal(result.taskCount, 2);
  assert.equal(result.totalMinutes, 40);
  assert.deepEqual(result.unknown.map((task) => task.id), ["unknown"]);
});

test("a full day with no overflow offers the last task as a move candidate", () => {
  const result = DayPlan.build(
    [{ id: "exact", date: "2026-10-15", estimateMinutes: 480 }],
    "2026-10-15",
    { dayKey: key },
  );
  assert.equal(result.full, true);
  assert.equal(result.overflowMinutes, 0);
  assert.equal(result.firstOverflow.id, "exact");
});

const dayPlan = require('../calendar-day-plan.js');

function memoryStorage() {
  const values = new Map();
  return {
    getItem(key) { return values.has(key) ? values.get(key) : null; },
    setItem(key, value) { values.set(key, String(value)); },
  };
}

test('daily capacity defaults to eight hours and is saved independently per date', () => {
  const storage = memoryStorage();
  assert.equal(dayPlan.capacityHoursForDay('2026-10-23', storage), 8);
  assert.equal(dayPlan.setCapacityHoursForDay('2026-10-23', 5.5, storage), 5.5);
  assert.equal(dayPlan.capacityHoursForDay('2026-10-23', storage), 5.5);
  assert.equal(dayPlan.capacityHoursForDay('2026-10-24', storage), 8);
});

test('daily capacity is bounded to 0–8 hours in half-hour increments', () => {
  const storage = memoryStorage();
  assert.equal(dayPlan.setCapacityHoursForDay('2026-10-23', -3, storage), 0);
  assert.equal(dayPlan.capacityHoursForDay('2026-10-23', storage), 0);
  assert.equal(dayPlan.setCapacityHoursForDay('2026-10-24', 12, storage), 8);
  assert.equal(dayPlan.setCapacityHoursForDay('2026-10-25', 3.26, storage), 3.5);
});

test('day-plan model respects custom capacity and reports overflow', () => {
  const tasks = [
    { id: 'a', title: 'A', date: '2026-10-23', estimateMinutes: 120 },
    { id: 'b', title: 'B', date: '2026-10-23', estimateMinutes: 240 },
  ];
  const plan = dayPlan.build(tasks, '2026-10-23', {
    capacityMinutes: 300,
    dayKey: (task) => task.date,
  });
  assert.equal(plan.capacityMinutes, 300);
  assert.equal(plan.filledMinutes, 300);
  assert.equal(plan.full, true);
  assert.equal(plan.overflowMinutes, 60);
  assert.equal(plan.overflow.length, 1);
});

test('zero-hour day remains valid and all estimated work is overflow', () => {
  const plan = dayPlan.build([
    { id: 'a', title: 'A', date: '2026-10-23', estimateMinutes: 30 },
  ], '2026-10-23', {
    capacityMinutes: 0,
    dayKey: (task) => task.date,
  });
  assert.equal(plan.capacityMinutes, 0);
  assert.equal(plan.full, true);
  assert.equal(plan.filledMinutes, 0);
  assert.equal(plan.overflowMinutes, 30);
  assert.equal(plan.overflow.length, 1);
});
