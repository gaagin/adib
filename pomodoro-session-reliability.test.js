const {test}=require('node:test');
const assert=require('node:assert/strict');
const {SharedPomodoroStore}=require('./pomodoro-shared');
const {PomodoroSessions}=require('./pomodoro-sessions');
function make({patchTask=async()=>{},saveSession=async()=>({id:'notion-session'}),loadTask=async id=>({id,title:'Test'})}={}){
 let now=Date.now();const store=new SharedPomodoroStore();let saves=0;
 const sessions=new PomodoroSessions({store,loadTask,patchTask,saveSession:async session=>{saves++;return saveSession(session)},now:()=>now});
 const seed=(id='task')=>store.put({id,title:'Test',mode:'work',duration:1,plannedDuration:1,running:true,status:'running',startedAt:new Date(now-120000).toISOString(),endsAt:now-60000,sessionId:'session-'+id,pomodoroCount:0,pomodoroMinutes:0});
 return {store,sessions,seed,now:()=>now,advance:ms=>{now+=ms},saves:()=>saves};
}
test('journal recording is not blocked by a failed Notion task-property patch',async()=>{
 const e=make({patchTask:async()=>{throw new Error('Notion task PATCH failed')}});e.seed();
 await e.sessions.handle({id:'task',action:'finish',sessionId:'session-task'});
 const record=e.store.sessions.find(s=>s.id==='session-task');
 assert.equal(e.saves(),1);assert.ok(record.notionPageId);assert.equal(record.notionSyncPending,false);assert.equal(record.status,'saved');
 assert.equal(e.store.jobs.length,1);assert.equal(e.store.jobs[0].taskId,'task');
});
test('server-side expiry completes an unattended timer and writes its session',async()=>{
 const e=make();e.seed();await e.sessions.finishExpired();
 const timer=e.store.get('task'),record=e.store.sessions.find(s=>s.id==='session-task');
 assert.equal(timer.status,'completed');assert.equal(timer.running,false);assert.equal(timer.completionReason,'elapsed');
 assert.ok(record?.notionPageId);assert.equal(e.saves(),1);assert.equal(e.store.jobs.length,0);
});
test('natural completion tolerates the countdown rounding window and records a full pomodoro',async()=>{
 const e=make();
 const end=e.now()+250;
 e.store.put({id:'task',title:'Test',mode:'work',duration:1,plannedDuration:1,running:true,status:'running',startedAt:new Date(end-60000).toISOString(),endsAt:end,sessionId:'session-task',pomodoroCount:0,pomodoroMinutes:0});
 await e.sessions.handle({id:'task',action:'finish',sessionId:'session-task',natural:true});
 const timer=e.store.get('task'),record=e.store.sessions.find(s=>s.id==='session-task');
 assert.equal(timer.status,'completed');assert.equal(timer.completionReason,'elapsed');assert.equal(timer.pomodoroCount,1);
 assert.equal(record?.fullPomodoro,true);assert.equal(record?.completionReason,'elapsed');assert.ok(record?.notionPageId);assert.equal(e.saves(),1);
});
test('finished Pomodoro raises an existing estimate to the rounded total focus time',async()=>{
 let patched;
 const e=make({loadTask:async id=>({id,title:'Test',estimateMinutes:20}),patchTask:async(id,properties)=>{patched=properties}});
 e.store.put({id:'task',title:'Test',mode:'work',duration:1,plannedDuration:1,running:true,status:'running',startedAt:new Date(e.now()-60000).toISOString(),endsAt:e.now(),sessionId:'session-task',pomodoroCount:1,pomodoroMinutes:20});
 await e.sessions.handle({id:'task',action:'finish',sessionId:'session-task',natural:true});
 assert.equal(patched['Təxmini müddət, dəq'].number,21);
 assert.equal(e.store.get('task').pomodoroMinutes,21);
});
test('manual early finish is still recorded as an early session',async()=>{
 const e=make();
 e.store.put({id:'task',title:'Test',mode:'work',duration:1,plannedDuration:1,running:true,status:'running',startedAt:new Date(e.now()-5000).toISOString(),endsAt:e.now()+55000,sessionId:'session-task',pomodoroCount:0,pomodoroMinutes:0});
 await e.sessions.handle({id:'task',action:'finish',sessionId:'session-task',natural:false});
 const timer=e.store.get('task'),record=e.store.sessions.find(s=>s.id==='session-task');
 assert.equal(timer.completionReason,'early');assert.equal(timer.pomodoroCount,1);assert.equal(record?.fullPomodoro,false);assert.equal(record?.completionReason,'early');assert.ok(record?.notionPageId);
});

test('session count includes every finished non-cancelled Pomodoro and reconciles prior records',async()=>{
 const e=make();
 e.store.sessions.push(
  {id:'old-early-1',taskId:'task',kind:'pomodoro',status:'saved',completionReason:'early'},
  {id:'old-full-2',taskId:'task',kind:'pomodoro',status:'saved',completionReason:'elapsed'},
  {id:'old-cancelled',taskId:'task',kind:'pomodoro',status:'saved',completionReason:'cancelled'},
  {id:'other-task',taskId:'other',kind:'pomodoro',status:'saved',completionReason:'elapsed'},
  {id:'work-timer',taskId:'task',kind:'work',status:'saved',completionReason:'elapsed'},
 );
 e.store.put({id:'task',title:'Test',mode:'work',duration:1,plannedDuration:1,running:true,status:'running',startedAt:new Date(e.now()-5000).toISOString(),endsAt:e.now()+55000,sessionId:'session-task',pomodoroCount:1,pomodoroMinutes:0});
 await e.sessions.handle({id:'task',action:'finish',sessionId:'session-task',natural:false});
 const timer=e.store.get('task'),record=e.store.sessions.find(s=>s.id==='session-task');
 assert.equal(timer.pomodoroCount,3,'two saved sessions plus this early finish count; cancellations and other session types do not');
 assert.equal(record?.fullPomodoro,false);
});

test('cancelled pomodoro is not added to the session journal',async()=>{
 const e=make();
 e.store.put({id:'task',title:'Test',mode:'work',duration:1,plannedDuration:1,running:true,status:'running',startedAt:new Date(e.now()-5000).toISOString(),endsAt:e.now()+55000,sessionId:'session-task',pomodoroCount:0,pomodoroMinutes:0});
 await e.sessions.handle({id:'task',action:'cancel',sessionId:'session-task'});
 const timer=e.store.get('task'),record=e.store.sessions.find(s=>s.id==='session-task');
 assert.equal(timer.completionReason,'cancelled');assert.equal(timer.pomodoroCount,0);
 assert.equal(record?.completionReason,'cancelled');assert.equal(record?.notionLogEligible,false);assert.equal(record?.notionPageId,undefined);assert.equal(e.saves(),0);
});
test('journal retry can succeed while its independent task patch remains pending',async()=>{
 let failLog=true;const e=make({patchTask:async()=>{throw new Error('PATCH unavailable')},saveSession:async()=>{if(failLog)throw new Error('journal unavailable');return{id:'saved-later'}}});
 e.seed();await e.sessions.handle({id:'task',action:'finish',sessionId:'session-task'});
 assert.equal(e.saves(),1);assert.equal(e.store.sessions[0].notionSyncPending,true);assert.equal(e.store.jobs.length,1);
 failLog=false;e.advance(61000);await e.sessions.retryDue();
 assert.equal(e.saves(),2);assert.equal(e.store.sessions[0].notionPageId,'saved-later');assert.equal(e.store.sessions[0].notionSyncPending,false);assert.equal(e.store.jobs.length,1);
});
