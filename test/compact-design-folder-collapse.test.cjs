'use strict';
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const vm = require('node:vm');
const source = fs.readFileSync(require.resolve('../compact-design.js'), 'utf8');

test('folder clicks use the same close action as the main navigation and defer a final close', () => {
  assert.ok(source.includes("const folder=e.target.closest?.('#adibPersistentSide [data-home-container],#adibPersistentSide .adib-home-container')"));
  assert.ok(source.includes('if(folder&&(media.matches||isNativeAndroid())){closeNavigationDrawer();setTimeout(closeNavigationDrawer,0)}'));
});

test('close action stores the collapsed state and updates menu accessibility labels', () => {
  const start = source.indexOf('function closeNavigationDrawer(){');
  const end = source.indexOf('\nconst isNativeAndroid', start);
  assert.ok(start >= 0 && end > start);
  const classes = new Set();
  const expanded = [];
  const context = vm.createContext({
    window: {},
    document: {
      body: { classList: { add(name) { classes.add(name); } } },
      querySelectorAll() { return [{ setAttribute(_name, value) { expanded.push(value); } }]; },
      querySelector() { return { setAttribute(_name, value) { expanded.push(value); } }; }
    },
    localStorage: { setItem(key, value) { expanded.push(`${key}:${value}`); } }
  });
  vm.runInContext(source.slice(start, end) + '\nwindow.closeNavigationDrawer=closeNavigationDrawer;', context);
  context.window.closeNavigationDrawer();
  assert.ok(classes.has('adib-side-collapsed'));
  assert.ok(expanded.includes('adib-side-collapsed:true'));
  assert.deepEqual(expanded.filter(value => value === 'false'), ['false', 'false']);
});