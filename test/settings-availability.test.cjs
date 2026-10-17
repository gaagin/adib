const test=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const path=require('node:path');

const home=fs.readFileSync(path.join(__dirname,'..','home-screen.js'),'utf8');
const focused=fs.readFileSync(path.join(__dirname,'..','focused-views.js'),'utf8');

test('sidebar Ayarlar opens the visible panel above the navigation drawer',()=>{
  assert.match(home,/root\.ADIBSettings\.open\(anchor\)/);
  assert.match(home,/panel\.style\.setProperty\('position','fixed','important'\)/);
  assert.match(home,/panel\.style\.setProperty\('z-index','2147483000','important'\)/);
  assert.match(home,/getElementById\('adibSettingsMenu'\)/);
  assert.doesNotMatch(home,/root\.ADIBDesktop\?\.openSettings/);
});

test('local Ayarlar panel remains available when an account lacks settings permissions',()=>{
  assert.match(focused,/const open=button=>\{anchor=button\|\|original;/);
  assert.doesNotMatch(focused,/const open=button=>\{anchor=button\|\|original;if\(root\.ADIBAccount&&!root\.ADIBAccount\.section\('settings'\)\)return/);
});