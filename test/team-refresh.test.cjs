const test=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const path=require('node:path');
const vm=require('node:vm');
const {buildTeamDashboard}=require('../team-dashboard');
const source=fs.readFileSync(path.join(__dirname,'../team-view.js'),'utf8');
const tick=()=>new Promise(resolve=>setImmediate(resolve));
function harness(fetch){
 const button={disabled:false},root={hidden:true,style:{},querySelector:()=>({focus(){},...button}),setAttribute(){}};
 const classList={add(){},remove(){},contains(){return false}};
 const document={documentElement:{classList},body:{classList},querySelector:()=>null,getElementById:()=>null};
 const window={innerWidth:1000};
 const code=source.replace(/  if \(document.readyState === 'loading'\)[\s\S]*?else init\(\);/,`window.testAPI={load,show,close,refreshFromChanges,get:()=>payload,setup:r=>{root=r;render=()=>window.renders.push(payload);setMessage=()=>{};}};`);
 vm.runInNewContext(code,{window,document,fetch,setTimeout,clearTimeout,setInterval:()=>1,clearInterval,Intl,Date,console});
 window.renders=[];window.testAPI.setup(root);return {...window.testAPI,root,renders:window.renders};
}
const response=value=>({ok:true,json:async()=>value});
test('reopening a cached team dashboard immediately requests current tasks',async()=>{
 let tasks=[{id:'deleted'}],calls=0;const app=harness(async()=>{calls++;return response({employees:[{tasks:[...tasks]}]})});
 app.show();await tick();assert.equal(app.get().employees[0].tasks.length,1);app.close();tasks=[];
 app.show();await tick();assert.equal(calls,2);assert.equal(app.get().employees[0].tasks.length,0);app.close();
});
test('task mutations refresh visible dashboards without waiting for fallback poll',async()=>{
 let calls=0;const app=harness(async()=>{calls++;return response({employees:[]})});app.show();await tick();
 app.refreshFromChanges();app.refreshFromChanges();await new Promise(r=>setTimeout(r,130));await tick();
 assert.equal(calls,2);app.close();
});
test('a pre-deletion response cannot restore deleted cards',async()=>{
 let resolveOld,calls=0;const app=harness(()=>{calls++;return calls===1?new Promise(r=>resolveOld=r):Promise.resolve(response({employees:[],fresh:true}))});
 app.show();app.refreshFromChanges();resolveOld(response({employees:[{tasks:[{id:'deleted'}]}],stale:true}));await tick();await tick();
 assert.equal(calls,2);assert.equal(app.get().fresh,true);assert(!app.renders.some(row=>row.stale));app.close();
});
test('hidden dashboards do not poll after task mutation',async()=>{
 let calls=0;const app=harness(async()=>{calls++;return response({employees:[]})});app.refreshFromChanges();await new Promise(r=>setTimeout(r,130));assert.equal(calls,0);
});
test('deleted and archived tasks are absent from cards and counters',()=>{
 const task={id:'one',title:'Removed',kind:'equipment',tapsirildi:['Ilqar'],date:'2026-10-01'};
 const data=buildTeamDashboard({users:[{id:'worker',name:'Ilqar'}],tasks:[task,{...task,deleted:true},{...task,id:'two',archived:true},{...task,id:'three',in_trash:true}],now:Date.parse('2026-10-29T12:00:00Z')});
 assert.equal(data.employees[0].taskCount,0);assert.equal(data.employees[0].nextTask,null);assert.equal(data.totals.overdue,0);assert.equal(data.totals.tasks,0);
});
test('team listens to the shared stores and visibility/focus updates',()=>{
 for(const event of ['adib-home-data','adib-equipment-data','adib-work-data','adib-work-changed','adib-autosaved'])assert(source.includes(event));
 assert.match(source,/addEventListener\('visibilitychange'/);assert.match(source,/addEventListener\('focus'/);
});
