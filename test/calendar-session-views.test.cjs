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

test('Gündəm agenda is available and remains selectable on mobile', () => {
  assert.doesNotMatch(js, /if\(!desktopCalendar\(\)&&\['year','agenda'\]\.includes\(view\)\)view='month'/);
  assert.match(js, /desktopCalendar\(\)\?\[\['month','Ay'\],\['week','Həftə'\],\['year','İl'\],\['day','Gün'\],\['agenda','Gündəm'\]\]:\[\['month','Ay'\],\['week','Həftə'\],\['three','3 gün'\],\['day','Gün'\],\['agenda','Gündəm'\]\]/);
});

test('agenda time column displays both ends of each timed interval', () => {
  assert.match(line('function renderAgenda('), /T\.time\(item\.start\)\+'–'\+T\.time\(item\.end\)/);
});

test('calendar weekday strip is compact while day controls remain touch-friendly', () => {
  assert.match(css, /calendar-header-day\{[^}]*height:58px!important/);
  assert.match(css, /calendar-header-number\{[^}]*width:28px;height:28px/);
  assert.match(css, /calendar-header-weekday\{font-size:11px;line-height:14px/);
});

test('three-day mode uses the same native horizontal scroller as day and week', () => {
  assert.match(css, /data-view=week\],\.adib-calendar-grid\[data-view=three\],\.adib-calendar-grid\[data-view=day\]/);
  assert.match(css, /-webkit-overflow-scrolling:touch/);
  assert.match(css, /scroll-behavior:smooth/);
  assert.match(css, /touch-action:pan-x pan-y/);
});

test('touch scrolls over task cards while task dragging uses its own grip', () => {
  assert.match(css, /\.calendar-time-event\{[^}]*touch-action:pan-x pan-y/);
  assert.match(css, /\.calendar-time-event,\.calendar-time-event \.calendar-event-title,\.calendar-time-event \.calendar-event-time\{[^}]*touch-action:pan-x pan-y/);
  assert.match(css, /\.calendar-touch-drag-handle\{display:none\}/);
  assert.match(css, /@media\(pointer:coarse\)[\s\S]*?\.calendar-touch-drag-handle\{[^}]*touch-action:none/);
  assert.match(line('function timedEvent('), /move\.dataset\.calendarDrag='move'/);
  assert.match(line('function beginGesture('), /e\.pointerType==='touch'&&!resizeTarget&&!touchDrag\)return/);
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

test('background sync waits for scroll idle and preserves each month cell scroll position', () => {
  assert.match(line('function scheduleCalendarDataRefresh('), /lastCalendarScrollAt/);
  assert.match(line('function scheduleCalendarDataRefresh('), /if\(gesture\)/);
  assert.match(line('function queueCalendarDataRefresh('), /scheduleCalendarDataRefresh\(\)/);
  assert.match(line('function render('), /cellScroll=new Map/);
  assert.match(line('function render('), /cell\.scrollTop=saved\.top/);
  assert.match(line('function render('), /cell\.scrollLeft=saved\.left/);
  assert.match(js, /host\.addEventListener\('scroll',event=>\{if\(grid\?\.contains\(event\.target\)\)/);
});
