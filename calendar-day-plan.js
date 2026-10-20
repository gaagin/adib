(function (root, factory) {
  const api = factory();
  if (typeof module === "object" && module.exports) module.exports = api;
  else root.ADIBDayPlan = api;
})(typeof window === "object" ? window : globalThis, function () {
  "use strict";

  const DEFAULT_CAPACITY_HOURS = 8;
  const MIN_CAPACITY_HOURS = 0;
  const MAX_CAPACITY_HOURS = 8;
  const CAPACITY_MINUTES = DEFAULT_CAPACITY_HOURS * 60;
  const START_HOUR = 0;
  const STORAGE_KEY = "adib-day-plan-capacity-v1";

  function resolveStorage(storage) {
    if (storage) return storage;
    try {
      return globalThis.localStorage || null;
    } catch {
      return null;
    }
  }

  function normalizeHours(value) {
    const hours = Number(value);
    if (!Number.isFinite(hours)) return DEFAULT_CAPACITY_HOURS;
    return Math.round(
      Math.max(MIN_CAPACITY_HOURS, Math.min(MAX_CAPACITY_HOURS, hours)) * 2,
    ) / 2;
  }

  function readCapacityMap(storage) {
    try {
      const raw = resolveStorage(storage)?.getItem(STORAGE_KEY);
      const value = raw ? JSON.parse(raw) : {};
      return value && typeof value === "object" && !Array.isArray(value)
        ? value
        : {};
    } catch {
      return {};
    }
  }

  function capacityHoursForDay(day, storage) {
    if (typeof day !== "string" || !day) return DEFAULT_CAPACITY_HOURS;
    const value = readCapacityMap(storage)[day];
    if (value === undefined || value === null || value === "") {
      return DEFAULT_CAPACITY_HOURS;
    }
    const hours = Number(value);
    return Number.isFinite(hours) && hours >= MIN_CAPACITY_HOURS && hours <= MAX_CAPACITY_HOURS
      ? normalizeHours(hours)
      : DEFAULT_CAPACITY_HOURS;
  }

  function setCapacityHoursForDay(day, value, storage) {
    const hours = normalizeHours(value);
    if (typeof day !== "string" || !day) return hours;
    const target = resolveStorage(storage);
    if (!target) return hours;
    try {
      const capacities = readCapacityMap(target);
      capacities[day] = hours;
      target.setItem(STORAGE_KEY, JSON.stringify(capacities));
    } catch {
      // Keep the current UI usable when browser storage is unavailable.
    }
    return hours;
  }

  function build(tasks, day, options = {}) {
    const dayKey = options.dayKey || (() => "");
    const isVisible = options.isVisible || (() => true);
    const isDone = options.isDone || (() => false);
    const capacityMinutes = Number.isInteger(options.capacityMinutes)
      ? Math.max(0, options.capacityMinutes)
      : CAPACITY_MINUTES;
    const matching = (tasks || []).filter((task) => {
      if (!task || task.workSession || task.parentId) return false;
      if (!isVisible(task) || isDone(task)) return false;
      return dayKey(task) === day;
    });

    const known = [];
    const unknown = [];
    matching.forEach((task, index) => {
      const minutes =
        Number.isInteger(task.estimateMinutes) && task.estimateMinutes > 0
          ? task.estimateMinutes
          : null;
      const row = { task, minutes, index };
      if (minutes === null) unknown.push(row);
      else known.push(row);
    });

    known.sort((a, b) => {
      const aTime = Date.parse(a.task.date || "");
      const bTime = Date.parse(b.task.date || "");
      const aHasTime = String(a.task.date || "").includes("T") && Number.isFinite(aTime);
      const bHasTime = String(b.task.date || "").includes("T") && Number.isFinite(bTime);
      if (aHasTime && bHasTime && aTime !== bTime) return aTime - bTime;
      return a.index - b.index;
    });
    unknown.sort((a, b) => a.index - b.index);

    let cursor = 0;
    const blocks = known.map((row) => {
      const start = cursor;
      cursor += row.minutes;
      return {
        task: row.task,
        minutes: row.minutes,
        start,
        end: cursor,
        visibleMinutes: Math.max(0, Math.min(cursor, capacityMinutes) - start),
        overflowMinutes: Math.max(0, cursor - Math.max(start, capacityMinutes)),
      };
    });
    const overflow = blocks.filter((block) => block.end > capacityMinutes);
    const firstOverflow =
      overflow[0]?.task ||
      (capacityMinutes > 0 && cursor >= capacityMinutes ? blocks.at(-1)?.task : null) ||
      null;

    return {
      day,
      capacityMinutes,
      totalMinutes: cursor,
      freeMinutes: Math.max(0, capacityMinutes - cursor),
      filledMinutes: Math.min(capacityMinutes, cursor),
      full: capacityMinutes === 0 || cursor >= capacityMinutes,
      overflowMinutes: Math.max(0, cursor - capacityMinutes),
      blocks,
      overflow,
      firstOverflow,
      unknown: unknown.map(({ task }) => task),
      taskCount: matching.length,
    };
  }

  return {
    CAPACITY_MINUTES,
    DEFAULT_CAPACITY_HOURS,
    MIN_CAPACITY_HOURS,
    MAX_CAPACITY_HOURS,
    START_HOUR,
    STORAGE_KEY,
    build,
    capacityHoursForDay,
    setCapacityHoursForDay,
  };
});
