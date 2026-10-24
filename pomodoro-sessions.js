'use strict';
const crypto=require('node:crypto'),{canonicalDuration,timerFromTask}=require('./pomodoro-shared'),{FIELD:TASK_ESTIMATE_FIELD,validMinutes}=require('./task-estimate');
const GLOBAL='00000000-0000-4000-8000-000000000001';
const fail=(text,statusCode=409,code='POMODORO_SESSION')=>Object.assign(Error(text),{statusCode,code});
class PomodoroSessions{
 constructor({store,loadTask,patchTask,saveSession=async()=>null,authorizeOther=async()=>{},now=()=>Date.now(),changed=()=>{}}){Object.assign(this,{store,loadTask,patchTask,saveSession,authorizeOther,now,changed});this.tail=Promise.resolve()}
 locked(fn){const p=this.tail.then(fn);this.tail=p.catch(()=>{});return p}
 handle(body){return this.locked(()=>this.run(body))}
 async flushSessionLog(session){
  if(!session||session.completionReason==='cancelled'||!['saved','sync-pending'].includes(session.status)||!session.notionLogEligible||session.notionPageId||(session.notionRetryAt||0)>this.now())return;
  try{
   const result=await this.saveSession(session);
   const current=this.store.sessions.find(s=>s.id===session.id);
   if(current){this.store.commit(null,{...current,status:'saved',notionPageId:result?.id||'recorded',notionSyncPending:false,notionSyncError:'',notionRetryAt:0,notionSyncFailures:0},null);this.changed();}
  }catch(e){
   const current=this.store.sessions.find(s=>s.id===session.id);if(!current)return;
   const attempts=(current.notionSyncFailures||0)+1;
   this.store.commit(null,{...current,notionSyncPending:true,notionSyncError:String(e.message||e).slice(0,300),notionSyncFailures:attempts,notionRetryAt:this.now()+Math.min(1800000,60000*2**Math.min(5,attempts-1))},null);this.changed();
  }
 }
 async flushJob(job){if(!job||job.retryAt>this.now())return;let patched=false;try{await this.patchTask(job.taskId,job.properties);patched=true;}catch(e){const attempts=(job.attempts||0)+1;this.store.commit(null,null,{...job,attempts,retryAt:this.now()+Math.min(1800000,60000*2**Math.min(5,attempts-1))});}if(patched){const timer=this.store.get(job.taskId);const session=this.store.sessions.find(s=>s.id===job.sessionId);this.store.commit(timer?{...timer,syncPending:false}:null,session?{...session,status:'saved'}:null,{taskId:job.taskId,remove:true});this.changed();}const session=this.store.sessions.find(s=>s.id===job.sessionId);if(session)await this.flushSessionLog(session);}
 retryDue(){return this.locked(async()=>{for(const job of [...this.store.jobs])await this.flushJob(job);for(const session of [...this.store.sessions])await this.flushSessionLog(session)})}
 finishExpired(){return this.locked(async()=>{const now=this.now();let firstError=null;for(const timer of [...this.store.timers.values()])if(timer.running&&Number.isFinite(Number(timer.endsAt))&&Number(timer.endsAt)>0&&Number(timer.endsAt)<=now){try{await this.run({id:timer.id,action:timer.mode==='break'?'break-finish':'finish',sessionId:timer.sessionId})}catch(error){firstError ||= error}}if(firstError)throw firstError})}
 answer(timer,extra={}){return{ok:true,id:timer.id,timer,serverNow:this.now(),pomodoroCount:timer.pomodoroCount,pomodoroMinutes:timer.pomodoroMinutes,syncPending:!!timer.syncPending,...extra}}
 async finish(timer,{cancelled=false,natural=false}={}){
  const now=this.now(),start=Date.parse(timer.startedAt);if(!Number.isFinite(start))throw fail('Seansın başlanğıcı məlum deyil');
  const planned=canonicalDuration(timer.plannedDuration||timer.duration,timer.mode),scheduledEnd=Number(timer.endsAt),naturalEnd=natural&&timer.mode!=='break'&&Number.isFinite(scheduledEnd)&&scheduledEnd>=start&&now>=scheduledEnd-1500,end=naturalEnd?scheduledEnd:Math.max(start,Math.min(now,scheduledEnd||now)),seconds=Math.max(0,(end-start)/1000),full=!cancelled&&timer.mode!=='break'&&(naturalEnd||seconds>=planned*60);
  const work=timer.mode!=='break',credited=work&&!cancelled?Math.round(seconds/60*1000)/1000:0,minutes=Math.round((Number(timer.pomodoroMinutes||0)+credited)*1000)/1000,count=Number(timer.pomodoroCount||0)+(full?1:0);
  const properties={'Начало отчета':{date:{start:timer.startedAt}},'Pomodoro текущая длительность':{number:planned},'Pomodoro режим':{select:{name:timer.mode==='break'?'Короткий перерыв — 5 мин':'Работа — 25 мин'}},'Отчет запущен':{checkbox:false},'Конец отчета':{date:{start:new Date(end).toISOString()}}};if(work){properties['Pomodoro количество']={number:count};properties['Pomodoro всего минут']={number:minutes};if(!cancelled&&timer.id!==GLOBAL&&credited>0){try{const current=await this.loadTask(timer.id),estimate=Number(current?.estimateMinutes),adjusted=Math.ceil(minutes);if(Number.isInteger(estimate)&&estimate>0&&validMinutes(adjusted)&&adjusted>estimate)properties[TASK_ESTIMATE_FIELD]={number:adjusted}}catch(error){/* Do not block saving a completed Pomodoro if reading its estimate fails. */}}}
  const session=work?{id:timer.sessionId,taskId:timer.id,title:timer.title,sourceKey:'personal',kind:'pomodoro',mode:'work',actorId:timer.actorId||'',worker:timer.worker||'',status:timer.id===GLOBAL?'saved':'sync-pending',startedAt:start,endedAt:end,seconds,plannedMinutes:planned,fullPomodoro:full,completionReason:cancelled?'cancelled':full?'elapsed':'early',startOperation:timer.startOperation||'',notionLogEligible:!cancelled&&timer.id!==GLOBAL,notionSyncPending:!cancelled&&timer.id!==GLOBAL}:null;
  const next={...timer,running:false,status:'completed',endsAt:0,remainingSeconds:0,completedAt:new Date(end).toISOString(),completionReason:cancelled?'cancelled':full?'elapsed':'early',creditedMinutes:credited,pomodoroMinutes:work?minutes:timer.pomodoroMinutes,pomodoroCount:work?count:timer.pomodoroCount,syncPending:timer.id!==GLOBAL,browserSessions:true,nextMode:cancelled?'work':work&&full?'break':'work'};
  const job=timer.id===GLOBAL?null:{taskId:timer.id,sessionId:session?.id||'',properties,retryAt:0,attempts:0};
  let durableSession=session;
  // Notion is the durable journal. Create the session row before the task
  // property PATCH so a task-sync failure cannot hold up the session record.
  if(session?.notionLogEligible){
   try{
    const result=await this.saveSession(session);
    durableSession={...session,status:'saved',notionPageId:result?.id||'recorded',notionSyncPending:false,notionSyncError:'',notionRetryAt:0,notionSyncFailures:0};
   }catch(e){
    const attempts=(session.notionSyncFailures||0)+1;
    durableSession={...session,status:'sync-pending',notionSyncPending:true,notionSyncError:String(e.message||e).slice(0,300),notionSyncFailures:attempts,notionRetryAt:this.now()+Math.min(1800000,60000*2**Math.min(5,attempts-1))};
   }
  }
  this.store.commit(next,durableSession,job);this.changed();if(job)await this.flushJob(job);else if(durableSession)await this.flushSessionLog(durableSession);return this.store.get(timer.id);
 }
 async run(body){const id=String(body.id),original=String(body.action),action=['pause','reset'].includes(original)?'finish':original;let timer=this.store.get(id);const now=this.now();if(!['open','hide','start','finish','break-finish','cancel'].includes(action))throw fail('Yanlış Pomodoro əməliyyatı',400);
  if(action==='cancel'&&!timer)throw fail('İşləyən Pomodoro tapılmadı',404);
  if(body.sessionId&&timer?.sessionId&&body.sessionId!==timer.sessionId&&action!=='open')return this.answer(timer,{stale:true,duplicate:true});
  if(['finish','break-finish','cancel'].includes(action)&&timer&&!timer.running){await this.flushJob(this.store.jobs.find(j=>j.taskId===id));return this.answer(this.store.get(id),{duplicate:true});}
  if(action==='start'){
   if(!/^[a-zA-Z0-9-]{8,100}$/.test(body.operationId||''))throw fail('Əməliyyat ID-si tələb olunur',400);
   if(timer?.startOperation===body.operationId||this.store.sessions.some(s=>s.taskId===id&&s.startOperation===body.operationId)){if(!timer)throw fail('Əvvəlki əməliyyat artıq tamamlanıb');return this.answer(timer,{duplicate:true});}
   if(timer?.running)return this.answer(timer,{duplicate:true});
   const job=this.store.jobs.find(j=>j.taskId===id);if(job){await this.flushJob(job);if(this.store.jobs.some(j=>j.taskId===id))throw fail('Əvvəlki seans Notion ilə sinxronizasiya gözləyir. Sonra yenidən cəhd edin',409,'POMODORO_SYNC_PENDING');timer=this.store.get(id)}
  }
  if(action==='hide'){if(!timer)throw fail('Taymer tapılmadı',404);return this.answer(this.store.put({...timer,windowHidden:true}))}
  if(['open','start'].includes(action)){
   const others=[...this.store.timers.values()].filter(t=>t.running&&t.id!==id);if(others.length){const token=crypto.createHash('sha256').update(JSON.stringify(others.map(t=>[t.id,t.sessionId,t.revision]).sort((a,b)=>a[0].localeCompare(b[0])))).digest('hex');for(const other of others)await this.authorizeOther(body.__account,other.id);if(body.confirmationToken!==token)throw Object.assign(fail('Başqa Pomodoro işləyir. Cari seansı bitirib yenisini açmaq?',409,'POMODORO_ACTIVE'),{confirmationToken:token});for(const other of others)await this.finish(other)}
  }
  let task=null;if(action==='start'||!timer){task=id===GLOBAL?{id,title:'Pomodoro',pomodoroCount:timer?.pomodoroCount||0,pomodoroMinutes:timer?.pomodoroMinutes||0}:await this.loadTask(id);if(!timer)timer=timerFromTask(task,now)}
  if(action==='open'){const mode=body.mode==='break'?'break':'work',duration=canonicalDuration(body.plannedDuration||body.duration||timer.duration,mode);const next=timer.running?timer:{...timer,mode,duration,plannedDuration:duration,status:'ready',remainingSeconds:duration*60};return this.answer(this.store.put({...next,openedAt:now,windowHidden:false,browserSessions:true}))}
  if(['finish','break-finish','cancel'].includes(action)){if(!timer.running)return this.answer(timer,{duplicate:true});return this.answer(await this.finish(timer,{cancelled:action==='cancel',natural:action==='finish'&&(body.natural===true||Number(timer.endsAt)<=now)}))}
  if(task?.completed)throw fail('Tamamlanmış tapşırıqda seans başlatmaq olmaz');if(this.store.sessions.length>=100000)throw fail('Seans arxivi limitinə çatıb',507);
  const mode=body.mode==='break'?'break':'work',duration=canonicalDuration(body.plannedDuration||body.duration,mode),iso=new Date(now).toISOString(),properties={'Отчет запущен':{checkbox:true},'Начало отчета':{date:{start:iso}},'Конец отчета':{date:null},'Pomodoro режим':{select:{name:mode==='break'?'Короткий перерыв — 5 мин':'Работа — 25 мин'}},'Pomodoro текущая длительность':{number:duration}};
  // Journal the absolute PATCH before the network call; retries cannot create another session.
  const actor=body.__account,next={...timer,id,title:task.title||timer.title,mode,duration,plannedDuration:duration,browserSessions:true,running:true,status:'running',startedAt:iso,endsAt:now+duration*60000,remainingSeconds:duration*60,sessionId:crypto.randomUUID(),startOperation:body.operationId,actorId:actor?.id||'unidentified',worker:actor?.name||'İstifadəçi',openedAt:now,windowHidden:false,completedAt:null,completionReason:null,pomodoroCount:Math.max(Number(task.pomodoroCount)||0,Number(timer.pomodoroCount)||0),pomodoroMinutes:Math.max(Number(task.pomodoroMinutes)||0,Number(timer.pomodoroMinutes)||0),syncPending:id!==GLOBAL};const job=id===GLOBAL?null:{taskId:id,sessionId:'',properties,retryAt:0,attempts:0};this.store.commit(next,null,job);this.changed();if(job)await this.flushJob(job);return this.answer(this.store.get(id));
 }
}
module.exports={PomodoroSessions,GLOBAL};
