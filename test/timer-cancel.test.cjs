const {test}=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const os=require('node:os');
const path=require('node:path');
const {WorkTimerStore}=require('../work-timer');
const {SharedPomodoroStore}=require('../pomodoro-shared');
const {PomodoroSessions}=require('../pomodoro-sessions');

function workStore(t, session, now){
 const dir=fs.mkdtempSync(path.join(os.tmpdir(),'adib-work-cancel-'));t.after(()=>fs.rmSync(dir,{recursive:true,force:true}));
 const logged=[];
 const store=new WorkTimerStore({file:path.join(dir,'store.json'),now:()=>now,notion:async()=>({}),sources:()=>[],saveSession:async row=>{logged.push(row);return{id:'notion-entry'}}});
 store.data.tasks.task={id:'task',baseSeconds:0,dirty:false};store.data.sessions.push(session);store.save();
 return {store,logged};
}

test('cancelled running work session is journalled but excluded from task time',async t=>{
 const now=10000,{store,logged}=workStore(t,{id:'s1',taskId:'task',title:'Test task',actorId:'actor',worker:'Ilgar',status:'running',startedAt:4000,endedAt:null,seconds:0,revision:1},now);
 const result=await store.action({action:'cancel',sessionId:'s1',revision:1,operationId:'cancel-work-01'}, {id:'actor',name:'Ilgar'},null);
 assert.equal(result.session.status,'saved');assert.equal(result.session.completionReason,'cancelled');assert.equal(result.session.seconds,6);assert.equal(result.session.excludeFromTotals,true);assert.equal(result.totalMinutes,0);
 await store.flush();assert.equal(logged.length,1);assert.equal(logged[0].completionReason,'cancelled');assert.equal(store.total('task'),0);
});

test('cancelling a stopped work session preserves its recorded boundary',async t=>{
 const now=20000,{store}=workStore(t,{id:'s2',taskId:'task',title:'Test task',actorId:'actor',worker:'Ilgar',status:'pending',startedAt:2000,endedAt:12000,seconds:10,revision:2},now);
 const result=await store.action({action:'cancel',sessionId:'s2',revision:2,operationId:'cancel-work-02'}, {id:'actor',name:'Ilgar'},null);
 assert.equal(result.session.endedAt,12000);assert.equal(result.session.seconds,10);assert.equal(result.session.status,'saved');assert.equal(result.session.completionReason,'cancelled');assert.equal(result.totalMinutes,0);
});

test('cancelled Pomodoro is logged as cancelled without increasing completed counts or focus minutes',async()=>{
 const now=Date.now(),store=new SharedPomodoroStore(),logs=[],patches=[];
 store.put({id:'task-p',title:'Test Pomodoro',mode:'work',duration:25,plannedDuration:25,running:true,status:'running',startedAt:new Date(now-120000).toISOString(),endsAt:now+23*60000,remainingSeconds:23*60,sessionId:'p-session',pomodoroCount:4,pomodoroMinutes:80,actorId:'actor',worker:'Ilgar'});
 const manager=new PomodoroSessions({store,loadTask:async id=>({id,title:'Test Pomodoro',pomodoroCount:4,pomodoroMinutes:80}),patchTask:async(id,properties)=>patches.push({id,properties}),saveSession:async session=>{logs.push(session);return{id:'notion-pomodoro'}},now:()=>now});
 const result=await manager.handle({id:'task-p',action:'cancel',sessionId:'p-session'});
 assert.equal(result.timer.running,false);assert.equal(result.timer.completionReason,'cancelled');assert.equal(result.timer.nextMode,'work');assert.equal(result.pomodoroCount,4);assert.equal(result.pomodoroMinutes,80);
 assert.equal(store.sessions.length,1);assert.equal(store.sessions[0].completionReason,'cancelled');assert.equal(store.sessions[0].fullPomodoro,false);assert.equal(store.sessions[0].creditedMinutes,undefined);assert.equal(logs.length,1);assert.equal(logs[0].completionReason,'cancelled');assert.equal(patches.length,1);
 const duplicate=await manager.handle({id:'task-p',action:'cancel',sessionId:'p-session'});assert.equal(duplicate.duplicate,true);assert.equal(logs.length,1);
});

test('Pomodoro cancel control is present in compact/regular interfaces',()=>{
 const html=fs.readFileSync(path.join(__dirname,'..','ela-nov-paketleme-dynamic.html'),'utf8');
 const popup=require('../browser-pomodoro');
 assert.match(html,/data-pomodoro-cancel/);assert.match(html,/action:async\(id,action\)=>\{if\(!\['start','finish','cancel'\]\.includes\(action\)\)/);
 assert.ok(popup.LARGE_MARKUP.includes('id="cancel"'));
});
