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

test('the selected mobile Miro shell is used on desktop too', async () => {
  const response = await fetch(`${baseUrl}/`);
  const html = await response.text();
  assert.match(html, /<style class="miro-mobile-workspace-skin">\s*@media \(min-width:0px\)/);
  assert.match(html, /<style class="miro-mobile-shell-all-viewports">[\s\S]*?\.canvas-toolbar\{display:none!important\}/);
  assert.match(html, /const useMiroMobileShell=true/);
  assert.match(html, /const mobileSearchMedia=window\.matchMedia\('\(min-width:0px\)'\)/);
  assert.doesNotMatch(html, /class="miro-workspace-skin">\s*@media/);
});

test('Kanban columns stay in one horizontal row on desktop', async () => {
  const response = await fetch(`${baseUrl}/`);
  const html = await response.text();
  assert.match(html, /desktop-kanban-multicolumn-fix/);
  assert.match(html, /\.personal-kanban-modal \.personal-kanban-board\{\s*display:flex!important;\s*flex-flow:row nowrap!important;/);
  assert.match(html, /\.personal-kanban-modal \.personal-kanban-column\{\s*flex:0 0 300px!important/);
  assert.match(html, /\.modal-backdrop\.open\.kanban-modal \.kanban-board\{\s*display:flex!important;\s*flex-flow:row nowrap!important;/);
  assert.match(html, /\.modal-backdrop\.open\.kanban-modal \.kanban-column\{\s*flex:0 0 300px!important/);
});

test('the shared toolbar is light on desktop and includes hierarchy back', async () => {
  const response = await fetch(`${baseUrl}/`);
  const html = await response.text();
  assert.match(html, /class="miro-mobile-actions"[^>]*><button id="backHierarchy"[^>]*title="Подняться на уровень выше"/);
  assert.doesNotMatch(html, /class="canvas-toolbar"><button id="backHierarchy"/);
  assert.match(html, /class="desktop-service-light-toolbar"/);
  assert.match(html, /\.compact-top\{[\s\S]*?background:#fff!important/);
  assert.match(html, /document\.getElementById\('backHierarchy'\)\.onclick=/);
  assert.match(html, /if\(!current\?\.parentId\)return;state\.currentPlan=current\.parentId/);
});

test('equipment Kanban uses the shared toolbar instead of its separate heading', async () => {
  const response = await fetch(`${baseUrl}/`);
  const html = await response.text();
  assert.match(html, /\.personal-eisenhower-modal,\.modal-backdrop\.open\.kanban-modal/);
  assert.match(html, /id="miroMobileList"/);
  assert.match(html, /id="miroMobileFilter"/);
  assert.doesNotMatch(html, /moveTaskViewActionToMiroHeader\(active,'#closeModal','Закрыть канбан','×'\)/);
  assert.match(html, /body:has\(#taskModal\.kanban-modal\.open\) \.brandline #miroMobileTitle/);
  assert.match(html, /#taskModal\.kanban-modal>\.modal>\.modal-head\{display:none!important\}/);
  assert.match(html, /#taskModal\.kanban-modal\.miro-actions-in-header #kanbanNewTask\{display:none!important\}/);
  assert.match(html, /equipmentKanban\)\{document\.getElementById\('kanbanNewTask'\)\?\.click\(\);return\}/);
});

test('choosing Kanban waits for personal tasks and keeps its board open', async () => {
  const response = await fetch(`${baseUrl}/`);
  const html = await response.text();
  assert.match(html, /else if\(mode==='kanban'\)\{adibCloseNavigationOverlays\(\);Promise\.resolve\(setPersonalMode\(true\)\)\.then/);
  assert.match(html, /if\(!document\.querySelector\('\.personal-kanban-modal'\)\)\{openPersonalKanbanTool\(\);syncMiroTaskViewHeader\(\)\}/);
  assert.match(html, /const adibProgrammaticHashes=new Set\(\)/);
  assert.match(html, /if\(changedHash&&adibProgrammaticHashes\.has\(changedHash\)\)\{adibProgrammaticHashes\.delete\(changedHash\);return\}/);
});

test('navigation from equipment Kanban clears both backdrop and inner Kanban state', async () => {
  const response = await fetch(`${baseUrl}/`);
  const html = await response.text();
  assert.match(html, /taskModal\.classList\.remove\('open','kanban-modal'\)/);
  assert.match(html, /taskModal\.querySelector\('\.modal'\)\?\.classList\.remove\('kanban-modal'\)/);
  assert.match(html, /delete taskModal\.dataset\.planBoardId/);
});

test('Kanban mode avoids page-wide mutation observer loops and refreshes shared controls directly', async () => {
  const response = await fetch(`${baseUrl}/`);
  const html = await response.text();
  assert.doesNotMatch(html, /miroTaskViewHeaderObserver\.observe\(document\.body/);
  assert.doesNotMatch(html, /new MutationObserver\(syncTitle\)\.observe\(document\.body/);
  assert.match(html, /miroTaskViewHeaderSyncing/);
  assert.match(html, /window\.__syncMiroTaskViewHeader=syncMiroTaskViewHeader/);
});

test('Kanban rendering is bounded and extra tasks can be loaded incrementally', async () => {
  const response = await fetch(`${baseUrl}/`);
  const html = await response.text();
  assert.match(html, /renderLimit=240/);
  assert.match(html, /visibleTasksForRender=filtered\.slice\(0,renderLimit\)/);
  assert.match(html, /loadMoreButton\.addEventListener\('click',\(\)=>\{renderLimit\+=240;render\(\)\}\)/);
  assert.match(html, /kanbanRenderLimit=240/);
  assert.match(html, /kanbanLoadMore\.onclick=\(\)=>\{kanbanRenderLimit\+=240;renderKanban\(machine\)\}/);
});

test('Escape cancels an active canvas drag or undoes its last completed move', async () => {
  const response = await fetch(`${baseUrl}/`);
  const html = await response.text();
  assert.match(html, /let lastCanvasUndo=null/);
  assert.match(html, /function cancelActiveCanvasEdit\(\)/);
  assert.match(html, /function undoLastCanvasAction\(\)/);
  assert.match(html, /function handleCanvasEscapeUndo\(event\)/);
  assert.match(html, /document\.addEventListener\('keydown',handleCanvasEscapeUndo,true\)/);
  assert.match(html, /lastCanvasUndo=\{id:a\.id,kind:drag\.kind,before:\{\.\.\.before\}/);
  assert.match(html, /showCanvasUndoToast\('Последнее действие отменено'\)/);
});

test('the mode navigation popup has a light background and readable active state', async () => {
  const response = await fetch(`${baseUrl}/`);
  const html = await response.text();
  assert.match(html, /adib-light-mode-menu/);
  assert.match(html, /#adibNavMenu\.adib-nav-menu\{background:#fff!important/);
  assert.match(html, /button\.active\{background:#eaf2ff!important\}/);
});

test('Back, list, and filter actions are always present in the shared toolbar', async () => {
  const response = await fetch(`${baseUrl}/`);
  const html = await response.text();
  assert.match(html, /id="backHierarchy"/);
  assert.match(html, /id="miroMobileList"[^>]*aria-label="Список"/);
  assert.match(html, /id="miroMobileFilter"[^>]*aria-label="Фильтр"/);
  assert.match(html, /id="miroMobileRefresh"[^>]*aria-label="Обновить"/);
  assert.match(html, /bindMobileTap\(headerRefreshButton/);
  assert.match(html, /window\.__refreshEquipmentData=\(\)=>refresh\(false,false\)/);
  assert.match(html, /window\.__refreshPersonalTasks=\(\)=>loadPersonalTasks\(\)/);
  assert.match(html, /personalEisenhowerSearch/);
  assert.match(html, /personal-kanban-filter-open/);
  assert.match(html, /opened\?\.classList\.add\('personal-kanban-filter-open'\)/);
  assert.match(html, /personal-eisenhower-filter-open/);
  assert.match(html, /button\[aria-pressed="true"\].*background:#4262ff!important/);
  assert.match(await (await fetch(`${baseUrl}/sw.js`)).text(), /adib-pwa-v8-back-button-open-modal/);
  assert.match(html, /bindMobileTap\(headerListButton,switchToList\)/);
  assert.match(html, /bindMobileTap\(headerFilterButton,openHeaderFilters\)/);
  assert.match(html, /bindMobileTap\(headerBackButton/);
  assert.doesNotMatch(html, /body:has\(#personalMode:not\(\[hidden\]\)\) #backHierarchy/);
  assert.match(html, /const args=personalKanban\.__personalKanbanArgs\|\|\{\},parentId=args\.parentId,containerId=args\.containerId/);
  assert.match(html, /taskDialogOpen=document\.getElementById\('taskModal'\)\?\.classList\.contains\('open'\)/);
  assert.match(html, /const taskModal=document\.getElementById\('taskModal'\);if\(currentEquipmentKanban\(\)\|\|taskModal\?\.classList\.contains\('open'\)\)/);
  assert.match(html, /if\(parentContainer\)\{personalKanban\.remove\(\);openPersonalKanban/);
  assert.match(html, /focused\?\.parentId\)setPersonalFocus\(focused\.parentId\)/);
  assert.match(html, /background:#4262ff!important;color:#fff!important;opacity:1!important;border:1px solid #bfd0ff!important/);
  assert.doesNotMatch(html, /#miroMobileList\[aria-pressed=\"true\"\],\.miro-mobile-actions #miroMobileFilter\[aria-pressed=\"true\"\]\{background:#ffffff24/);
  assert.doesNotMatch(html, /moveTaskViewActionToMiroHeader\(active,'\.personal-kanban-view-mode-button'/);
  assert.doesNotMatch(html, /addTaskViewToolbarButton\(active,'Фильтры Kanban'/);
});

test('the Android mobile mode menu stays open after tapping its More button', async () => {
  const response = await fetch(`${baseUrl}/`);
  const html = await response.text();
  assert.match(html, /!event\.target\.closest\?\.\('#miroMobileMore'\)/);
  assert.match(html, /\.adib-nav-dock\.open #adibNavMenu\{display:grid!important/);
  assert.match(html, /adib-native-android/);
  assert.doesNotMatch(html, /data-adib-nav-mode="search" role="menuitem"/);
  assert.doesNotMatch(html, /data-adib-nav-mode="kanban" role="menuitem"/);
  assert.doesNotMatch(html, /data-adib-ai-open="1" role="menuitem"/);
  assert.match(html, /miro-header-persistent-in-kanban-matrix/);
  assert.match(html, /\.personal-kanban-modal,\.personal-eisenhower-modal\{\s*z-index:140!important/);
  assert.match(html, /syncMiroTaskViewHeader/);
  assert.match(html, /moveTaskViewActionToMiroHeader/);
  assert.doesNotMatch(html, /moveTaskViewActionToMiroHeader\(active,'\.personal-kanban-board-exit'/);
  assert.doesNotMatch(html, /moveTaskViewActionToMiroHeader\(active,'\.personal-kanban-close'/);
  assert.doesNotMatch(html, /moveTaskViewActionToMiroHeader\(active,'\.personal-eisenhower-close'/);
  assert.match(html, /miro-mobile-actions>\.miro-mobile-mode-action/);
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