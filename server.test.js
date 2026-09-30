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

test('task context menus can start Pomodoro for personal and equipment tasks', async () => {
  const html = await (await fetch(`${baseUrl}/`)).text();
  assert.match(html, /if\(target\.kind==='equipment-task'\)[\s\S]*?adibContextItem\('start-pomodoro','Запустить Pomodoro'/);
  assert.match(html, /if\(action==='start-pomodoro'\)\{openPersonalPomodoro\(target\.id\);return\}/);
  assert.match(html, /function pomodoroTaskById\(id\)[\s\S]*?state\.equipment\.flatMap/);
});

test('task lists offer persistent sorting by task properties', async () => {
  const html = await (await fetch(`${baseUrl}/`)).text();
  assert.match(html, /id="personalKanbanSortBy"/);
  assert.match(html, /id="personalKanbanSortDirection"/);
  assert.match(html, /id="kanbanSortBy"/);
  assert.match(html, /id="kanbanSortDirection"/);
  assert.match(html, /ADIB_TASK_SORT_OPTIONS=.*Prioritet/);
  assert.match(html, /localStorage\.setItem\('adib-task-sort-key'/);
  assert.match(html, /adibSortTaskItems\(personalKanbanTasks\.filter/);
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
  assert.match(await (await fetch(`${baseUrl}/sw.js`)).text(), /adib-pwa-v30-desktop-container-grid/);
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

test('mobile shared toolbar uses the approved two-row layout with grouped view controls', async () => {
  const response = await fetch(`${baseUrl}/`);
  const html = await response.text();
  assert.match(html, /class="adib-mobile-toolbar-two-row"/);
  assert.match(html, /grid-template-areas:"brand brand brand brand add more" "back refresh search view filter chat"/);
  assert.match(html, /header\.compact-top \.top-toolbar>\.miro-mobile-actions\{display:contents!important\}/);
  assert.match(html, /#miroMobileList\{grid-area:view!important\}/);
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


test('right-clicking empty space in either Kanban opens the grouping picker', async () => {
  const html = await (await fetch(`${baseUrl}/`)).text();
  assert.match(html, /contextmenu',event=>/);
  assert.match(html, /\.personal-kanban-modal \.personal-kanban-board,#taskModal\.kanban-modal \.kanban-board/);
  assert.match(html, /personalBoard\?\.querySelector\('#personalKanbanGroupBy'\)\|\|document\.querySelector\('#taskModal\.kanban-modal #kanbanGroupBy'\)/);
  assert.match(html, /adibKanbanGroupingContextMenu/);
  assert.match(html, /role=\"menuitemradio\"/);
  assert.match(html, /grouping\.dispatchEvent\(new Event\('change',\{bubbles:true\}\)\)/);
  assert.match(html, /event\.preventDefault\(\);event\.stopPropagation\(\)/);
});


test('the ADIB brand button opens extensible settings with theme and comment author controls', async () => {
  const html = await (await fetch(`${baseUrl}/`)).text();
  assert.match(html, /id="adibSettingsButton"[^>]*aria-controls="adibSettingsMenu"/);
  assert.match(html, /id="adibSettingsMenu"[^>]*hidden/);
  assert.match(html, /id="adibSettingsThemeHost"/);
  assert.match(html, /id="adibSettingsUserHost"/);
  assert.match(html, /id="adibSettingsAdditionalItems"/);
  assert.match(html, /settingsThemeHost\.appendChild\(themeControl\)/);
  assert.match(html, /settingsUserHost\.appendChild\(userControl\)/);
  assert.match(html, /settingsButton\?\.addEventListener\('click'/);
  assert.match(html, /button\.textContent=dark\?'☀ Светлая тема':'☾ Тёмная тема'/);
});


test('dark theme colors the shared header, canvas, matrix, and Kanban surfaces', async () => {
  const html = await (await fetch(`${baseUrl}/`)).text();
  assert.match(html, /html\.dark header\.compact-top\{background:#202020!important;color:#e9e9e7!important/);
  assert.match(html, /html\.dark body\{background-image:linear-gradient\(rgba\(230,230,230,\.055\)/);
  assert.match(html, /html\.dark \.personal-eisenhower-dialog,html\.dark \.personal-eisenhower-head/);
  assert.match(html, /html\.dark \.personal-kanban-dialog,html\.dark \.personal-kanban-head/);
  assert.match(html, /html\.dark \.kanban-board,html\.dark \.kanban-column/);
});


test('dark equipment canvas uses the same base tone inside and outside the SVG', async () => {
  const html = await (await fetch(`${baseUrl}/`)).text();
  assert.match(html, /html\.dark #plan,html\.dark \.canvas-wrap #plan\{background:#191919!important/);
  assert.match(html, /html\.dark #viewport>rect:first-child\{fill:#191919!important/);
  assert.match(html, /html\.dark #grid path\{stroke:#303030!important/);
});


test('online service opens My Tasks in list mode by default and keeps explicit routes intact', async () => {
  const html = await (await fetch(`${baseUrl}/`)).text();
  assert.match(html, /function openDefaultMyTasksList\(\)/);
  assert.match(html, /window\.__adibOpenDefaultMyTasksList=openDefaultMyTasksList/);
  assert.match(html, /hasExplicitStartupTarget=Boolean\(location\.hash[^;]*\);if\(!hasExplicitStartupTarget\)/);
  assert.match(html, /else if\(mode==='personal'\)\{adibCloseNavigationOverlays\(\);window\.__adibOpenDefaultMyTasksList\?\.\(\)\}/);
  assert.match(html, /ticktick-personal-list-global-style/);
});

test('mobile My Tasks containers open in list view while desktop remains Kanban', async () => {
  const html = await (await fetch(`${baseUrl}/`)).text();
  assert.match(html, /function openPersonalItem\(type,id\)\{if\(type==='container'\)\{const container=containerById\(id\);if\(container\)openPersonalKanban\(container\.name,personalTasksForContainer\(id\)\.filter\(task=>!task\.completed\),'',id,window\.matchMedia\('\(max-width:650px\)'\)\.matches\?'list':'kanban'\);return\}/);
  assert.match(html, /function openPersonalKanban\(title,tasks,parentId='',containerId='',initialView='kanban'\)/);
  assert.match(html, /viewMode=initialView==='list'\?'list':'kanban'/);
  assert.match(html, /if\(type==='container'\)\{personalLastTap=null;openPersonalItem\(type,id\);return\}/);
  assert.match(html, /data-focus-personal-container/);
});

test('mobile equipment and plan task boards start in list view', async () => {
  const html = await (await fetch(`${baseUrl}/`)).text();
  assert.match(html, /function openPlanTasks\(id\)\{if\(typeof setPersonalMode==='function'\)setPersonalMode\(false\);if\(window\.matchMedia\('\(max-width:650px\)'\)\.matches\)\{kanbanViewMode='list';window\.__adibKanbanViewMode='list'\}/);
  assert.match(html, /function openTasks\(id\)\{if\(typeof setPersonalMode==='function'\)setPersonalMode\(false\);if\(window\.matchMedia\('\(max-width:650px\)'\)\.matches\)\{kanbanViewMode='list';window\.__adibKanbanViewMode='list'\}/);
});

test('mobile checklist follows TickTick-style layout and marks overdue tasks', async () => {
  const html = await (await fetch(`${baseUrl}/`)).text();
  assert.match(html, /id="ticktick-mobile-list-style"/);
  assert.match(html, /function taskBoardDueLabel\(value\)/);
  assert.match(html, /days\+' '\+word\+' просрочено'/);
  assert.match(html, /class="kanban-check-due'\+\(overdue\?' overdue':''\)/);
  assert.match(html, /personal-kanban-check-due/);
});

test('My Tasks grouping uses the Prioritet property, not Priority', async () => {
  const html = await (await fetch(`${baseUrl}/`)).text();
  assert.match(html, /<option value=\"prioritet\">Prioritet<\/option>/);
  assert.doesNotMatch(html, /const groupOptions=.*?<option value=\"priority\">Priority<\/option>/);
  assert.match(html, /function personalTaskGroupValue\(task,key\).*?key==='prioritet'\)return task\.prioritet/);
  assert.match(html, /if\(groupBy==='prioritet'\)changes\.prioritet=/);
  assert.match(html, /if\(savedGroup==='priority'\)groupBy='prioritet'/);
});

test('dark theme uses dark high-contrast labels on light canvas elements', async () => {
  const html = await (await fetch(`${baseUrl}/`)).text();
  assert.match(html, /adib-dark-canvas-label-contrast/);
  assert.match(html, /html\.dark #viewport \.label\{fill:#263648!important\}/);
  assert.match(html, /html\.dark #viewport \.plan-label\{fill:#263648!important\}/);
  assert.match(html, /html\.dark #viewport \.small,html\.dark #viewport \.plan-sub\{fill:#536578!important\}/);
});

test('My Tasks canvas draws one zoom-aware grid and dark mode menu stays dark', async () => {
  const html = await (await fetch(`${baseUrl}/`)).text();
  assert.ok(html.includes('body:has(#personalMode:not([hidden])){background-image:none!important}'));
  assert.ok(html.includes('body:has(#personalMode:not([hidden])) #personalBoard{background-image:linear-gradient'));
  assert.ok(html.includes('html.dark #adibNavMenu.adib-nav-menu{background:#202020!important'));
  assert.ok(html.includes('html.dark #adibNavMenu.adib-nav-menu button:hover,html.dark #adibNavMenu.adib-nav-menu button.active{background:#34353b!important'));
});

test('the PWA manifest exposes the quick-add task shortcut', async () => {
  const response = await fetch(`${baseUrl}/manifest.webmanifest`);
  assert.equal(response.status, 200);
  const manifest = await response.json();
  const shortcut = manifest.shortcuts?.find(item => item.url.includes('action=quick-add-task'));
  assert.ok(shortcut, 'quick-add task shortcut should be available to installed Android PWAs');
  assert.match(shortcut.name, /задач/i);
});

test('task editors support due-date reminders with browser popup and sound', async () => {
  const html = await (await fetch(`${baseUrl}/`)).text();
  assert.match(html, /id="taskReminder"/);
  assert.match(html, /id="personalTaskReminder"/);
  assert.match(html, /function setTaskDateReminder/);
  assert.match(html, /function showTaskReminderPopup/);
  assert.match(html, /function playTaskReminderSound/);
  assert.match(html, /TASK_REMINDERS_KEY/);
});


test('comment chat is available in the shared web shell and gathers both task sources', async () => {
  const html = await (await fetch(`${baseUrl}/`)).text();
  assert.match(html, /id="miroMobileChat"/);
  assert.match(html, /data-adib-nav-mode="chat"/);
  assert.match(html, /function chatTaskCandidates\(personal=\[\]\)/);
  assert.match(html, /\/api\/chat-threads/);
  assert.match(html, /\/api\/task-comments/);
  assert.match(html, /Обсуждения задач/);
  assert.match(html, /data-chat-open-task/);
  assert.match(html, /function openChatTask\(taskId\)/);
  assert.match(html, /window\.__openPersonalChatTask=\(id,containerId=''/);
  assert.match(html, /openTaskEditor\(info\.task,info\.machine,false\)/);
  const serverSource = require('node:fs').readFileSync(path.join(root, 'server.js'), 'utf8');
  assert.match(serverSource, /request\.method === 'POST' && url\.pathname === '\/api\/chat-threads'/);
  assert.match(serverSource, /async function listChatThreads\(body\)/);
});


test('ilqar mamedov is the default comment author and appears before comment text', async () => {
  const html = await (await fetch(`${baseUrl}/`)).text();
  assert.match(html, /let currentUser=\{id:'',name:'ilqar mamedov'\}/);
  assert.match(html, /toLocaleLowerCase\(\)==='ilqar mamedov'/);
  assert.match(html, /comment-meta.*comment\.authorName/);
  const serverSource = require('node:fs').readFileSync(path.join(root, 'server.js'), 'utf8');
  assert.match(serverSource, /body\.authorName \|\| 'ilqar mamedov'/);
});

test('unknown routes return JSON 404', async () => {
  const response = await fetch(`${baseUrl}/not-a-route`);
  assert.equal(response.status, 404);
  assert.equal(response.headers.get('x-content-type-options'), 'nosniff');
  assert.deepEqual(await response.json(), { error: 'Not found' });
});