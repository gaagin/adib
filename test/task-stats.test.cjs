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
 assert.match(html,/ADIBEquipmentCalendar\.statsSnapshot=/);assert.match(html,/title:String\(t\.title\|\|t\.name\|\|'Tapşırıq'\)/);assert.match(html,/open:async\(id,options=\{\}\)/);assert.match(html,/if\(options\.returnToStats\)setTimeout/);assert.match(menu,/ADIBTaskStats\?\.open/);assert.match(html,/task-stats\.js\?v=/);assert.match(server,/"task-stats\.js"/);const chart=fs.readFileSync(path.join(root,'task-stats.js'),'utf8');assert.match(chart,/event\.preventDefault\(\); backToOverview\(\)/);assert.match(chart,/returnToStats: true/);const css=fs.readFileSync(path.join(root,'focused-views.css'),'utf8');assert.match(css,/dialog\.adib-task-stats-dialog\{position:fixed!important;inset:0!important/);assert.match(css,/adib-task-stats-task-list/);
});

test('pie chart distributes recent completed tasks among equipment in the selected plan',()=>{
 const now=new Date(2026,9,18,15,0,0,0).getTime();
 const recent=offset=>new Date(now-offset*60*60*1000).toISOString();
 const data={plans:[{id:'root',parentId:''},{id:'child',parentId:'root'},{id:'other',parentId:''}],equipment:[
  {id:'m1',name:'M1',planId:'child',tasks:[{id:'a',completed:true,completedAt:recent(1)},{id:'b',completed:true,completedAt:recent(2)},{id:'c',completed:true,completedAt:recent(3)},{id:'old',completed:true,completedAt:new Date(now-8*24*60*60*1000).toISOString()}]},
  {id:'m2',name:'M2',planId:'root',tasks:[{id:'d',status:'Done',completedAt:recent(4)},{id:'e',done:true,completedAt:recent(5)}]},
  {id:'m3',name:'M3',planId:'other',tasks:[{id:'f',completed:true,completedAt:recent(6)}]}
 ]};
 const {equipmentBreakdown}=require('../task-stats');
 const result=equipmentBreakdown(data,'plan:root',now,'en-US');
 assert.deepEqual(result.items.map(item=>[item.name,item.count]),[['M1',3],['M2',2]]);
 assert.equal(result.total,5);
 const all=equipmentBreakdown(data,'all',now,'en-US');
 assert.deepEqual(all.items.map(item=>[item.name,item.count]),[['M1',3],['M2',2],['M3',1]]);
 assert.equal(all.total,6);
});


test('hides zero-count equipment, sorts by share, and opens only its recent completed tasks',()=>{
 const now=new Date(2026,9,18,15,0,0,0).getTime(),recent=hours=>new Date(now-hours*3600000).toISOString();
 const data={plans:[{id:'p',parentId:''}],equipment:[
  {id:'m1',name:'M1',planId:'p',tasks:[{id:'a',title:'A1',completed:true,completedAt:recent(1)},{id:'b',title:'A2',completed:true,completedAt:recent(2)},{id:'old',title:'Old',completed:true,completedAt:new Date(now-9*86400000).toISOString()}]},
  {id:'m2',name:'M2',planId:'p',tasks:[{id:'c',title:'B1',completed:true,completedAt:recent(3)}]},
  {id:'m3',name:'M3',planId:'p',tasks:[{id:'open',title:'Open',completed:false,completedAt:recent(4)}]}
 ]};
 const {equipmentBreakdown,completedTasksForEquipment}=require('../task-stats');
 const stats=equipmentBreakdown(data,'plan:p',now,'en-US');
 assert.deepEqual(stats.items.map(item=>[item.name,item.count]),[['M1',2],['M2',1]]);
 assert.equal(stats.equipmentCount,3);assert.equal(stats.total,3);
 assert.deepEqual(completedTasksForEquipment(data,'m1',now).map(task=>task.title),['A1','A2']);
});
