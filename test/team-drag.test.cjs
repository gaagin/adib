const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const vm = require('node:vm');
const {buildTeamDashboard} = require('../team-dashboard');
const source = fs.readFileSync(require.resolve('../team-view.js'), 'utf8');
const code = source.slice(source.indexOf('  function canMoveTask('), source.indexOf('  function canCreateTeamTask('));
function fixture(task, responseError) {
  const from = {key:'a',name:'Aqil Hesimov',assignee:'Aqil',aliases:['Aqil','Aqil Hesimov'],tasks:[task],nextTask:task};
  const to = {key:'b',name:'Araz Verdiyev',assignee:'Araz',tasks:[]};
  const other = {key:'c',name:'Ilqar',assignee:'Ilqar',tasks:[task]};
  const requests = [], messages = [];
  const ctx = {user:{role:'admin'},transferPending:false,refreshVersion:0,payload:{employees:[from,to,other]},
    root:{classList:{add(){},remove(){}}},setMessage:(...args)=>messages.push(args),
    request:async(path,options)=>{requests.push({path,body:JSON.parse(options.body)});if(responseError)throw Error(responseError);},
    openTasks:p=>p.tasks.filter(t=>!t.completed),window:{dispatchEvent(){}},CustomEvent:class{},render(){},load(){}};
  vm.createContext(ctx);vm.runInContext(code,ctx);return {ctx,from,to,other,requests,messages};
}
test('snapshot retains source, assignment and active-session metadata',()=>{
  const result=buildTeamDashboard({users:[{id:'a',name:'Aqil',rules:{assignee:'Aqil'}}],tasks:[{id:'t',kind:'equipment',sourceKey:'gorulen',tapsirildi:['Aqil'],assigneeId:'notion-user',assigneeName:'Aqil'}],sessions:[{taskId:'t',worker:'Aqil',status:'pending'}]});
  const task=result.employees[0].tasks[0];assert.equal(task.sourceKey,'gorulen');assert.equal(task.activeSession,true);assert.deepEqual(task.tapsirildi,['Aqil']);assert.equal(task.assigneeId,'notion-user');
});
test('personal drag replaces sender only and retains collaborators',async()=>{
  const f=fixture({id:'p',kind:'personal',assignees:['Aqil','Ilqar']});
  await f.ctx.transferTeamTask(f.from.tasks[0],f.from,f.to);
  assert.equal(f.requests[0].path,'/api/personal-task');assert.deepEqual(f.requests[0].body.assignees,['Ilqar','Araz']);
  assert.equal(f.from.tasks.length,0);assert.equal(f.to.tasks.length,1);assert.equal(f.other.tasks.length,1);
  assert.equal(f.to.nextTask.id,'p');assert.equal(f.to.openCount,1);
});
for(const sourceKey of ['todo','gorulen'])test(`${sourceKey} transfers via equipment API, clearing sender people field`,async()=>{
  const f=fixture({id:'e',kind:'equipment',sourceKey,tapsirildi:['Aqil','Ilqar'],assigneeId:'nid',assigneeName:'Aqil'});
  await f.ctx.transferTeamTask(f.from.tasks[0],f.from,f.to);
  assert.equal(f.requests[0].path,'/api/task');assert.equal(f.requests[0].body.sourceKey,sourceKey);
  assert.deepEqual(f.requests[0].body.tapsirildi,['Ilqar','Araz']);assert.equal(f.requests[0].body.assigneeId,'');
});
test('failed save leaves original cards unchanged',async()=>{
  const f=fixture({id:'p',kind:'personal',assignees:['Aqil']},'Forbidden');
  await f.ctx.transferTeamTask(f.from.tasks[0],f.from,f.to);
  assert.equal(f.from.tasks.length,1);assert.equal(f.to.tasks.length,0);assert.equal(f.messages.at(-1)[1],true);assert.equal(f.ctx.transferPending,false);
});
test('active sessions, completed tasks and no-edit accounts cannot transfer',()=>{
  const f=fixture({id:'p',kind:'personal'});
  assert.equal(f.ctx.canMoveTask({kind:'personal',activeSession:true}),false);
  assert.equal(f.ctx.canMoveTask({kind:'personal',completed:true}),false);
  f.ctx.user={role:'manager',rules:{actions:['status']}};assert.equal(f.ctx.canMoveTask({kind:'personal'}),false);
});
test('same employee drop does not send a write',async()=>{
  const f=fixture({id:'p',kind:'personal',assignees:['Aqil']});await f.ctx.transferTeamTask(f.from.tasks[0],f.from,f.from);assert.equal(f.requests.length,0);
});
