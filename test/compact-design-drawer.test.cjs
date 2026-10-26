const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const sourcePath = process.env.COMPACT_DESIGN_SOURCE || path.join(__dirname, '../compact-design.js');
const htmlPath = process.env.ADIB_DYNAMIC_HTML || path.join(__dirname, '../ela-nov-paketleme-dynamic.html');
const homePath = process.env.ADIB_HOME_SOURCE || path.join(__dirname, '../home-screen.js');
const compactDesign = fs.readFileSync(sourcePath, 'utf8');
const html = fs.readFileSync(htmlPath, 'utf8');
const homeScreen = fs.readFileSync(homePath, 'utf8');

test('mobile drawer leaves bottom actions usable while closing after navigation', () => {
  const listener = compactDesign.match(/document\.addEventListener\('click',e=>\{([\s\S]*?)\},true\);/);
  assert.ok(listener, 'capture-phase drawer click listener exists');
  assert.match(listener[1], /sideMenuAction=e\.target\.closest\?\.\('#adibPersistentSide \.adib-side-bottom button'\)/);
  assert.match(listener[1], /media\.matches&&sideButton&&!sideMenuAction\)closeNavigationDrawer\(\)/);
  assert.match(listener[1], /folder&&\(media\.matches\|\|isNativeAndroid\(\)\)\)\{closeNavigationDrawer\(\)/);
  assert.match(homeScreen, /const sideBottom=make\('div','adib-side-bottom'\)/);
  assert.match(homeScreen, /\['settings','Ayarlar',openSettings\]/);
});

test('Android drawer fix uses a fresh compact-design asset URL', () => {
  assert.match(html, /compact-design\.js\?v=android-settings-drawer-fix-v1/);
});
