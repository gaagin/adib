const test=require('node:test');
const assert=require('node:assert/strict');
const vm=require('node:vm');
const fs=require('node:fs');
const path=require('node:path');
const source=fs.readFileSync(path.join(__dirname,'../team-view.js'),'utf8');
function harness(user={role:'admin'},account){
 const calls=[],messages=[];
 const window={ADIBAccount:account,newTaskDraft:()=>({sourceKey:'gorulen',source:'Gorulen isler',title:'',date:'2000-01-01',tapsirildi:[]}),openTaskEditor:(...args)=>calls.push(['equipment',...args]),ADIBHomeBridge:{activate:()=>calls.push(['activate']),newTask:preset=>calls.push(['personal',preset])}};
 const code=source.replace(/  if \(document.readyState === 'loading'\)[\s\S]*?else init\(\);/,`window.testAPI={createTeamTask,setup:u=>{user=u;selectedDate='2026-10-29';openEditorFromTeam=opener=>opener();setMessage=text=>window.messages.push(text);}};`);
 window.messages=messages;vm.runInNewContext(code,{window,Intl,Date});window.testAPI.setup(user);
 return {calls,messages,create:window.testAPI.createTeamTask};
}
for(const key of ['todo','gorulen'])test(`${key} opens the right equipment source with employee and date`,async()=>{
 const h=harness();await h.create(key,{assignee:'Araz'});
 const [type,draft,machine,isNew]=h.calls[0];assert.equal(type,'equipment');assert.equal(draft.sourceKey,key);assert.equal(draft.source,key==='todo'?'ToDo':'Gorulen isler');assert.equal(draft.date,'2026-10-29');assert.equal(draft.tapsirildi[0],'Araz');assert.equal(machine,null);assert.equal(isNew,true);assert.equal(h.messages.length,0);
});
test('Tasks opens the personal editor and carries the same preset',async()=>{
 const h=harness();await h.create('personal',{assignee:'Ilqar'});assert.equal(h.calls[0][0],'activate');assert.equal(h.calls[1][0],'personal');assert.equal(h.calls[1][1].date,'2026-10-29');assert.equal(h.calls[1][1].assignees[0],'Ilqar');
});
test('header add does not invent an employee',async()=>{
 const h=harness();await h.create('todo');assert.equal(h.calls[0][1].tapsirildi.length,0);
});
test('invalid sources and users without create permission cannot open a draft',async()=>{
 const h=harness({role:'manager',rules:{actions:[]}});await h.create('todo');assert.equal(h.calls.length,0);
 const admin=harness();await admin.create('unknown');assert.equal(admin.calls.length,0);
});
test('equipment creation respects section and action access',async()=>{
 const h=harness({role:'manager',rules:{actions:['create']}},{user:{},section:()=>false,action:()=>true});await h.create('gorulen');assert.equal(h.calls.length,0);assert.equal(h.messages.length,1);
});
test('header and employee add buttons share one source picker',()=>{
 assert.match(source,/\['todo', 'ToDo'/);assert.match(source,/\['gorulen', 'Gorulen isler'/);assert.match(source,/\['personal', 'Tasks'/);
 assert.match(source,/\(\) => addTask\(\)/);assert.match(source,/\(\) => addTask\(person\)/);
 assert.match(source,/event\.stopPropagation\(\); dismiss\(\)/);
});
