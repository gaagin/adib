const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const vm = require('node:vm');
const T = require('../calendar-time');

const js = fs.readFileSync(path.join(__dirname, '..', 'calendar-view.js'), 'utf8');
const css = fs.readFileSync(path.join(__dirname, '..', 'calendar-view.css'), 'utf8');
const line = prefix => {
  const result = js.split(/\r?\n/).find(value => value.startsWith(prefix));
  assert.ok(result, `missing ${prefix}`);
  return result;
};

test('Pomodoro sessions are included in day, three-day, and week modes', () => {
  const helper = line('function calendarPomodoroSessions(');
  for (const view of ['day', 'three', 'week']) {
    const session = { id: 'pomodoro-session', sessionKind: 'pomodoro' };
    const context = vm.createContext({
      advancedFilters: { display: 'tasks' }, view,
      root: { ADIBSessions: { calendar: () => [session] } },
      currentFilters: () => ({}),
    });
    vm.runInContext(helper, context);
    assert.equal(context.calendarPomodoroSessions().length, 1, `${view} should include Pomodoro sessions`);
  }
});

test('a Pomodoro interval segments into all time-based views', () => {
  const task = {
    id: 'pomodoro:1', workSession: { status: 'saved' },
    date: '2026-10-13T09:00:00+04:00', dateEnd: '2026-10-13T09:25:00+04:00',
  };
  const views = {
    day: ['2026-10-13'],
    three: ['2026-10-12', '2026-10-13', '2026-10-14'],
    week: ['2026-10-12', '2026-10-13', '2026-10-14', '2026-10-15', '2026-10-16', '2026-10-17', '2026-10-18'],
  };
  for (const [view, dates] of Object.entries(views)) {
    const segments = dates.flatMap(day => T.segments(task, [day]));
    assert.equal(segments.length, 1, `${view} should render the session once`);
    assert.equal(segments[0].duration, 25);
  }
});

test('three-day mode uses the same native horizontal scroller as day and week', () => {
  assert.match(css, /data-view=week\],\.adib-calendar-grid\[data-view=three\],\.adib-calendar-grid\[data-view=day\]/);
  assert.match(css, /-webkit-overflow-scrolling:touch/);
  assert.match(css, /scroll-behavior:smooth/);
  assert.match(css, /touch-action:pan-x pan-y/);
});

test('horizontal position survives calendar rerenders and touch swipes are not intercepted', () => {
  assert.match(line('function render('), /previousScrollLeft=grid\.scrollLeft/);
  assert.match(line('function render('), /grid\.scrollLeft=targetScrollLeft/);
  const bindStart = js.indexOf('function bindScale(');
  const bindEnd = js.indexOf('function currentFilters(', bindStart);
  const bind = js.slice(bindStart, bindEnd);
  assert.ok(bindStart >= 0 && bindEnd > bindStart, 'bindScale source should be present');
  assert.doesNotMatch(bind, /let swipe=null/);
});
