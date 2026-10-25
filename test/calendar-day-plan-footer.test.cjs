'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const root = path.join(__dirname, '..');
const js = fs.readFileSync(path.join(root, 'calendar-view.js'), 'utf8');
const css = fs.readFileSync(path.join(root, 'calendar-view.css'), 'utf8');
const html = fs.readFileSync(path.join(root, 'ela-nov-paketleme-dynamic.html'), 'utf8');
const focusedViews = fs.readFileSync(path.join(root, 'focused-views.js'), 'utf8');

test('day-plan actions are a fixed panel footer outside the scrolling timeline', () => {
  assert.match(js, /panel\.append\(header,body,footer\)/);
  assert.match(js, /footer\.replaceChildren\(actions\)/);
  assert.match(js, /Tapşırıqlarımdan seç/);
  assert.match(js, /renderDayPlanPicker\(day,plan,content\)/);
  assert.match(js, /estimateMinutes:Number\(picker\.minutes\[id\]\)/);
  assert.doesNotMatch(js, /content\.append\(footer\)/);
  assert.match(css, /\.calendar-day-plan-body\{[^}]*flex:1 1 auto;min-height:0;[^}]*overflow:auto/);
  assert.match(css, /\.calendar-day-plan-footer\{flex:0 0 auto;position:relative;z-index:5/);
  assert.match(css, /\.calendar-day-plan-picker-list\{[^}]*max-height:260px;overflow:auto/);
  assert.match(css, /\.calendar-day-plan-panel\{[^}]*height:min\(92dvh,980px\)/);
  assert.match(css, /@media\(max-width:700px\)[\s\S]*?\.calendar-day-plan-panel\{width:100%;height:94dvh;max-height:94dvh/);
});

test('calendar assets use refreshed cache keys for the day-plan layout', () => {
  assert.match(html, /calendar-view\.css\?v=calendar-session-delete-v1-day-plan-pomo-shrink-v1/);
  assert.match(html, /calendar-day-plan\.js\?v=1\.1\.68-task-picker-v1-pomo-shrink-v1/);
  assert.match(html, /calendar-view\.js\?v=1\.1\.72-calendar-plus-equipment-v1/);
});

test('calendar plus creates an equipment task for non-admin accounts', () => {
  assert.match(js, /function equipmentOnlyCalendarUser\(\).*user\.role!=='admin'/);
  assert.ok(js.includes('function addCalendarTask(day,preset={})'));
  assert.ok(js.includes('newTask({date:day,...preset})'));
  assert.match(js, /button\('\+',\(\)=>addCalendarTask\(day\)\)/);
  assert.match(js, /button\('',\(\)=>addCalendarTask\(T\.key\(anchor\)\)\)/);
  assert.match(js, /addCalendarTask\(day,T\.slot\(day,minute\)\)/);
  assert.ok(html.includes('newTask:(preset={})=>{'));
  assert.ok(html.includes("sourceKey:'gorulen'"));
  assert.ok(html.includes('openTaskEditor(draft,null,true)'));
  assert.ok(js.includes('addTask:(day=T.key(anchor))=>addCalendarTask(day)'));
  assert.ok(html.includes("if(window.ADIBCalendar?.visible&&user&&user.role!=='admin'){window.ADIBCalendar.addTask?.();return}"));
  assert.ok(focusedViews.includes("if(user&&user.role!=='admin'){if(root.ADIBCalendar?.addTask)root.ADIBCalendar.addTask(date);else root.ADIBEquipmentCalendar?.newTask({date});return;}"));
});
