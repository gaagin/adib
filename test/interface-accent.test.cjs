'use strict';
const test = require('node:test');
const assert = require('node:assert/strict');
const { cleanSettings } = require('../user-preferences-store');
test('interface color is included in per-user preferences without overwriting chat color', () => {
  const settings = cleanSettings({values:{'adib-interface-accent-v1':'violet','adib-chat-palette-v1':'mint','unrelated':'no'}});
  assert.deepEqual(settings.values, {'adib-interface-accent-v1':'violet','adib-chat-palette-v1':'mint'});
});
