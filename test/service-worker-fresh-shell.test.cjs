'use strict';
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const vm = require('node:vm');

function loadWorker(networkFetch, cachedBody = 'cached-shell') {
  const handlers = new Map();
  const written = new Map();
  const cache = {
    async match() { return new Response(cachedBody, { headers: { 'Content-Type': 'text/html' } }); },
    async put(request, response) { written.set(request.url, await response.text()); },
    async keys() { return []; },
    async delete() { return true; }
  };
  const context = vm.createContext({
    self: {
      location: { origin: 'https://app.test' },
      clients: { claim: async () => {} },
      addEventListener(type, handler) { handlers.set(type, handler); }
    },
    caches: { open: async () => cache, keys: async () => ['adib-online-ui-shell-v1'], delete: async () => true },
    fetch: networkFetch,
    URL,
    Response,
    Set,
    Promise,
    console
  });
  vm.runInContext(fs.readFileSync(require.resolve('../sw.js'), 'utf8'), context);
  return { handlers, written };
}

function navigationEvent() {
  let responsePromise;
  const event = {
    request: { method: 'GET', mode: 'navigate', url: 'https://app.test/' },
    waitUntil() {},
    respondWith(promise) { responsePromise = promise; }
  };
  return { event, getResponse: () => responsePromise };
}

test('online navigation returns the freshly fetched shell instead of stale cache', async () => {
  const worker = loadWorker(async () => new Response('<html>fresh app shell</html>', {
    status: 200,
    headers: { 'Content-Type': 'text/html' }
  }));
  const nav = navigationEvent();
  worker.handlers.get('fetch')(nav.event);
  assert.equal(await (await nav.getResponse()).text(), '<html>fresh app shell</html>');
});

test('offline navigation falls back to the last cached shell', async () => {
  const worker = loadWorker(async () => { throw new Error('offline'); }, '<html>cached app shell</html>');
  const nav = navigationEvent();
  worker.handlers.get('fetch')(nav.event);
  assert.equal(await (await nav.getResponse()).text(), '<html>cached app shell</html>');
});

test('service worker uses a new shell cache namespace to discard stale app HTML', () => {
  const source = fs.readFileSync(require.resolve('../sw.js'), 'utf8');
  assert.match(source, /SHELL_CACHE_NAME='adib-online-ui-shell-v2'/);
});