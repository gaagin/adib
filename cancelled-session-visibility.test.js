const {test}=require('node:test');
const assert=require('node:assert/strict');

test('cancelled work and Pomodoro sessions stay out of session lists and calendar',()=>{
 const startedAt=Date.now();
 globalThis.ADIBWork={state:{sessions:[
  {id:'work-cancelled',taskId:'task-1',kind:'work',status:'saved',completionReason:'cancelled',startedAt,endedAt:startedAt+1000,seconds:1},
  {id:'work-kept',taskId:'task-1',kind:'work',status:'saved',completionReason:'elapsed',startedAt:startedAt+2000,endedAt:startedAt+3000,seconds:1},
 ]}};
 globalThis.ADIBHomeBridge={snapshot:()=>({tasks:[]})};
 globalThis.ADIBClock={now:()=>startedAt+10000};
 const sessions=require('./pomodoro-session-ui');
 sessions.accept({revisionBasis:'test',revision:1,sessions:[
  {id:'pomodoro-cancelled',taskId:'task-2',kind:'pomodoro',status:'saved',completionReason:'cancelled',startedAt,endedAt:startedAt+1000,seconds:1,plannedMinutes:25,title:'Cancelled'},
  {id:'pomodoro-kept',taskId:'task-2',kind:'pomodoro',status:'saved',completionReason:'elapsed',startedAt:startedAt+2000,endedAt:startedAt+3000,seconds:1,plannedMinutes:25,title:'Completed'},
 ]});
 assert.deepEqual(sessions.rows().map(s=>s.id),['work-kept','pomodoro-kept']);
 assert.deepEqual(sessions.calendar().map(t=>t.workSession.id),['pomodoro-kept']);
});
