const assert = require('node:assert/strict');
const { spawn } = require('node:child_process');
const net = require('node:net');
const path = require('node:path');
const { after, before, test } = require('node:test');

const root = __dirname;
let server;
let baseUrl;

async function freePort() {
  const listener = net.createServer();
  await new Promise((resolve, reject) => {
    listener.once('error', reject);
    listener.listen(0, '127.0.0.1', resolve);
  });
  const { port } = listener.address();
  await new Promise((resolve, reject) => listener.close(error => error ? reject(error) : resolve()));
  return port;
}

before(async () => {
  const port = await freePort();
  baseUrl = `http://127.0.0.1:${port}`;
  server = spawn(process.execPath, [path.join(root, 'server.js')], {
    cwd: root,
    env: { ...process.env, PORT: String(port) },
    stdio: 'ignore'
  });

  const deadline = Date.now() + 8000;
  while (Date.now() < deadline) {
    if (server.exitCode !== null) throw new Error(`Server exited with code ${server.exitCode}`);
    try {
      const response = await fetch(`${baseUrl}/api/health`);
      if (response.ok) return;
    } catch {}
    await new Promise(resolve => setTimeout(resolve, 100));
  }
  throw new Error('Server did not start within 8 seconds');
});

after(() => {
  if (server && server.exitCode === null) server.kill('SIGTERM');
});

test('health endpoint returns JSON and security headers', async () => {
  const response = await fetch(`${baseUrl}/api/health`);
  assert.equal(response.status, 200);
  assert.equal(response.headers.get('x-content-type-options'), 'nosniff');
  assert.equal(response.headers.get('x-frame-options'), 'DENY');
  assert.equal(response.headers.get('referrer-policy'), 'strict-origin-when-cross-origin');
  assert.deepEqual(await response.json().then(({ ok }) => ({ ok })), { ok: true });
});

test('the app shell is served with security headers', async () => {
  const response = await fetch(`${baseUrl}/`);
  assert.equal(response.status, 200);
  assert.match(response.headers.get('content-type') || '', /text\/html/);
  assert.equal(response.headers.get('x-content-type-options'), 'nosniff');
  assert.match(await response.text(), /Ela Nov Paketleme|ADIB/i);
});

test('the Android mobile mode menu stays open after tapping its More button', async () => {
  const response = await fetch(`${baseUrl}/`);
  const html = await response.text();
  assert.match(html, /!event\.target\.closest\?\.\('#miroMobileMore'\)/);
  assert.match(html, /\.adib-nav-dock\.open #adibNavMenu\{display:grid!important/);
  assert.match(html, /adib-native-android/);
  assert.doesNotMatch(html, /data-adib-nav-mode="search" role="menuitem"/);
  assert.match(html, /miro-header-persistent-in-kanban-matrix/);
  assert.match(html, /@media\(max-width:1100px\), \(orientation:portrait\)\{\s*\n  :root\{--miro-mobile-ink/);
  assert.match(html, /#mobileNav\{display:none!important\}/);
  assert.match(html, /\.personal-kanban-modal,\.personal-eisenhower-modal\{\s*z-index:140!important/);
  assert.match(html, /syncMiroTaskViewHeader/);
  for (const id of ['miroMobileSearch', 'miroMobileAdd', 'miroMobileList', 'miroMobileFilter', 'miroMobileMore']) {
    assert.equal((html.match(new RegExp(`id=\"${id}\"`, 'g')) || []).length, 1, `${id} should appear exactly once in the shared toolbar`);
  }
  assert.match(html, /bindMobileTap\(listButton/);
  assert.match(html, /bindMobileTap\(filterButton/);
  assert.match(html, /kanban-view-mode-button/);
  assert.match(html, /personal-kanban-view-mode-button/);
  assert.match(html, /miroMobileList/);
  assert.match(html, /miroMobileFilter/);
  assert.match(html, /aria-pressed=\"false\"><svg viewBox=\"0 0 24 24\" aria-hidden=\"true\"><circle cx=\"4\"/);
  assert.doesNotMatch(html, /moveTaskViewActionToMiroHeader\(active,'\.personal-kanban-board-exit'/);
  assert.doesNotMatch(html, /moveTaskViewActionToMiroHeader\(active,'\.personal-kanban-close'/);
  assert.doesNotMatch(html, /moveTaskViewActionToMiroHeader\(active,'\.personal-eisenhower-close'/);
  assert.doesNotMatch(html, /moveTaskViewActionToMiroHeader\(active/);
  assert.doesNotMatch(html, /addTaskViewToolbarButton\(active/);
  assert.match(html, /button\[aria-pressed=\"true\"\],\.miro-mobile-actions button\[aria-expanded=\"true\"\]/);
  assert.match(html, /personal-kanban-modal \.personal-kanban-head,\s*\.personal-eisenhower-modal \.personal-eisenhower-head\{display:none!important\}/);
  assert.match(html, /body:has\(\.personal-kanban-modal\) \.brandline #miroMobileTitle/);
  assert.match(html, /personal-kanban-modal\.personal-kanban-filter-open \.personal-kanban-viewbar/);
});

test('the PWA manifest exposes the quick-add task shortcut', async () => {
  const response = await fetch(`${baseUrl}/manifest.webmanifest`);
  assert.equal(response.status, 200);
  const manifest = await response.json();
  const shortcut = manifest.shortcuts?.find(item => item.url.includes('action=quick-add-task'));
  assert.ok(shortcut, 'quick-add task shortcut should be available to installed Android PWAs');
  assert.match(shortcut.name, /задач/i);
});

test('unknown routes return JSON 404', async () => {
  const response = await fetch(`${baseUrl}/not-a-route`);
  assert.equal(response.status, 404);
  assert.equal(response.headers.get('x-content-type-options'), 'nosniff');
  assert.deepEqual(await response.json(), { error: 'Not found' });
});