'use strict';
const fs=require('node:fs'),path=require('node:path');
function problem(message,code='INVALID_MANAGEMENT',statusCode=400){return Object.assign(new Error(message),{code,statusCode})}
function dateKey(value){if(typeof value!=='string'||!/^\d{4}-\d{2}-\d{2}$/.test(value)||!Number.isFinite(Date.parse(value+'T12:00:00Z'))||new Date(value+'T12:00:00Z').toISOString().slice(0,10)!==value)throw problem('Etibarsız tarix');return value}
function taskId(value){if(typeof value!=='string'||!value.trim()||value.length>100||['__proto__','constructor','prototype'].includes(value.trim()))throw problem('Etibarsızdır ID tapşırıqları');return value.trim()}
function integer(value,min,max,name){if(!Number.isInteger(value)||value<min||value>max)throw problem(name+': etibarlı tam ədəd '+min+' üçün '+max);return value}
function working(task){return !task.completed&&['in progress','is gedir'].includes(String(task.status||task.process||'').trim().toLowerCase())}
class TaskManagementStore{
 constructor(file){this.file=file;this.state={version:1,revision:0,settings:{dailyTaskLimit:4,wipLimit:2,budgetMinutes:120,staleDays:14},days:{},tasks:{}};if(file&&fs.existsSync(file)){const saved=JSON.parse(fs.readFileSync(file,'utf8'));if(saved.version!==1||!saved.settings||!saved.days||!saved.tasks)throw Error('Yanlış fayl task-management.json');this.state=saved}}
 getEstimate(id){const value=this.state.tasks[String(id)]?.estimateMinutes;return Number.isInteger(value)&&value>=1&&value<=43200?value:null}
 snapshot(){return structuredClone(this.state)}
 commit(next){next.revision=this.state.revision+1;if(this.file){fs.mkdirSync(path.dirname(this.file),{recursive:true});const temp=this.file+'.tmp';fs.writeFileSync(temp,JSON.stringify(next),{mode:0o600});fs.renameSync(temp,this.file)}this.state=next;return this.snapshot()}
 update(body){if(!body||typeof body!=='object')throw problem('Komanda yoxdur');if(body.expectedRevision!==undefined&&body.expectedRevision!==this.state.revision)throw problem('Plan başqa cihazda dəyişdirilib. Ekranınızı yeniləyin və yenidən cəhd edin.','MANAGEMENT_CONFLICT',409);const next=this.snapshot();const type=body.type;
  if(type==='settings'){for(const [name,min,max] of [['dailyTaskLimit',1,12],['wipLimit',1,10],['budgetMinutes',15,1440],['staleDays',1,180]])if(body[name]!==undefined)next.settings[name]=integer(body[name],min,max,name)}
  else if(type==='completion'){const id=taskId(body.id),old=next.tasks[id]||{};next.tasks[id]={...old,completed:body.completed===true,completedAt:body.completed===true?(old.completed&&old.completedAt||((typeof body.completedAt==='string'&&Number.isFinite(Date.parse(body.completedAt)))?body.completedAt:new Date().toISOString())):null,completionDateSource:body.completionDateSource||old.completionDateSource||'recorded'};}
  else if(type==='archive'){const id=taskId(body.id);next.tasks[id]={...next.tasks[id],deleted:true,deletedAt:new Date().toISOString()};}
  else if(type==='parent'){const id=taskId(body.id),parent=body.parentId?taskId(body.parentId):'';const seen=new Set([id]);let p=parent;while(p){if(seen.has(p))throw problem('Alt tapşırıqda əsas element ola bilməz');seen.add(p);p=next.tasks[p]?.parentId||'';}next.tasks[id]={...next.tasks[id],parentId:parent};}
  else if(type==='estimate'){const id=taskId(body.id);if(body.minutes===null){next.tasks[id]={...next.tasks[id]};delete next.tasks[id].estimateMinutes}else next.tasks[id]={...next.tasks[id],estimateMinutes:integer(body.minutes,1,43200,'Vaxt təxmini')}}
  else if(type==='day-add'||type==='day-remove'||type==='main'){
   const id=taskId(body.id),day=dateKey(body.day),plan=next.days[day]||{ids:[],mainId:''};next.days[day]=plan;
   if(type==='day-remove'){plan.ids=plan.ids.filter(x=>x!==id);if(plan.mainId===id)plan.mainId=''}
   else{if(!plan.ids.includes(id)){if(plan.ids.length>=next.settings.dailyTaskLimit)throw problem('Artıq plandadır '+next.settings.dailyTaskLimit+' tapşırıqlar. Birini silin və ya limiti dəyişdirin.','DAY_LIMIT',409);plan.ids.push(id)}if(type==='main'||body.main===true)plan.mainId=id;next.tasks[id]={...next.tasks[id],disposition:'active',checkDate:'',reviewedAt:new Date().toISOString()}}
  }else if(type==='review'){
   const id=taskId(body.id);if(!['later','waiting','active'].includes(body.disposition))throw problem('Problemin səhv həlli');const checkDate=body.checkDate?dateKey(body.checkDate):'';if(body.disposition!=='active'&&!checkDate)throw problem('Növbəti çekin tarixini göstərin');if(body.disposition==='waiting'&&!String(body.owner||'').trim())throw problem('Məsul şəxsi göstərin');next.tasks[id]={...next.tasks[id],disposition:body.disposition,checkDate,owner:String(body.owner||'').trim().slice(0,200),reviewedAt:new Date().toISOString()};if(body.disposition!=='active')for(const plan of Object.values(next.days)){plan.ids=plan.ids.filter(x=>x!==id);if(plan.mainId===id)plan.mainId=''}
  }else if(type==='finish'){
   const id=taskId(body.id);const old=next.tasks[id]||{};next.tasks[id]={...old,completed:true,completedAt:old.completed&&old.completedAt||new Date().toISOString()};for(const plan of Object.values(next.days)){plan.ids=plan.ids.filter(x=>x!==id);if(plan.mainId===id)plan.mainId=''}
  }else throw problem('Naməlum əmr');
  return this.commit(next)
 }
 checkWip(tasks,id,override=false){const active=tasks.filter(working),already=active.some(t=>String(t.id)===String(id));if(!already&&active.length>=this.state.settings.wipLimit&&override!==true)throw Object.assign(problem('Artıq '+active.length+' tapşırıqlar limitlə işləyir '+this.state.settings.wipLimit+'. Birini tamamlayın və ya artıqlığı təsdiq edin.','WIP_LIMIT',409),{activeCount:active.length,limit:this.state.settings.wipLimit});return active.length}
}
module.exports={TaskManagementStore,working,dateKey};
