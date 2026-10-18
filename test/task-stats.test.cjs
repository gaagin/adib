'use strict';
const test=require('node:test');
const assert=require('node:assert/strict');
const {summarize,scopedTasks,WINDOW}=require('../task-stats');
function localDateOffset(now,days,hours=12){const d=new Date(now);d.setDate(d.getDate()-days);d.setHours(hours,0,0,0);return d.toISOString()}
test('counts completed tasks by local day within the last seven-day window',()=>{
 const now=new Date(2026,9,18,15,0,0,0).getTime();
 const tasks=[
  {id:'today',completed:true,completedAt:localDateOffset(now,0,11)},
  {id:'two-days',status:'Done',completedAt:localDateOffset(now,2,10)},
  {id:'open',completed:false,completedAt:localDateOffset(now,1,10)},
  {id:'too-old',completed:true,completedAt:new Date(now-WINDOW-1000).toISOString()},
  {id:'missing-time',completed:true},
  {id:'future',completed:true,completedAt:new Date(now+600000).toISOString()}
 ];
 const result=summarize(tasks,now,'en-US');
 assert.equal(result.days.length,7);assert.equal(result.total,2);
 assert.equal(result.days[6].count,1);assert.equal(result.days[4].count,1);
});
test('aggregates descendant plans and their equipment, while machine scope stays local',()=>{
 const data={plans:[
  {id:'root',parentId:'',tasks:[{id:'a'}]},
  {id:'child',parentId:'root',tasks:[{id:'b'}]},
  {id:'other',parentId:'',tasks:[{id:'c'}]}
 ],equipment:[
  {id:'m1',planId:'child',tasks:[{id:'d'},{id:'b'}]},
  {id:'m2',planId:'other',tasks:[{id:'e'}]}
 ]};
 assert.deepEqual(scopedTasks(data,'plan:root').map(t=>t.id),['a','b','d']);
 assert.deepEqual(scopedTasks(data,'machine:m2').map(t=>t.id),['e']);
 assert.equal(scopedTasks(data,'all').length,5);
});
test('equipment overflow menu is wired to the statistics module and task data export',()=>{
 const fs=require('node:fs'),path=require('node:path'),root=path.join(__dirname,'..');
 const menu=fs.readFileSync(path.join(root,'compact-design.js'),'utf8'),html=fs.readFileSync(path.join(root,'ela-nov-paketleme-dynamic.html'),'utf8'),server=fs.readFileSync(path.join(root,'server.js'),'utf8');
 assert.match(menu,/Son 7 gün · tamamlanan tapşırıqlar/);assert.match(menu,/ADIBTaskStats\?\.open/);
 assert.match(html,/ADIBEquipmentCalendar\.statsSnapshot=/);assert.match(html,/task-stats\.js\?v=/);assert.match(server,/"task-stats\.js"/);
});
