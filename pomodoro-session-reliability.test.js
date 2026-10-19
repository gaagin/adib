const {test}=require('node:test');
const assert=require('node:assert/strict');
const {SharedPomodoroStore}=require('./pomodoro-shared');
const {PomodoroSessions}=require('./pomodoro-sessions');
function make({patchTask=async()=>{},saveSession=async()=>({id:'notion-session'})}={}){
 let now=Date.now();const store=new SharedPomodoroStore();let saves=0;
 const sessions=new PomodoroSessions({store,loadTask:async id=>({id,title:'Test'}),patchTask,saveSession:async session=>{saves++;return saveSession(session)},now:()=>now});
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
test('journal retry can succeed while its independent task patch remains pending',async()=>{
 let failLog=true;const e=make({patchTask:async()=>{throw new Error('PATCH unavailable')},saveSession:async()=>{if(failLog)throw new Error('journal unavailable');return{id:'saved-later'}}});
 e.seed();await e.sessions.handle({id:'task',action:'finish',sessionId:'session-task'});
 assert.equal(e.saves(),1);assert.equal(e.store.sessions[0].notionSyncPending,true);assert.equal(e.store.jobs.length,1);
 failLog=false;e.advance(61000);await e.sessions.retryDue();
 assert.equal(e.saves(),2);assert.equal(e.store.sessions[0].notionPageId,'saved-later');assert.equal(e.store.sessions[0].notionSyncPending,false);assert.equal(e.store.jobs.length,1);
});
