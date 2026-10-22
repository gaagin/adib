'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const root = path.join(__dirname, '..');
const js = fs.readFileSync(path.join(root, 'calendar-view.js'), 'utf8');
const css = fs.readFileSync(path.join(root, 'calendar-view.css'), 'utf8');
const html = fs.readFileSync(path.join(root, 'ela-nov-paketleme-dynamic.html'), 'utf8');

test('day-plan add button is a fixed panel footer outside the scrolling timeline', () => {
  assert.match(js, /panel\.append\(header,body,footer\)/);
  assert.match(js, /footer\.replaceChildren\(add\);body\.replaceChildren\(content\)/);
  assert.doesNotMatch(js, /content\.append\(footer\)/);
  assert.match(css, /\.calendar-day-plan-body\{[^}]*flex:1 1 auto;min-height:0;[^}]*overflow:auto/);
  assert.match(css, /\.calendar-day-plan-footer\{flex:0 0 auto;position:relative;z-index:5/);
  assert.match(css, /\.calendar-day-plan-panel\{[^}]*height:min\(92dvh,980px\)/);
  assert.match(css, /@media\(max-width:700px\)[\s\S]*?\.calendar-day-plan-panel\{width:100%;height:94dvh;max-height:94dvh/);
});

test('calendar assets use refreshed cache keys for the day-plan layout', () => {
  assert.match(html, /calendar-view\.css\?v=calendar-touch-scroll-v1/);
  assert.match(html, /calendar-view\.js\?v=1\.1\.68-touch-scroll-v1/);
});