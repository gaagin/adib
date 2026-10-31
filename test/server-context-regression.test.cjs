'use strict';
const test=require('node:test'),assert=require('node:assert/strict');
function personalFixture(){
 const field=(page,name)=>page.properties[name];
 const context={taskManagement:{getContext:()=>({machineId:'machine-1',planId:'plan-1'})},
 property:field,relationIds:(p,n)=>field(p,n)?.relation?.map(x=>x.id)||[],select:(p,n)=>field(p,n)?.select?.name||'',
 title:(p,n)=>field(p,n)?.title?.[0]?.plain_text||'',number:()=>null,dateStart:()=>'',multiSelect:()=>[],
 enrichCompletion:t=>t,taskHistory:{done:()=>false},taskEstimates:{read:()=>15},pomodoroModeDuration:()=>25};
 return {context,api:require('../server-personal')(context)};
}
test('personal task mapping keeps server dependencies separate from saved task context',()=>{
 const {api}=personalFixture();const task=api.mapPersonalTask({id:'task-1',properties:{Adi:{title:[{plain_text:'Test'}]}}});
 assert.equal(task.title,'Test');assert.equal(task.machineId,'machine-1');assert.equal(task.planId,'plan-1');assert.equal(task.estimateMinutes,15);
});
test('team snapshot loads with personal task rows instead of throwing context initialization error',async()=>{
 const {api:personal}=personalFixture();
 const {buildTeamDashboard}=require('../team-dashboard');
 const {teamSnapshot}=require('../server-access')({appBaseUrl:()=>'',personalSnapshot:async()=>({tasks:[personal.mapPersonalTask({id:'task-1',properties:{}})]}),snapshot:async()=>({equipment:[],pomodoroTasks:[]}),withTaskEstimates:x=>x,accountKey:x=>x,accounts:{enabled:false},personalDirectory:async()=>[],workTimer:{data:{sessions:[]}},networkTime:{snapshot:()=>({now:Date.now()})},buildTeamDashboard});
 const result=await teamSnapshot({});assert.equal(result.ok,true);assert(result.refreshedAt);
});
test('AI validation reads server configuration, not user-supplied context',async()=>{
 const {aiChat}=require('../server-access')({GEMINI_API_KEY:'',requestError:(message,statusCode)=>Object.assign(Error(message),{statusCode})});
 await assert.rejects(aiChat({message:''}),e=>e.statusCode===400);
 await assert.rejects(aiChat({message:'Hello',context:{GEMINI_API_KEY:'user-data'}}),e=>e.statusCode===503);
});
