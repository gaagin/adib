'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const { Controller } = require('../browser-pomodoro.js');

test('the browser Pomodoro popup is resized to compact dimensions on its first open', () => {
  const sizes = [];
  const popup = {
    closed: false,
    outerWidth: 440,
    innerWidth: 420,
    outerHeight: 540,
    innerHeight: 480,
    document: {
      title: '',
      documentElement: {},
      body: { replaceChildren() {} },
      head: { append() {} },
      createElement: () => ({}),
    },
    addEventListener() {},
    setInterval: () => 1,
    resizeTo: (width, height) => sizes.push([width, height]),
  };
  const controller = new Controller();
  controller.win = popup;
  controller.compact = true;
  controller.renderMode = () => {};
  controller.draw = () => {};

  controller.mount();

  assert.deepEqual(sizes, [[100, 104]]);
});

test('the page loads the compact-window fix without a stale script cache key', () => {
  const html = fs.readFileSync(require('node:path').join(__dirname, '../ela-nov-paketleme-dynamic.html'), 'utf8');
  assert.match(html, /browser-pomodoro\.js\?v=1\.1\.65-compact-initial-size-v1/);
});