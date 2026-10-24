'use strict';
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const vm = require('node:vm');
const source = fs.readFileSync(require.resolve('../home-screen.js'), 'utf8');

function loadHome(matchesPhone, nativeAndroid = false) {
  const classes = new Set();
  const stored = new Map();
  const menuButton = { value: null, setAttribute(name, value) { if (name === 'aria-expanded') this.value = value; } };
  const sideToggle = { value: null, setAttribute(name, value) { if (name === 'aria-expanded') this.value = value; } };
  const document = {
    body: { classList: { add(name) { classes.add(name); }, contains(name) { return classes.has(name); } } },
    documentElement: { classList: { contains(name) { return nativeAndroid && name === 'adib-native-android'; } } },
    querySelectorAll(selector) { return selector === '.adib-global-menu' ? [menuButton] : []; },
    querySelector(selector) { return selector === '#adibPersistentSide .adib-side-toggle' ? sideToggle : null; }
  };
  const localStorage = { setItem(key, value) { stored.set(key, value); } };
  const root = {
    ADIBFilters: { read: (_key, fallback) => ({ ...fallback }), write() {} },
    ADIBFilterDialog: { read: (_key, fallback) => ({ ...fallback }) },
    matchMedia: () => ({ matches: matchesPhone }),
    innerWidth: matchesPhone ? 412 : 1280
  };
  const context = vm.createContext({ window: root, document, localStorage });
  vm.runInContext(source, context);
  return { api: root.ADIBHome, classes, stored, menuButton, sideToggle };
}

test('choosing a folder collapses and remembers the open navigation drawer on phones', () => {
  const app = loadHome(true);
  assert.equal(app.api.closeSidebarOnMobile(), true);
  assert.ok(app.classes.has('adib-side-collapsed'));
  assert.equal(app.stored.get('adib-side-collapsed'), 'true');
  assert.equal(app.menuButton.value, 'false');
  assert.equal(app.sideToggle.value, 'false');
  assert.match(source.match(/function chooseScope\(id\)\{([^}]*)\}/)[1], /closeSidebarOnMobile\(\)/);
});

test('desktop sidebar is unchanged', () => {
  const app = loadHome(false);
  assert.equal(app.api.closeSidebarOnMobile(), false);
  assert.ok(!app.classes.has('adib-side-collapsed'));
  assert.equal(app.stored.has('adib-side-collapsed'), false);
});

test('native Android collapses the sidebar even with a desktop-sized CSS viewport', () => {
  const app = loadHome(false, true);
  assert.equal(app.api.closeSidebarOnMobile(), true);
  assert.ok(app.classes.has('adib-side-collapsed'));
  assert.equal(app.stored.get('adib-side-collapsed'), 'true');
  const css = fs.readFileSync(require.resolve('../compact-design.css'), 'utf8');
  assert.match(css, /html\.adib-native-android body\.adib-side-collapsed #adibPersistentSide/);
});
