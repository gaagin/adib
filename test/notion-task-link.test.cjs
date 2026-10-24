const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const {appHtml}=require('./helpers/app-html.cjs');

const html = appHtml();
const tabs = fs.readFileSync(path.join(__dirname, '..', 'task-tabs.js'), 'utf8');

test('existing equipment task editor exposes the source Notion page in its header tools', () => {
  assert.match(html, /task\.id&&task\.url\?'<a class="button" href="'\+escapeHtml\(task\.url\)\+'" target="_blank" rel="noopener noreferrer">Açın Notion<\/a>'/);
  assert.match(tabs, /item\.matches\('a'\)&&item\.textContent\.includes\('Açın Notion'\)/);
  assert.match(tabs, /item\.className='adib-task-notion-link';item\.textContent='↗ Notion'/);
  assert.match(tabs, /host\.querySelector\('\.adib-task-header-tools'\)\.append\(item\)/);
});
