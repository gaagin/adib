const test=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const path=require('node:path');
const history=require('../task-history.js');

test('completed tasks are visible only inside the last seven days',()=>{
  const now=Date.parse('2026-10-17T12:00:00Z');
  assert.equal(history.visible({id:'recent',completed:true,completedAt:new Date(now-6*86400000).toISOString()},now),true);
  assert.equal(history.visible({id:'old',completed:true,completedAt:new Date(now-8*86400000).toISOString()},now),false);
  assert.equal(history.visible({id:'open',completed:false},now),true);
});

test('completed tasks fail closed when a usable current timestamp is unavailable',()=>{
  const done={id:'done',completed:true,completedAt:'2026-10-17T11:00:00Z'};
  assert.equal(history.visible(done,NaN),false);
  assert.equal(history.visible({id:'open',completed:false},NaN),true);
});

test('partial realtime snapshots preserve known tasks if the task read failed',()=>{
  const old={id:'active',title:'Still working',completed:false};
  const newer={id:'updated',title:'Fresh row',completed:false};
  const merged=history.mergeTaskSnapshot([old], [newer], {partial:true,successful:['containers']});
  assert.deepEqual(merged,[old,newer]);
});

test('personal realtime rendering uses the partial-snapshot task preservation guard',()=>{
  const html=fs.readFileSync(path.join(__dirname,'../ela-nov-paketleme-dynamic.html'),'utf8');
  assert.match(html,/mergeTaskSnapshot\(personalTasks,snapshot\.tasks,sync\)/);
  assert.match(html,/mergeTaskSnapshot\(window\.ADIBPersonalPomodoroTasks,snapshot\.pomodoroTasks,sync\)/);
});

test('healthy task snapshots remain authoritative and may remove missing tasks',()=>{
  const old={id:'archived',title:'Archived'};
  const incoming={id:'active',title:'Active'};
  assert.deepEqual(history.mergeTaskSnapshot([old], [incoming], {partial:false,successful:['tasks','containers']}),[incoming]);
  assert.deepEqual(history.mergeTaskSnapshot([old], [incoming], {partial:true,successful:['tasks']}),[incoming]);
});

test('Azerbaijani completion statuses with diacritics are treated as completed',()=>{
  const now=Date.parse('2026-10-17T12:00:00Z');
  for(const status of ['Tamamlandı','İş görüldü','İş görülüb']){
    assert.equal(history.done({status}),true,status);
  }
  assert.equal(history.visible({id:'old',status:'Tamamlandı',completedAt:new Date(now-8*86400000).toISOString()},now),false);
  assert.equal(history.visible({id:'recent',process:'İş görüldü',completedAt:new Date(now-6*86400000).toISOString()},now),true);
  assert.equal(history.done({status:'Problem həll olunmayıb'}),false);
});

test('equipment snapshots keep open work from the last seven days and upcoming work only',()=>{
  const now=Date.parse('2026-10-17T12:00:00Z');
  const date=days=>new Date(now+days*86400000).toISOString();
  assert.equal(history.visibleEquipment({id:'recent',completed:false,date:date(-6)},now),true);
  assert.equal(history.visibleEquipment({id:'old',completed:false,date:date(-8)},now),false);
  assert.equal(history.visibleEquipment({id:'future',completed:false,date:date(30)},now),true);
  assert.equal(history.visibleEquipment({id:'recently-created-undated',completed:false,createdAt:date(-1),updatedAt:date(-1)},now),true);
  assert.equal(history.visibleEquipment({id:'old-created-recently-edited-undated',completed:false,createdAt:'2023-06-11T10:00:00Z',updatedAt:date(-1)},now),false);
  assert.equal(history.visibleEquipment({id:'old-undated',completed:false,updatedAt:date(-10)},now),false);
  assert.equal(history.visibleEquipment({id:'recent-date-old-completion',completed:true,date:date(-1),completedAt:date(-8)},now),false);
  assert.equal(history.visibleEquipment({id:'old-date-recent-completion',completed:true,date:date(-30),completedAt:date(-1)},now),false);
  assert.equal(history.visibleEquipment({id:'old-due-date',completed:true,date:'2023-06-11',completedAt:date(-1)},now),false);
  assert.equal(history.visibleEquipment({id:'recent-date-recent-completion',completed:true,date:date(-1),completedAt:date(-1)},now),true);
  assert.equal(history.visibleEquipment({id:'recently-completed-untimed-due-date',completed:true,createdAt:'2023-06-11T10:00:00Z',completedAt:date(-1),completionDateSource:'recorded'},now),true);
  assert.equal(history.visibleEquipment({id:'old-estimated-completion',completed:true,createdAt:'2023-06-11T10:00:00Z',updatedAt:date(-1),completedAt:date(-1),completionDateSource:'last-edited-estimate'},now),false);
});

test('server filters equipment snapshots and Notion reads to the rolling window',()=>{
  const server=fs.readFileSync(path.join(__dirname,'../server.js'),'utf8');
  assert.match(server,/if\(!includeCompleted&&!taskHistory\.visibleEquipment\(task\)\)continue/);
  assert.match(server,/pomodoroTasks:\[\.\.\.buildTaskMap\(taskSets,machineIds,baseUrl,true\)\.values\(\)\]\.flat\(\)\.filter\(task=>taskHistory\.visibleEquipment\(task\)\)/);
  assert.match(server,/equipmentTaskWindowFilter\(spec\.dateName\)/);
  assert.match(server,/createdAt:page\.created_time/);
  assert.match(server,/windowVersion>0&&cursor\.windowVersion!==windowVersion/);
});