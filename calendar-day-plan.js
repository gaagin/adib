(function (root, factory) {
  const api = factory();
  if (typeof module === "object" && module.exports) module.exports = api;
  else root.ADIBDayPlan = api;
})(typeof window === "object" ? window : globalThis, function () {
  "use strict";

  const START_HOUR = 9;
  const END_HOUR = 18;
  const START_MINUTE = START_HOUR * 60;
  const END_MINUTE = END_HOUR * 60;
  const CAPACITY_MINUTES = END_MINUTE - START_MINUTE;

  function clamp(value, min, max) {
    return Math.max(min, Math.min(max, value));
  }

  // The timeline's zero is 09:00; elapsedMinutes is the offset from that point.
  function workWindow(day, today, minuteOfDay) {
    let elapsedMinutes = 0;
    let state = "future";
    if (typeof day !== "string" || !day || typeof today !== "string" || !today) {
      state = "unknown";
    } else if (day < today) {
      elapsedMinutes = CAPACITY_MINUTES;
      state = "past";
    } else if (day === today) {
      const nowMinute = Number.isFinite(Number(minuteOfDay))
        ? Number(minuteOfDay)
        : START_MINUTE;
      elapsedMinutes = Math.floor(clamp(nowMinute - START_MINUTE, 0, CAPACITY_MINUTES));
      state =
        nowMinute < START_MINUTE
          ? "before"
          : nowMinute >= END_MINUTE
            ? "after"
            : "today";
    }

    return {
      startHour: START_HOUR,
      endHour: END_HOUR,
      totalMinutes: CAPACITY_MINUTES,
      elapsedMinutes,
      startMinute: elapsedMinutes,
      capacityMinutes: CAPACITY_MINUTES - elapsedMinutes,
      state,
    };
  }

  function build(tasks, day, options = {}) {
    const dayKey = options.dayKey || (() => "");
    const isVisible = options.isVisible || (() => true);
    const isDone = options.isDone || (() => false);
    const dayCapacityMinutes = Number.isInteger(options.totalCapacityMinutes)
      ? Math.max(0, options.totalCapacityMinutes)
      : Number.isInteger(options.capacityMinutes)
        ? Math.max(0, options.capacityMinutes)
        : CAPACITY_MINUTES;
    const startMinute = Number.isInteger(options.startMinute)
      ? clamp(options.startMinute, 0, dayCapacityMinutes)
      : 0;
    const capacityMinutes = Math.max(0, dayCapacityMinutes - startMinute);
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

    let cursor = startMinute;
    const blocks = known.map((row) => {
      const start = cursor;
      cursor += row.minutes;
      return {
        task: row.task,
        minutes: row.minutes,
        start,
        end: cursor,
        visibleMinutes: Math.max(0, Math.min(cursor, dayCapacityMinutes) - start),
        overflowMinutes: Math.max(
          0,
          cursor - Math.max(start, dayCapacityMinutes),
        ),
      };
    });
    const totalMinutes = cursor - startMinute;
    const overflow = blocks.filter((block) => block.end > dayCapacityMinutes);
    const firstOverflow =
      overflow[0]?.task ||
      (capacityMinutes > 0 && totalMinutes >= capacityMinutes
        ? blocks.at(-1)?.task
        : null) ||
      null;

    return {
      day,
      dayCapacityMinutes,
      startMinute,
      capacityMinutes,
      totalMinutes,
      freeMinutes: Math.max(0, capacityMinutes - totalMinutes),
      filledMinutes: Math.min(capacityMinutes, totalMinutes),
      full: capacityMinutes === 0 || totalMinutes >= capacityMinutes,
      overflowMinutes: Math.max(0, totalMinutes - capacityMinutes),
      blocks,
      overflow,
      firstOverflow,
      unknown: unknown.map(({ task }) => task),
      taskCount: matching.length,
    };
  }

  return {
    START_HOUR,
    END_HOUR,
    START_MINUTE,
    END_MINUTE,
    CAPACITY_MINUTES,
    workWindow,
    build,
  };
});