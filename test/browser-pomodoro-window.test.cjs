'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const { Controller } = require('../browser-pomodoro.js');

test('the browser Pomodoro popup is resized to compact dimensions on its first open', () => {
  const sizes = [];
  const retries = [];
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
    setTimeout: (callback, delay) => {
      retries.push({ callback, delay });
      return retries.length;
    },
    setInterval: () => 1,
    resizeTo: (width, height) => sizes.push([width, height]),
  };
  const controller = new Controller();
  controller.win = popup;
  controller.compact = true;
  controller.renderMode = () => {};
  controller.draw = () => {};

  controller.mount();

  assert.deepEqual(sizes, [[180, 156]]);
  assert.deepEqual(retries.map(({ delay }) => delay), [120, 480]);
  retries.forEach(({ callback }) => callback());
  assert.deepEqual(sizes, [[180, 156], [180, 156], [180, 156]]);
});

test('the page loads the compact-window fix without a stale script cache key', () => {
  const html = fs.readFileSync(require('node:path').join(__dirname, '../ela-nov-paketleme-dynamic.html'), 'utf8');
  assert.match(html, /browser-pomodoro\.js\?v=1\.1\.65-compact-popup-retry-v2/);
});

test('a delayed compact resize does not shrink a window the user has expanded', () => {
  const retries = [];
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
    setTimeout: callback => (retries.push(callback), retries.length),
    setInterval: () => 1,
    resizeTo() {},
  };
  const controller = new Controller();
  controller.win = popup;
  controller.compact = true;
  controller.renderMode = () => {};
  controller.draw = () => {};

  controller.mount();
  controller.compact = false;
  let resizeCalls = 0;
  popup.resizeTo = () => resizeCalls++;
  retries.forEach(callback => callback());

  assert.equal(resizeCalls, 0);
});