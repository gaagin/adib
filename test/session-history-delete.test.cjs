'use strict';

const test=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const path=require('node:path');
const dir=path.join(__dirname,'..');
const ui=fs.readFileSync(path.join(dir,'pomodoro-session-ui.js'),'utf8');
const page=fs.readFileSync(path.join(dir,'ela-nov-paketleme-dynamic.html'),'utf8');
const css=fs.readFileSync(path.join(dir,'calendar-view.css'),'utf8');

test('saved work sessions can be deleted from the session history',()=>{
 assert.match(ui,/s\.kind==='work'&&s\.status==='saved'&&root\.ADIBWork\?\.action/);
 assert.match(ui,/action:'delete',sessionId:s\.id,revision:s\.revision/);
 assert.match(ui,/Bu seansı və onun jurnal qeydini silmək istəyirsiniz/);
 assert.match(css,/\.session-delete-button/);
});

test('session history assets use fresh cache keys for the delete action',()=>{
 assert.match(page,/calendar-view\.css\?v=calendar-session-delete-v1/);
 assert.match(page,/pomodoro-session-ui\.js\?v=1\.1\.65-session-delete-v1/);
});