const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const vm = require('node:vm');
const path = require('node:path');
const source = fs.readFileSync(path.join(__dirname, '..', 'team-view.js'), 'utf8');
const helper = source.slice(source.indexOf('  function mountSidebarNavigation()'), source.indexOf('  function addNavigation('));
function setup(role = 'admin') {
  const nodes = new Map(), calls = [];
  const context = { user: {role}, document: { getElementById: id => nodes.get(id) },
    el: () => ({dataset: {}, setAttribute() {}, addEventListener(type, fn) {this.click = fn;}}),
    window: { ADIBHome: {canLeave: () => true, closeSidebarOnMobile: () => calls.push('closeSidebar')},
      ADIBHomeBridge: {closeViews: () => calls.push('closeViews')} }, open: e => calls.push(e) };
  vm.createContext(context); vm.runInContext(helper, context);
  const chat = {}, children = [chat];
  const side = {querySelector: () => chat, insertBefore(button, before) {
    children.splice(children.indexOf(before), 0, button); nodes.set(button.id, button);
  }, append(button) {children.push(button); nodes.set(button.id, button);}};
  return {context, nodes, calls, side, children, mount: () => context.mountSidebarNavigation()};
}
test('mounts Komanda once when the persistent sidebar appears later', () => {
  const s = setup(); s.mount(); assert.equal(s.nodes.has('teamSidebarButton'), false);
  s.nodes.set('adibPersistentSide', s.side); s.mount(); s.mount();
  assert.equal(s.children.length, 2);
  assert.equal(s.children[0].id, 'teamSidebarButton');
  assert.equal(s.children[0].dataset.homeNav, 'team');
  assert.match(source, /new MutationObserver\(mountSidebarNavigation\)/);
  assert.match(source, /navigationObserver\.observe\(document\.body, \{childList: true\}\)/);
});
test('staff do not receive management navigation', () => {
  const s = setup('employee'); s.nodes.set('adibPersistentSide', s.side); s.mount();
  assert.equal(s.nodes.has('teamSidebarButton'), false);
});
test('manager navigation respects unsaved changes and closes mobile sidebar', () => {
  const s = setup('manager'); s.nodes.set('adibPersistentSide', s.side); s.mount();
  const button = s.nodes.get('teamSidebarButton'), event = {currentTarget: button};
  s.context.window.ADIBHome.canLeave = () => false; button.click(event);
  assert.equal(s.calls.length, 0);
  s.context.window.ADIBHome.canLeave = () => true; button.click(event);
  assert.deepEqual(s.calls, ['closeSidebar', 'closeViews', event]);
});
