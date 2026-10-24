const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const {appHtml}=require('./helpers/app-html.cjs');

const read = name => fs.readFileSync(path.join(__dirname, '..', name), 'utf8');
const server = read('server.js');
const app = appHtml();
const env = read('env.example');

test('task app deep links default to the Notion URL property and equipment keeps its own property', () => {
  assert.match(server, /const TASK_LINK_PROPERTY_DEFAULT = 'URL'/);
  assert.match(server, /GORULEN_APP_URL_PROPERTY \|\| TASK_LINK_PROPERTY_DEFAULT/);
  assert.match(server, /TODO_APP_URL_PROPERTY \|\| TASK_LINK_PROPERTY_DEFAULT/);
  assert.match(server, /MAKINA_LINK_PROPERTY \|\| LINK_PROPERTY_DEFAULT/);
  assert.match(env, /TODO_APP_URL_PROPERTY=URL/);
  assert.match(env, /GORULEN_APP_URL_PROPERTY=URL/);
});

test('creating, editing and background sync write a task-specific ADIB deep link to Notion', () => {
  assert.match(server, /async function saveTask\(body, baseUrl = ''\)/);
  assert.match(server, /properties\[config\.linkProperty \|\| TASK_LINK_PROPERTY_DEFAULT\] = \{ url: appLink \}/);
  assert.match(server, /await patchServiceLink\(page, config\.linkProperty \|\| TASK_LINK_PROPERTY_DEFAULT, appLink\)/);
  assert.match(server, /targets\.push\(\{ page, propertyName: source\.linkProperty \|\| TASK_LINK_PROPERTY_DEFAULT, link: taskAppLink\(normalized, page\.id, machineId, planId\) \}\)/);
  assert.match(server, /if\(process\.env\.ADIB_AUTO_SYNC_LINKS!=='0'\)syncServiceLinks\(baseUrl\)/);
  assert.match(server, /function taskAppLink\(baseUrl, id, machineId = '', planId = ''\)/);
});

test('ADIB task deep links can open tasks linked directly to a plan', () => {
  assert.match(app, /const direct=state\.plans\.map\(plan=>\(\{plan,task:\(plan\.tasks\|\|\[\]\)\.find\(item=>normalizePageId\(item\.id\)===normalizePageId\(id\)\)\}\)\)\.find\(item=>item\.task\)/);
  assert.match(app, /openTaskEditor\(direct\.task,null,false\)/);
});
