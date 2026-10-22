'use strict';
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { create, FIELD } = require('../task-estimate');

const ids = { personal: 'personal-ds', todo: 'todo-ds', gorulen: 'gorulen-ds' };

function notionMock(initial = {}) {
  const calls = [];
  const schemas = Object.fromEntries(Object.entries(ids).map(([key, dataSourceId]) =>
    [dataSourceId, { properties: structuredClone(initial[key] || {}) }]));
  const pages = new Map();
  const notion = async (url, options = {}) => {
    calls.push({ url, options });
    if (url.startsWith('/data_sources/')) {
      const schema = schemas[url.split('/').at(-1)];
      if (options.method === 'GET') return structuredClone(schema);
      if (options.method === 'PATCH') {
        Object.assign(schema.properties, JSON.parse(options.body).properties);
        return structuredClone(schema);
      }
    }
    if (url.startsWith('/pages/')) {
      const id = url.split('/').at(-1);
      const page = pages.get(id) || { properties: {} };
      Object.assign(page.properties, JSON.parse(options.body).properties);
      pages.set(id, page);
      return structuredClone(page);
    }
    throw new Error('Unexpected request ' + url);
  };
  return { notion, calls, schemas, pages };
}

test('saves estimate on the Notion task page and creates a numeric property once', async () => {
  const mock = notionMock();
  const store = create({ notion: mock.notion, sources: () => Object.fromEntries(Object.entries(ids).map(([key, dataSourceId]) => [key, { dataSourceId }])) });
  await store.save('personal', 'task-id', 90);
  await store.save('personal', 'task-id', 120);
  assert.deepEqual(mock.pages.get('task-id').properties[FIELD], { number: 120 });
  assert.ok(mock.schemas[ids.personal].properties[FIELD].number);
  assert.equal(mock.calls.filter(call => call.options.method === 'PATCH' && call.url.startsWith('/data_sources/')).length, 1);
  assert.equal(store.read({ properties: { [FIELD]: { type: 'number', number: 120 } } }), 120);
});

test('blank estimate clears the Notion value and invalid values are rejected', async () => {
  const mock = notionMock({ personal: { [FIELD]: { type: 'number', number: null } } });
  const store = create({ notion: mock.notion, sources: () => ({ personal: { dataSourceId: ids.personal } }) });
  await store.save('personal', 'task-id', null);
  assert.deepEqual(mock.pages.get('task-id').properties[FIELD], { number: null });
  await assert.rejects(store.save('personal', 'task-id', 0), error => error.code === 'INVALID_ESTIMATE');
});

test('does not replace an existing non-number Notion property', async () => {
  const mock = notionMock({ personal: { [FIELD]: { type: 'rich_text', rich_text: [] } } });
  const store = create({ notion: mock.notion, sources: () => ({ personal: { dataSourceId: ids.personal } }) });
  await assert.rejects(store.save('personal', 'task-id', 30), error => error.code === 'TASK_ESTIMATE_SCHEMA_INVALID');
  assert.equal(mock.calls.some(call => call.options.method === 'PATCH' && call.url.startsWith('/data_sources/')), false);
});

test('server reads and saves the estimate from Notion for personal and equipment tasks', () => {
  const server = fs.readFileSync(path.join(__dirname, '../server.js'), 'utf8');
  assert.match(server, /estimateMinutes:taskEstimates\.read\(page\)/);
  assert.match(server, /taskEstimates\.save\(sourceKey,id,body\.estimateMinutes\)/);
  assert.match(server, /taskEstimates\.save\('personal',command\.id,command\.minutes\)/);
  assert.match(server, /estimateMinutes:value\.estimateMinutes\?\?taskManagement\.getEstimate\(value\.id\)/);
  assert.match(server, /managementSnapshotWithTaskEstimates\(\)/);
});