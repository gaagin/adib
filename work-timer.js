'use strict';
const fs=require('node:fs'),path=require('node:path'),crypto=require('node:crypto');
const FIELD='İş vaxtı, dəq',key=v=>String(v||'').replace(/-/g,'').toLowerCase();
const fail=(message,statusCode=400,code='WORK_TIMER_ERROR')=>Object.assign(Error(message),{statusCode,code});
class WorkTimerStore{
 constructor({file,now,notion,sources,changed=()=>{}}){Object.assign(this,{file,now,notion,sources,changed});this.tail=Promise.resolve();this.data={version:1,revision:0,sessions:[],tasks:{}};if(fs.existsSync(file)){const d=JSON.parse(fs.readFileSync(file,'utf8'));if(d.version!==1||!Array.isArray(d.sessions)||!d.tasks)throw Error('Invalid work timer store');this.data=d;}}
 locked(fn){const job=this.tail.catch(()=>{}).then(fn);this.tail=job;return job;}
 save(){fs.mkdirSync(path.dirname(this.file),{recursive:true});const temp=this.file+'.tmp',fd=fs.openSync(temp,'w',0o600);try{fs.writeFileSync(fd,JSON.stringify(this.data));fs.fsyncSync(fd);}finally{fs.closeSync(fd);}fs.renameSync(temp,this.file);}
 commit(change){const old=structuredClone(this.data);try{change();this.data.revision++;this.save();}catch(e){this.data=old;throw e;}this.changed();}
 async page(id){if(!/^[a-f0-9]{32}$/.test(key(id)))throw fail('Tapşırıq ID-si etibarsızdır');const p=await this.notion('/pages/'+id,{method:'GET'});if(p.archived||p.in_trash)throw fail('Tapşırıq silinib',409);let source=this.sources().find(s=>s.ds&&key(s.ds)===key(p.parent?.data_source_id)||s.db&&key(s.db)===key(p.parent?.database_id));if(!source&&p.parent?.data_source_id){const schema=await this.notion('/data_sources/'+p.parent.data_source_id,{method:'GET'});source=this.sources().find(s=>s.db&&key(s.db)===key(schema.parent?.database_id));}if(!source)throw fail('İş taymeri yalnız ToDo və Görülən işlər üçündür');return {p,source};}
 async schema(source,ds,allow){const uri=ds?'/data_sources/'+ds:'/databases/'+source.db;const api=ds?undefined:'2022-06-28';const d=await this.notion(uri,{method:'GET'},api),f=d.properties?.[FIELD];if(f&&f.type!=='number'&&!f.number)throw fail(FIELD+' sahəsi rəqəm tipində olmalıdır',409);if(!f){if(!allow)throw fail('Administrator əvvəlcə '+FIELD+' sahəsini yaratmalıdır',409,'WORK_SCHEMA_REQUIRED');await this.notion(uri,{method:'PATCH',body:JSON.stringify({properties:{[FIELD]:{number:{format:'number'}}}})},api);}}
 async setup(actor){if(actor?.role!=='admin')throw fail('Yalnız administrator',403);for(const source of this.sources())await this.schema(source,source.ds,true);return {ok:true,field:FIELD};}
 total(id){const t=this.data.tasks[key(id)];return Math.round(((t?.baseSeconds||0)+this.data.sessions.filter(s=>key(s.taskId)===key(id)&&s.status==='saved').reduce((n,s)=>n+s.seconds,0))/60*1000)/1000;}
 snapshot(actor,allowed){const sessions=this.data.sessions.filter(s=>allowed(s.taskId));return {ok:true,serverNow:this.now(),revision:this.data.revision,sessions:structuredClone(sessions),own:sessions.filter(s=>s.actorId===actor.id&&s.status!=='saved'),totals:Object.fromEntries(Object.values(this.data.tasks).filter(t=>allowed(t.id)).map(t=>[t.id,this.total(t.id)])),syncPending:Object.values(this.data.tasks).filter(t=>t.dirty&&allowed(t.id)).map(t=>t.id),field:FIELD};}
 async flush(){if(this.flushing)return this.flushing;this.flushing=(async()=>{for(const row of Object.values(this.data.tasks)){if(!row.dirty)continue;const id=row.id,total=this.total(id);try{await this.notion('/pages/'+id,{method:'PATCH',body:JSON.stringify({properties:{[FIELD]:{number:total}}})});await this.locked(()=>{const t=this.data.tasks[key(id)];if(this.total(id)===total)this.commit(()=>{t.dirty=false;delete t.syncError;});});}catch(e){await this.locked(()=>{const t=this.data.tasks[key(id)];if(t){t.syncError=String(e.message).slice(0,300);this.save();}});}}})().finally(()=>this.flushing=null);return this.flushing;}
 async action(b,actor,task){let prepared;
 if(b.action==='start'){
 const token=String(b.operationId||'');if(!/^[a-zA-Z0-9-]{8,100}$/.test(token))throw fail('Əməliyyat ID-si tələb olunur');
 const duplicate=this.data.sessions.find(x=>x.startOperation===token&&x.actorId===actor.id);if(duplicate)return {ok:true,session:structuredClone(duplicate)};
 if(this.data.sessions.some(x=>x.actorId===actor.id&&x.status!=='saved'))throw fail('Əvvəlki işi dayandırın və vaxtı təsdiqləyin',409,'WORK_ALREADY_ACTIVE');
 if(!task||task.completed)throw fail('Tapşırıq tapılmadı və ya tamamlanıb',409);prepared=await this.page(task.id);
 const {p,source}=prepared,assigned=(p.properties?.Tapsirildi?.multi_select||[]).map(x=>x.name),worker=String(b.worker||actor.assignee||actor.name||'').trim();
 if(!assigned.includes(worker))throw fail('İşçi Tapsirildi sahəsində seçilməlidir',409);if(actor.role!=='admin'&&worker!==actor.assignee&&worker!==actor.name)throw fail('Yalnız öz adınızla iş başlada bilərsiniz',403);
 await this.schema(source,p.parent?.data_source_id,actor.role==='admin');
 }
 return this.locked(async()=>{const at=this.now();if(!Number.isFinite(at))throw fail('Şəbəkə vaxtı təsdiqlənməyib',503);const token=String(b.operationId||'');if(!/^[a-zA-Z0-9-]{8,100}$/.test(token))throw fail('Əməliyyat ID-si tələb olunur');let s=this.data.sessions.find(x=>x.id===b.sessionId);
 if(b.action==='start'){
 const duplicate=this.data.sessions.find(x=>x.startOperation===token&&x.actorId===actor.id);if(duplicate)return {ok:true,session:structuredClone(duplicate)};
 const current=this.data.sessions.find(x=>x.actorId===actor.id&&x.status!=='saved');if(current)throw Object.assign(fail('Əvvəlki işi dayandırın və vaxtı təsdiqləyin',409,'WORK_ALREADY_ACTIVE'),{session:structuredClone(current)});
 if(!task)throw fail('Tapşırıq tapılmadı',404);if(task.completed)throw fail('Tamamlanmış tapşırıqda iş başlatmaq olmaz',409);
 const {p,source}=prepared,assigned=(p.properties?.Tapsirildi?.multi_select||[]).map(x=>x.name),worker=String(b.worker||actor.assignee||actor.name||'').trim();if(!assigned.includes(worker))throw fail('İşçi Tapsirildi sahəsində seçilməlidir',409);if(actor.role!=='admin'&&worker!==actor.assignee&&worker!==actor.name)throw fail('Yalnız öz adınızla iş başlada bilərsiniz',403);
 // One employee cannot run overlapping sessions from two accounts/devices.
 if(this.data.sessions.some(x=>x.worker===worker&&x.status!=='saved'))throw fail('Bu əməkdaşın artıq açıq işi var',409,'WORK_ALREADY_ACTIVE');
 const field=p.properties?.[FIELD];if(field&&field.type!=='number'&&!('number'in field))throw fail('Vaxt sahəsinin tipi yanlışdır',409);if(this.data.sessions.length>=100000)throw fail('Seans arxivi limitinə çatıb; administratorla əlaqə saxlayın',507);
 s={id:crypto.randomUUID(),taskId:task.id,sourceKey:source.key,title:task.title||'Tapşırıq',actorId:actor.id,actorName:actor.name,worker,status:'running',startedAt:at,endedAt:null,seconds:0,revision:1,startOperation:token};this.commit(()=>{this.data.tasks[key(task.id)]??={id:task.id,baseSeconds:Math.max(0,Number(field?.number)||0)*60,dirty:false};this.data.sessions.push(s);});return {ok:true,session:structuredClone(s)};
 }
 if(!s)throw fail('Seans tapılmadı',404);if(s.actorId!==actor.id)throw fail('Başqa əməkdaşın seansını dəyişmək olmaz',403);
 if(s.lastOperation===token)return {ok:true,session:structuredClone(s),totalMinutes:this.total(s.taskId)};
 if(Number(b.revision)!==s.revision)throw fail('Seans digər cihazda dəyişib. Yeniləyin',409,'WORK_STALE');
 if(b.action==='stop'){if(s.status!=='running')throw fail('Taymer artıq dayanıb',409);this.commit(()=>{s.status='pending';s.endedAt=at;s.seconds=Math.max(0,(at-s.startedAt)/1000);s.revision++;s.lastOperation=token;});}
 else if(b.action==='resume'){if(s.status!=='pending')throw fail('Yalnız təsdiq gözləyən seans davam etdirilə bilər',409);this.commit(()=>{s.status='running';s.endedAt=null;s.seconds=0;s.revision++;s.lastOperation=token;});}
 else if(b.action==='save'){
 if(s.status!=='pending')throw fail('Əvvəlcə taymeri dayandırın',409);const start=Number(b.startedAt),end=Number(b.endedAt);if(!Number.isFinite(start)||!Number.isFinite(end)||start<0||end<=start||end>at+1000||start<s.startedAt||end>s.endedAt+1000)throw fail('Başlanğıc/son vaxtı etibarsızdır; qeydə alınmış interval daxilində seçin');
 if(this.data.sessions.some(x=>x.id!==s.id&&(x.actorId===actor.id||x.worker===s.worker)&&x.status==='saved'&&start<x.endedAt&&end>x.startedAt))throw fail('Bu vaxt digər iş seansı ilə üst-üstə düşür',409);
 this.commit(()=>{s.originalStartedAt=s.startedAt;s.originalEndedAt=s.endedAt;s.startedAt=start;s.endedAt=end;s.seconds=(end-start)/1000;s.status='saved';s.revision++;s.lastOperation=token;this.data.tasks[key(s.taskId)].dirty=true;});
 }else throw fail('Yanlış taymer əməliyyatı');return {ok:true,session:structuredClone(s),totalMinutes:this.total(s.taskId),syncPending:!!this.data.tasks[key(s.taskId)].dirty};
 });}
}
module.exports={WorkTimerStore,FIELD};
