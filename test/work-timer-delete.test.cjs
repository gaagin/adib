'use strict';

const test=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const os=require('node:os');
const path=require('node:path');
const {WorkTimerStore}=require('../work-timer');

function makeStore(t,session,deleteSession=async()=>({deleted:1})){
 const dir=fs.mkdtempSync(path.join(os.tmpdir(),'adib-work-delete-'));
 t.after(()=>fs.rmSync(dir,{recursive:true,force:true}));
 const store=new WorkTimerStore({file:path.join(dir,'work.json'),now:()=>10000,notion:async()=>({}),sources:()=>[],deleteSession});
 store.data.tasks.task={id:'task',baseSeconds:0,dirty:false};
 store.data.sessions.push(session);
 store.save();
 return store;
}

test('deleting a saved work session archives its log and recalculates task time',async t=>{
 const archived=[];
 const store=makeStore(t,{id:'work-1',taskId:'task',actorId:'actor',status:'saved',revision:4,seconds:120,notionLogEligible:true,notionPageId:'notion-row'},async session=>{archived.push(session.id)});
 const result=await store.action({action:'delete',sessionId:'work-1',revision:4,operationId:'delete-work-01'},{id:'actor'},null);
 assert.equal(result.deleted,true);
 assert.equal(result.totalMinutes,0);
 assert.deepEqual(archived,['work-1']);
 assert.equal(store.data.sessions.length,0);
 assert.equal(store.data.tasks.task.dirty,true);
 const duplicate=await store.action({action:'delete',sessionId:'work-1',revision:4,operationId:'delete-work-01'},{id:'actor'},null);
 assert.equal(duplicate.duplicate,true);
 assert.deepEqual(archived,['work-1']);
});

test('only the owner can delete a saved session, and active sessions must be cancelled instead',async t=>{
 const session={id:'work-2',taskId:'task',actorId:'actor',status:'saved',revision:2,seconds:60};
 const store=makeStore(t,session);
 await assert.rejects(store.action({action:'delete',sessionId:'work-2',revision:2,operationId:'delete-work-02'},{id:'other'},null),/Başqa əməkdaşın seansını dəyişmək olmaz/);
 store.data.sessions[0].status='running';
 store.data.sessions[0].revision=3;
 await assert.rejects(store.action({action:'delete',sessionId:'work-2',revision:3,operationId:'delete-work-03'},{id:'actor'},null),/Yalnız tamamlanmış seansı silmək olar/);
 assert.equal(store.data.sessions.length,1);
});