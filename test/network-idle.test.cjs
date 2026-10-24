const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { NetworkIdle, DEFAULT_IDLE_MS } = require('../network-idle');
const {appHtml}=require('./helpers/app-html.cjs');

class Target {
  constructor() { this.listeners = new Map(); }
  addEventListener(type, fn) { const set = this.listeners.get(type) || new Set(); set.add(fn); this.listeners.set(type, set); }
  removeEventListener(type, fn) { this.listeners.get(type)?.delete(fn); }
  dispatchEvent(event) { for (const fn of this.listeners.get(event.type) || []) fn(event); }
}
function fixture({ busy = () => false, hidden = false } = {}) {
  let now = 0, nextId = 0;
  const timers = new Map(), states = [];
  const window = new Target(); window.CustomEvent = class { constructor(type, options) { this.type = type; this.detail = options.detail; } };
  window.setTimeout = (fn, delay) => { const id = ++nextId; timers.set(id, { at: now + delay, fn }); return id; };
  window.clearTimeout = id => timers.delete(id);
  const document = new Target(); document.hidden = hidden;
  const ctl = new NetworkIdle({ window, document, idleMs: DEFAULT_IDLE_MS, isBusy: busy, now: () => now, onState: state => states.push(state) }).start();
  function advance(ms) {
    const end = now + ms;
    while (true) {
      const item = [...timers].sort((a,b) => a[1].at-b[1].at)[0];
      if (!item || item[1].at > end) break;
      now = item[1].at; timers.delete(item[0]); item[1].fn();
    }
    now = end;
  }
  return { ctl, document, window, states, advance, get now() { return now; } };
}

test('network clients suspend after the requested ten minutes and wake on interaction', () => {
  const f = fixture();
  assert.equal(DEFAULT_IDLE_MS, 10 * 60 * 1000);
  assert.equal(f.ctl.isIdle(), false);
  f.advance(DEFAULT_IDLE_MS - 1);
  assert.equal(f.ctl.isIdle(), false);
  f.advance(1);
  assert.equal(f.ctl.isIdle(), true);
  assert.equal(f.states.at(-1).reason, 'timeout');
  f.document.dispatchEvent({ type: 'pointerdown' });
  assert.equal(f.ctl.isIdle(), false);
  assert.equal(f.states.at(-1).reason, 'input');
  f.ctl.destroy();
});

test('running work or Pomodoro activity postpones network suspension', () => {
  let busy = true;
  const f = fixture({ busy: () => busy });
  f.advance(DEFAULT_IDLE_MS);
  assert.equal(f.ctl.isIdle(), false);
  busy = false;
  f.advance(60000);
  assert.equal(f.ctl.isIdle(), true);
  f.ctl.destroy();
});

test('background tabs suspend promptly and resume with a fresh network session', () => {
  const f = fixture();
  f.document.hidden = true;
  f.document.dispatchEvent({ type: 'visibilitychange' });
  assert.equal(f.ctl.isIdle(), true);
  f.document.hidden = false;
  f.document.dispatchEvent({ type: 'visibilitychange' });
  assert.equal(f.ctl.isIdle(), false);
  assert.equal(f.states.at(-1).reason, 'visible');
  f.ctl.destroy();
});

test('destroy removes listeners and clears pending timers', () => {
  const f = fixture();
  f.ctl.destroy();
  assert.equal(f.document.listeners.get('pointerdown')?.size || 0, 0);
  f.advance(DEFAULT_IDLE_MS * 2);
  assert.equal(f.states.length, 0);
});

test('recurring data clients pause while idle and the device clock makes no network requests', () => {
  const html = appHtml();
  const time = fs.readFileSync(path.join(__dirname, '..', 'network-time.js'), 'utf8');
  const account = fs.readFileSync(path.join(__dirname, '..', 'account-client.js'), 'utf8');
  const work = fs.readFileSync(path.join(__dirname, '..', 'work-timer-ui.js'), 'utf8');
  assert.match(html, /window\.ADIBIdle\?\.isIdle\?\.\(\).*fetchChatThreads\(\)/);
  assert.match(html, /const shouldAutoSync=.*!window\.ADIBIdle\?\.isIdle\?\.\(\)/);
  assert.match(html, /window\.addEventListener\('adib-network-idle',resume\)/);
  assert.match(time, /function now\(\)\s*\{\s*return Date\.now\(\);?\s*\}/);
  assert.doesNotMatch(time, /fetch\(|\/api\/time|network-only/);
  assert.match(account, /root\.ADIBIdle\?\.isIdle\?\.\(\)\)return/);
  assert.match(work, /root\.ADIBIdle\?\.isIdle\?\.\(\).*refresh/);
});
