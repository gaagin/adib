const test=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const path=require('node:path');

const home=fs.readFileSync(path.join(__dirname,'..','home-screen.js'),'utf8');
const focused=fs.readFileSync(path.join(__dirname,'..','focused-views.js'),'utf8');

test('sidebar Ayarlar safely opens the settings menu across native bridge return types',()=>{
  assert.match(home,/typeof root\.ADIBDesktop\?\.openSettings==='function'/);
  assert.match(home,/result&&typeof result\.then==='function'/);
  assert.match(home,/Promise\.resolve\(result\)\.catch\([^]*?fallback\(\)/);
  assert.match(home,/root\.ADIBSettings\?\.open/);
  assert.match(home,/getElementById\('adibSettingsButton'\)\?\.click\(\)/);
  assert.doesNotMatch(home,/openSettings\(\)\.catch/);
});

test('local Ayarlar panel remains available when an account lacks settings permissions',()=>{
  assert.match(focused,/const open=button=>\{anchor=button\|\|original;/);
  assert.doesNotMatch(focused,/const open=button=>\{anchor=button\|\|original;if\(root\.ADIBAccount&&!root\.ADIBAccount\.section\('settings'\)\)return/);
});