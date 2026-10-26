const {test}=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const vm=require('node:vm');
const path=require('node:path');

test('session timestamps use the familiar DD.MM.YYYY HH:mm:ss format',()=>{
  const root={};
  vm.runInNewContext(fs.readFileSync(path.join(__dirname,'..','pomodoro-session-ui.js'),'utf8'),{window:root});
  assert.equal(root.ADIBSessions.formatDateTime(Date.parse('2026-10-26T09:01:20Z'),'UTC'),'26.10.2026 09:01:20');
  assert.equal(root.ADIBSessions.formatDateTime(Date.parse('2026-10-26T09:15:23Z'),'UTC'),'26.10.2026 09:15:23');
});

test('session date format change refreshes the cached browser script',()=>{
  const html=fs.readFileSync(path.join(__dirname,'..','ela-nov-paketleme-dynamic.html'),'utf8');
  assert.match(html,/pomodoro-session-ui\.js\?v=[^"']*date-format-v1/);
});
