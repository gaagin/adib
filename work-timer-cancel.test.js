const {test}=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const os=require('node:os');
const path=require('node:path');
const {WorkTimerStore}=require('./work-timer');

test('cancelling a work timer excludes it from the Notion session journal',async()=>{
 const dir=fs.mkdtempSync(path.join(os.tmpdir(),'adib-work-cancel-'));
 const store=new WorkTimerStore({file:path.join(dir,'state.json'),now:()=>2000,notion:async()=>({}),sources:()=>[]});
 store.data.sessions.push({id:'session-1',taskId:'task-1',actorId:'actor-1',worker:'Worker',status:'running',startedAt:1000,endedAt:null,seconds:0,revision:1});
 store.data.tasks['task1']={id:'task-1',baseSeconds:0,dirty:false};
 try{
  await store.action({action:'cancel',sessionId:'session-1',revision:1,operationId:'cancel-op-1'},{id:'actor-1'});
  await store.flush();
  const session=store.data.sessions[0];
  assert.equal(session.status,'saved');
  assert.equal(session.completionReason,'cancelled');
  assert.equal(session.excludeFromTotals,true);
  assert.equal(session.notionLogEligible,false);
  assert.equal(session.notionPageId,undefined);
 }finally{fs.rmSync(dir,{recursive:true,force:true});}
});
