(function (root, factory) {
  const api = factory();
  if (typeof module === "object" && module.exports) module.exports = api;
  else root.ADIBDayPlan = api;
})(typeof window === "object" ? window : globalThis, function () {
  "use strict";

  const CAPACITY_MINUTES = 8 * 60;
  const START_HOUR = 8;

  function build(tasks, day, options = {}) {
    const dayKey = options.dayKey || (() => "");
    const isVisible = options.isVisible || (() => true);
    const isDone = options.isDone || (() => false);
    const capacityMinutes = Number.isInteger(options.capacityMinutes)
      ? Math.max(1, options.capacityMinutes)
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
      (cursor >= capacityMinutes ? blocks.at(-1)?.task : null) ||
      null;

    return {
      day,
      capacityMinutes,
      totalMinutes: cursor,
      freeMinutes: Math.max(0, capacityMinutes - cursor),
      filledMinutes: Math.min(capacityMinutes, cursor),
      full: cursor >= capacityMinutes,
      overflowMinutes: Math.max(0, cursor - capacityMinutes),
      blocks,
      overflow,
      firstOverflow,
      unknown: unknown.map(({ task }) => task),
      taskCount: matching.length,
    };
  }

  return { CAPACITY_MINUTES, START_HOUR, build };
});