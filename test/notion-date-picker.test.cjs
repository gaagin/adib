const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const vm = require('node:vm');
const path = require('node:path');
const html = fs.readFileSync(path.join(__dirname, '..', 'ela-nov-paketleme-dynamic.html'), 'utf8');
const source = fs.readFileSync(path.join(__dirname, '..', 'notion-date-picker.js'), 'utf8');
function picker() {
  const context = { window: {}, document: {} };
  vm.runInNewContext(source, context);
  return context.window.ADIBNotionDatePicker;
}
test('date picker provides Notion-style date, time and optional end-date controls', () => {
  const markup = picker().field({dateId:'d',timeId:'t',timeWrapId:'tw',timeToggleId:'hasTime',endDateId:'ed',endTimeId:'et',endToggleId:'hasEnd',date:'2026-10-13',time:'09:00',hasTime:true,endDate:'2026-10-14',endTime:'10:00'});
  for (const id of ['data-notion-date-open','id="d"','id="t"','id="hasTime"','id="ed"','id="et"','id="hasEnd"','id="tw"']) assert.match(markup, new RegExp(id.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')));
  assert.match(markup, /data-date-id="d"/);
  assert.match(markup, /data-end-date-id="ed"/);
  assert.match(markup, /value="2026-10-13"/);
  assert.match(markup, /value="10:00"/);
});
test('equipment editor uses requested field order and sends end dates for both save paths', () => {
  const sequence = "+'<label>Ad<input id=\"taskTitle\"";
  const at = html.indexOf(sequence, html.indexOf('async function openTaskEditor'));
  const form = html.slice(at, at + 1400);
  const positions = ['tapsirildiFieldHtml','machineField','sourceField','datePickerField','planField'].map(x => form.indexOf(x));
  assert.ok(at >= 0);
  assert.ok(positions.every(x => x >= 0));
  assert.deepEqual([...positions], [...positions].sort((a,b)=>a-b));
  assert.equal((html.match(/dateEnd:combineDateTime\(document\.getElementById\('taskDateEnd'\)/g)||[]).length,2);
  assert.equal((html.match(/dateEnd:combineDateTime\(document\.getElementById\('personalEditDateEnd'\)/g)||[]).length,2);
});
test('mobile editors no longer install the action-first property workflow', () => {
  assert.ok(html.includes('if(false&&window.ADIBDesktop&&!isNew){const working=ADIBTaskConcept.install(list,{task,personal:false'));
  assert.ok(html.includes('if(false&&!window.ADIBDesktop&&!isNew){const working=ADIBTaskConcept.install(list,{task,personal:true'));
  assert.ok(html.includes('window.ADIBDesktop?ADIBTaskTabs.install'));
});

test('date picker assets are public and service worker invalidates the previous UI cache', () => {
  const server = fs.readFileSync(path.join(__dirname, '..', 'server.js'), 'utf8');
  const allowed = server.match(/const publicAssets=new Set\(\[([^]+?)\]\)/)[1];
  assert.ok(allowed.includes('"notion-date-picker.css"'));
  assert.ok(allowed.includes('"notion-date-picker.js"'));
  const worker = fs.readFileSync(path.join(__dirname, '..', 'sw.js'), 'utf8');
  assert.ok(worker.includes('adib-online-v284-personal-folder-form'));
});
