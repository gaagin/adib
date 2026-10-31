// Server domain module. Dependencies are live bindings supplied by server.js.
'use strict';
module.exports = function serverPomodoro(context) {
async function loadNotionPomodoroSessions(){
 if(Date.now()-context.notionPomodoroSessionsAt<60000)return context.notionPomodoroSessionsCache;
 if(!context.notionPomodoroSessionsPromise)context.notionPomodoroSessionsPromise=context.timerSessionLog.listPomodoro().then(rows=>{context.notionPomodoroSessionsCache=rows;context.notionPomodoroSessionsAt=Date.now();return rows;}).catch(error=>{console.warn('Pomodoro journal read deferred:',error.message);context.notionPomodoroSessionsAt=Date.now();return context.notionPomodoroSessionsCache;}).finally(()=>{context.notionPomodoroSessionsPromise=null});
 return context.notionPomodoroSessionsPromise;
}

async function sharedPomodoroSnapshot(){
  if(Date.now()-context.pomodoroRefreshAt>(context.TOKEN==='native'?30000:Math.max(300000,Number(process.env.ADIB_POMODORO_DISCOVERY_MS)||300000))){
    if(!context.pomodoroRefreshPromise){const requestedAt=Date.now();context.pomodoroRefreshPromise=context.queryDatabase(context.TASKS_DB,context.TASKS_DS,{filter:{property:'Отчет запущен',checkbox:{equals:true}}}).then(pages=>{const found=new Set();for(const page of pages){const timer=context.timerFromTask(context.mapPersonalTask(page));found.add(timer.id);const current=context.sharedPomodoro.get(timer.id);if(current&&current.revision>=requestedAt)continue;if(current&&!current.discovered&&(current.startedAt===timer.startedAt||Date.parse(timer.startedAt)<=Date.parse(current.startedAt||'1970-01-01')))continue;if(current?.running&&current.startedAt===timer.startedAt)continue;if(!current||current.sessionId!==timer.sessionId||!current.running)context.sharedPomodoro.put({...timer,discovered:true,openedAt:current?.openedAt||0})}for(const current of [...context.sharedPomodoro.timers.values()])if(current.discovered&&current.running&&!found.has(current.id)&&current.revision<requestedAt)context.sharedPomodoro.put({...current,running:false,status:'stopped',endsAt:0,remainingSeconds:0});context.pomodoroRefreshAt=Date.now()}).catch(error=>{console.warn("Pomodoro discovery temporarily unavailable:",error.message);context.pomodoroRefreshAt=Date.now()}).finally(()=>{context.pomodoroRefreshPromise=null})}
    await context.pomodoroRefreshPromise;
  }
  const snapshot=context.sharedPomodoro.snapshot();
  const durableSessions=await loadNotionPomodoroSessions();
  const sessionsById=new Map((snapshot.sessions||[]).map(session=>[String(session.id),session]));
  for(const session of durableSessions){const id=String(session.id),local=sessionsById.get(id);sessionsById.set(id,{...local,...session,taskId:session.taskId||local?.taskId||''})}
  return {...snapshot,sessions:[...sessionsById.values()]};
}

async function savePersonalPomodoro(body) {
  const id=context.cleanId(String(body.id||'').trim());if(!id)throw new Error('Müəyyən edilməyib ID tapşırıqları Tasks');
  const action=String(body.action||'').trim();
  const request={...body,id,browserSessions:true};
  // Old Android clients do not send an operation ID. Give those requests an
  // idempotency key too, and use the same session logger for every client.
  if(action==='start'&&!request.operationId)request.operationId=context.crypto.randomUUID();
  const lockId='all-timers';const previous=context.personalPomodoroLocks.get(lockId)||Promise.resolve();let release;const current=new Promise(resolve=>{release=resolve});context.personalPomodoroLocks.set(lockId,current);await previous;
  try{if(['start','open'].includes(action))await sharedPomodoroSnapshot();return await context.browserPomodoroSessions.handle({...request,__account:body.__account});}finally{release();if(context.personalPomodoroLocks.get(lockId)===current)context.personalPomodoroLocks.delete(lockId)}
}

async function savePersonalPomodoroUnlocked(body){
 const id=context.cleanId(String(body.id||'').trim()),action=String(body.action||'').trim();
 if(!['open','hide','start','pause','finish','break-finish','reset'].includes(action))throw new Error('Naməlum əməliyyat Pomodoro');
 const global=id==='00000000-0000-4000-8000-000000000001',existing=context.sharedPomodoro.get(id),now=Date.now(),page=global?null:await context.notion('/pages/'+encodeURIComponent(id),{method:'GET'}),task=global?{id,title:'Pomodoro',pomodoroRunning:existing?.running||false,pomodoroStartedAt:existing?.startedAt||'',pomodoroCount:existing?.pomodoroCount||0,pomodoroMinutes:existing?.pomodoroMinutes||0}:context.mapPersonalTask(page);
 let timer=existing||context.timerFromTask(task,now);
 const answer=(timer,extra={})=>({ok:true,id,action,...extra,timer,serverNow:Date.now(),pomodoroCount:timer.pomodoroCount,pomodoroMinutes:timer.pomodoroMinutes,startedAt:timer.startedAt||'',savedAt:new Date().toISOString()});
 if(body.sessionId&&timer.sessionId&&body.sessionId!==timer.sessionId&&action!=='open')return answer(timer,{duplicate:true,stale:true});
 if(action==='hide'&&Object.prototype.hasOwnProperty.call(body,'expectedVisibilityId')&&body.expectedVisibilityId!==(timer.windowVisibilityId||''))return answer(timer,{duplicate:true,stale:true});
 if(action==='open'||action==='start'){
  await sharedPomodoroSnapshot();
  const others=[...context.sharedPomodoro.timers.values()].filter(t=>t.running&&t.id!==id);
  if(others.length){
   const confirmationToken=context.crypto.createHash('sha256').update(JSON.stringify(others.map(t=>[t.id,t.sessionId,t.revision]).sort((a,b)=>a[0].localeCompare(b[0])))).digest('hex');
   if(body.__account&&body.__account.role!=='admin')for(const other of others)await context.accountTask(body.__account,other.id);
   if(body.confirmationToken!==confirmationToken){const error=context.requestError('Pomodoro artıq işləyir. Onu dayandırıb yenisini açmaq?',409);error.code='POMODORO_ACTIVE';error.confirmationToken=confirmationToken;throw error;}
   for(const other of others){if(other.id!=='00000000-0000-4000-8000-000000000001')await context.notion('/pages/'+encodeURIComponent(other.id),{method:'PATCH',body:JSON.stringify({properties:{'Отчет запущен':{checkbox:false}}})});context.sharedPomodoro.put({...other,discovered:false,running:false,status:'paused',endsAt:0,remainingSeconds:Math.max(0,Math.ceil((other.endsAt-Date.now())/1000)),pausedBy:id});}
   if(typeof context.realtime!=='undefined')context.realtime.invalidate(['pomodoro','personal','equipment']);
  }
 }
 if(action==='hide'){timer=context.sharedPomodoro.put({...timer,windowHidden:true,windowVisibilityId:'hide:'+now+':'+timer.revision});return answer(timer)}
 if(action==='open'){if(!timer.running&&timer.status!=='paused'){const openMode=body.mode==='break'?'break':'work',openDuration=Math.max(1,Math.min(openMode==='break'?60:180,Math.round(Number(body.duration))||timer.duration||25));timer={...timer,mode:openMode,duration:openDuration,plannedDuration:openDuration,remainingSeconds:openDuration*60};}timer=context.sharedPomodoro.put({...timer,discovered:false,openedAt:now,windowHidden:false,windowVisibilityId:'open:'+now+':'+timer.revision,status:timer.running?'running':timer.status==='paused'?'paused':'ready',remainingSeconds:timer.remainingSeconds||timer.duration*60});return answer(timer)}
 if(action==='start'&&task.pomodoroRunning&&task.pomodoroStartedAt&&(!existing||existing.running)){if(!existing||!existing.running)timer=context.timerFromTask(task,now);timer=context.sharedPomodoro.put({...timer,discovered:false,windowHidden:false,openedAt:now,windowVisibilityId:'start:'+now+':'+timer.revision});return answer(timer,{duplicate:true})}
 if((action==='finish'||action==='break-finish')&&!timer.running&&timer.status!=='paused')return answer(timer,{duplicate:true});
 if(action==='pause'&&!timer.running)return answer(timer,{duplicate:true});
 const mode=body.mode==='break'?'break':'work',duration=Math.max(1,Math.min(mode==='break'?60:180,Math.round(timer.status==='paused'&&timer.mode===mode?timer.plannedDuration||timer.duration:Number(body.plannedDuration||body.duration))||(mode==='break'?5:25))),iso=new Date(now).toISOString(),properties={};
 if(action==='start'){
  const requested=Number(body.remainingSeconds),remaining=Number.isFinite(requested)&&requested>0?Math.min(duration*60,Math.ceil(requested)):timer.status==='paused'&&timer.mode===mode?timer.remainingSeconds:duration*60;
  const effectiveStart=new Date(now-(duration*60-remaining)*1000).toISOString();
  properties['Отчет запущен']={checkbox:true};properties['Начало отчета']={date:{start:effectiveStart}};properties['Конец отчета']={date:null};properties['Pomodoro режим']={select:{name:context.pomodoroModeName(mode,duration)}};properties['Pomodoro текущая длительность']={number:duration};
  timer={...timer,mode,duration,plannedDuration:duration,running:true,status:'running',windowHidden:false,windowVisibilityId:'start:'+now+':'+timer.revision,startedAt:effectiveStart,endsAt:now+remaining*1000,remainingSeconds:remaining,sessionId:timer.status==='paused'&&timer.mode===mode&&timer.sessionId?timer.sessionId:id+':'+effectiveStart,completedAt:null,completionReason:null,creditedMinutes:null};
 }else if(action==='pause'){
  const remaining=timer.running?Math.max(0,Math.ceil((timer.endsAt-now)/1000)):Math.max(0,Math.min(duration*60,Number(body.remainingSeconds)||timer.remainingSeconds||duration*60));
  properties['Отчет запущен']={checkbox:false};timer={...timer,running:false,status:'paused',endsAt:0,remainingSeconds:remaining};
 }else if(action==='finish'||action==='break-finish'){
  const fullMinutes=Math.max(1,Math.round(Number(timer.plannedDuration||timer.duration)||duration)),left=timer.running?Math.max(0,Math.ceil((timer.endsAt-now)/1000)):Math.max(0,Number(timer.remainingSeconds)||0),workedSeconds=Math.max(0,Math.min(fullMinutes*60,fullMinutes*60-left)),early=body.early===true&&left>0,credited=early?Math.round(workedSeconds/60):fullMinutes;properties['Отчет запущен']={checkbox:false};properties['Конец отчета']={date:{start:iso}};
  if(action==='finish'){const totalPomodoroMinutes=Math.round(Number(task.pomodoroMinutes)||0)+credited,adjustedEstimate=Math.ceil(totalPomodoroMinutes);properties['Pomodoro количество']={number:task.pomodoroCount+1};properties['Pomodoro всего минут']={number:totalPomodoroMinutes};if(!global&&mode!=='break'&&credited>0&&Number.isInteger(Number(task.estimateMinutes))&&Number(task.estimateMinutes)>0&&context.taskEstimateModule.validMinutes(adjustedEstimate)&&adjustedEstimate>Number(task.estimateMinutes))properties[context.taskEstimateModule.FIELD]={number:adjustedEstimate}}
  timer={...timer,running:false,status:'completed',endsAt:0,remainingSeconds:0,completedAt:iso,completionReason:early?'early':'elapsed',creditedMinutes:action==='finish'?credited:0,pomodoroCount:action==='finish'?task.pomodoroCount+1:task.pomodoroCount,pomodoroMinutes:action==='finish'?Math.round(Number(task.pomodoroMinutes)||0)+credited:task.pomodoroMinutes};
 }else{
  properties['Отчет запущен']={checkbox:false};properties['Начало отчета']={date:null};properties['Конец отчета']={date:null};properties['Pomodoro текущая длительность']={number:null};timer={...timer,running:false,status:'stopped',endsAt:0,remainingSeconds:0,completedAt:null,completionReason:'reset',creditedMinutes:null};
 }
 const startedAtMs=Date.parse(timer.startedAt),endedAtMs=Date.parse(iso),plannedMinutes=Math.max(1,Math.round(Number(timer.plannedDuration||timer.duration)||duration)),actualSeconds=Number.isFinite(startedAtMs)?Math.max(0,Math.min(plannedMinutes*60,(endedAtMs-startedAtMs)/1000)):0,finishedEarly=body.early===true;
 const completedSession=action==='finish'&&!global&&mode!=='break'?{id:timer.sessionId||id+':'+(timer.startedAt||iso),taskId:id,title:task.title||timer.title||'Pomodoro',sourceKey:'personal',kind:'pomodoro',mode:'work',actorId:body.__account?.id||'unidentified',worker:body.__account?.name||timer.worker||'İstifadəçi',status:'saved',startedAt:Number.isFinite(startedAtMs)?startedAtMs:endedAtMs-actualSeconds*1000,endedAt:endedAtMs,seconds:actualSeconds,plannedMinutes,fullPomodoro:!finishedEarly,completionReason:finishedEarly?'early':'elapsed',startOperation:body.operationId||'',notionLogEligible:true,notionSyncPending:true}:null;
 if(!global)await context.notion('/pages/'+encodeURIComponent(id),{method:'PATCH',body:JSON.stringify({properties})});if(context.taskEstimateModule.validMinutes(properties[context.taskEstimateModule.FIELD]?.number)){context.taskManagement.update({type:'estimate',id,minutes:properties[context.taskEstimateModule.FIELD].number});context.snapshotCache=null;context.taskCache.clear();}context.invalidatePersonalTasks();
 const savedTimer={...timer,discovered:false};
 if(completedSession){timer=context.sharedPomodoro.commit(savedTimer,completedSession,null);await context.browserPomodoroSessions.flushSessionLog(completedSession);timer=context.sharedPomodoro.get(id);}
 else timer=context.sharedPomodoro.put(savedTimer);
 return answer(timer);
}
return { loadNotionPomodoroSessions, sharedPomodoroSnapshot, savePersonalPomodoro, savePersonalPomodoroUnlocked };
};
