'use strict';
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const source = fs.readFileSync(path.join(__dirname, '..', 'realtime-runtime.js'), 'utf8');
const personalSource = fs.readFileSync(path.join(__dirname, '..', 'ela-nov-paketleme-dynamic.html'), 'utf8');

test('a successfully created equipment task opens its saved properties instead of returning to the list', () => {
  assert.match(source, /const createdTask=\{\.\.\.task,\.\.\.body,creationPending:false\}/);
  assert.match(source, /openTaskEditor\(createdTask,selectedMachine,false,kanbanContext\)/);
  assert.match(source, /openTaskEditor\(createdTask,selectedMachine,false\)/);
  assert.doesNotMatch(source, /optimistic:body=>\{[^}]*openTasks\(machine\.id\)/);
  assert.match(personalSource, /optimistic:\(\)=>\{close\(\);personalTasks=ADIBAutosave\.merge\(personalTasks,'personal'\);renderPersonalBoard\(\);window\.dispatchEvent\(new Event\('adib-home-data'\)\);if\(task\.id\)openPersonalTaskEditor\(task\.id,false,preset,kanbanHost\)/);
});
