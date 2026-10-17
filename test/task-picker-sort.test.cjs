const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const html = fs.readFileSync(path.join(__dirname, '..', 'ela-nov-paketleme-dynamic.html'), 'utf8');

test('equipment and Plan task pickers are sorted by Azerbaijani A–Z with numeric names', () => {
  assert.ok(/function sortPickerItemsAZ\(items\)\{const collator=new Intl\.Collator\('az',\{numeric:true,sensitivity:'base'\}\)/.test(html));
  assert.ok(/const availableMachines=sortPickerItemsAZ\(/.test(html));
  assert.ok(/sortPickerItemsAZ\(state\.plans\|\|\[\]\)\.map\(/.test(html));
});
