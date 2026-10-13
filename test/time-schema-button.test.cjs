'use strict';
const test=require('node:test'),assert=require('node:assert/strict'),fs=require('node:fs'),path=require('node:path');
const read=p=>fs.readFileSync(path.join(__dirname,'..',p),'utf8');
test('schema preparation is absent from task UI, while time controls remain',()=>{
 const web=read('work-timer-ui.js');
 assert(!web.includes('Vaxt sahələrini hazırla'));
 assert(!web.includes("request('/api/work-schema'"));
 assert(web.includes('İşə başla'));assert(web.includes('history(task.id)'));
 for(const p of ['android-patches/work-screen/WorkTimerClient.java','android-patches/local-work-window/WorkTimerClient.java']){
  const android=read(p);assert(!android.includes('Vaxt sahələrini hazırla'));assert(!android.includes('Button prepare='));assert(android.includes('İşə başla'));assert(android.includes('İş seansları'));
 }
});
test('existing field and synchronization are retained',()=>{
 const store=read('work-timer.js');assert(store.includes("const FIELD='İş vaxtı, dəq'"));assert(store.includes('[FIELD]:{number:total}'));
});
