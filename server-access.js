// Server domain module. Dependencies are live bindings supplied by server.js.
'use strict';
module.exports = function serverAccess(context) {
async function aiChat(body) {
  const message=String(body?.message||'').trim();
  if(!message) throw context.requestError('üçün mesaj daxil edin Gemini', 400);
  if(message.length > 4000) throw context.requestError('Mesaj çox uzundur (maksimum 4000 simvol)', 413);
  if(!context.GEMINI_API_KEY){const error=new Error('Gemini konfiqurasiya edilməyib. əlavə et GEMINI_API_KEY və GEMINI_MODEL üçün .env serverdə.');error.statusCode=503;throw error}
  const serviceContext=body?.context&&typeof body.context==='object'?body.context:{};
  const safeContext=JSON.stringify(serviceContext).slice(0,12000);
  const system='Siz AI-xidmət köməkçisi ADIB tapşırıqların və avadanlıqların saxlanması üçün. İstifadəçinin dilində qısa və praktiki şəkildə cavab verin. Verilmiş konteksti təhlil edin, lakin məlumatları təşkil etməyin. Bu versiyada siz yalnız məsləhət görürsünüz: tapşırığı və ya verilənlər bazasını dəyişdirdiyinizi iddia etməyin.';
  const models=[...new Set([context.GEMINI_MODEL,context.GEMINI_MODEL_FALLBACK])];let data=null,usedModel=context.GEMINI_MODEL,lastStatus=0,lastError='';
  for(const model of models){
    const endpoint=context.GEMINI_API_URL+'/models/'+encodeURIComponent(model)+':generateContent?key='+encodeURIComponent(context.GEMINI_API_KEY);
    let response;
    const controller=new AbortController();
    const timeout=setTimeout(()=>controller.abort(),context.GEMINI_TIMEOUT_MS);
    try {
      response=await fetch(endpoint,{method:'POST',headers:{'Content-Type':'application/json'},signal:controller.signal,body:JSON.stringify({systemInstruction:{parts:[{text:system}]},contents:[{role:'user',parts:[{text:message+'\n\nXidmət konteksti:\n'+safeContext}]}],generationConfig:{temperature:0.2,maxOutputTokens:1000}})});
    } catch(error) {
      if(error.name==='AbortError') throw context.requestError('Gemini vaxtında cavab vermədi. Yenidən cəhd edin.',504);
      throw error;
    } finally { clearTimeout(timeout); }
    const text=await response.text();try{data=JSON.parse(text)}catch{data={error:{message:text}}}
    if(response.ok){usedModel=model;break}
    lastStatus=response.status;lastError=data.error?.message||data.message||text;
    if(response.status!==404||model===models.at(-1))throw new Error('Gemini API '+response.status+': '+lastError);
  }
  const reply=(data?.candidates?.[0]?.content?.parts||[]).map(part=>part.text||'').join('').trim();
  if(!reply)throw new Error('Gemini cavab vermədi'+(lastStatus?' ('+lastStatus+')':''));
  return {reply,model:usedModel,provider:'gemini'};
}

async function notionUsers(force = false) {
  if (!force && context.userCache.value && Date.now() - context.userCache.at < 300000) return context.userCache.value;
  const users = [];
  let cursor = '';
  do {
    const suffix = cursor ? '&start_cursor=' + encodeURIComponent(cursor) : '';
    const page = await context.notion('/users?page_size=100' + suffix, { method: 'GET' });
    users.push(...(page.results || []));
    cursor = page.has_more ? page.next_cursor : '';
  } while (cursor);
  context.userCache.value = users.filter(user => user.type === 'person').map(user => ({ id: user.id, name: user.name || user.person?.email || 'Adsız', email: user.person?.email || '' }));
  context.userCache.at = Date.now();
  return context.userCache.value;
}

function observeWrittenPage(endpoint,page){
 if(!page?.id||page.object!=='page'||!page.properties)return;
 const parent=page.parent||{},parentId=parent.data_source_id||parent.database_id||'';
 if(page.archived||page.in_trash)context.realtimeTombstones.set(page.id,Date.now()+10*60*1000);else context.realtimeTombstones.delete(page.id);
 let targets=[];
 if(context.personalRaw.tasks.has(page.id)||[context.TASKS_DS,context.TASKS_DB].includes(parentId))targets.push(context.personalRaw.tasks);
 if(context.personalRaw.containers.has(page.id)||[context.PERSONAL_CONTAINERS_DS,context.PERSONAL_CONTAINERS_DB].includes(parentId))targets.push(context.personalRaw.containers);
 if(context.rawCache.plans.has(page.id)||[context.PLAN_DS,context.PLAN_DB].filter(Boolean).includes(parentId))targets.push(context.rawCache.plans);
 if(context.rawCache.machines.has(page.id)||[context.MAKINA_DS,context.MAKINA_DB].filter(Boolean).includes(parentId))targets.push(context.rawCache.machines);
 for(const source of context.taskSources())if(context.rawCache.tasks.get(source.key)?.has(page.id)||[source.dataSourceId,source.databaseId].filter(Boolean).includes(parentId)){if(!context.rawCache.tasks.has(source.key))context.rawCache.tasks.set(source.key,new Map());targets.push(context.rawCache.tasks.get(source.key));}
 for(const target of targets)context.mergePages(target,[page]);
 if(targets.length){context.snapshotCache=null;context.personalTasksCache=null;context.taskCache.clear();context.saveRawSnapshotCache();}
}

function mutationScopes(method,p){
 if(!['POST','PATCH','DELETE'].includes(method))return [];
 if(p==='/api/task-management')return ['management','personal','equipment'];
 if(p==='/api/personal-pomodoro')return ['personal','equipment','pomodoro'];
 if(['/api/personal-task','/api/personal-container','/api/personal-layout','/api/personal-task-blocks'].includes(p))return ['personal'];
 if(['/api/task','/api/plan','/api/equipment','/api/layout','/api/layout-color'].includes(p))return ['equipment'];
 return [];
}

function realtimePersonal(){const all=[...context.personalRaw.tasks.values()].filter(p=>!p.archived&&!p.in_trash).map(context.mapPersonalTask),containers=[...context.personalRaw.containers.values()].filter(p=>!p.archived&&!p.in_trash).map(context.mapPersonalContainer);context.applyPersonalContainerDefaults(all,containers);return context.withTaskEstimates({tasks:all.filter(context.recentTask),containers,pomodoroTasks:all,database:context.TASKS_DB,containersDatabase:context.PERSONAL_CONTAINERS_DB});}

function managementSnapshotWithTaskEstimates(){const data=context.taskManagement.snapshot();for(const page of context.personalRaw.tasks.values()){if(page.archived||page.in_trash||!Object.prototype.hasOwnProperty.call(page.properties||{},context.taskEstimateModule.FIELD))continue;const value=context.taskEstimates.read(page);if(value===null){if(data.tasks[page.id]){data.tasks[page.id]={...data.tasks[page.id]};delete data.tasks[page.id].estimateMinutes;}}else data.tasks[page.id]={...data.tasks[page.id],estimateMinutes:value};}return data;}

function accountTasks(){const data=context.buildSnapshotFromRawCache(),machines=new Map(data.equipment.map(e=>[context.accountKey(e.id),e.planId]));return {personal:realtimePersonal().pomodoroTasks||[],equipment:(data.pomodoroTasks||[]).map(t=>({...t,planId:t.planId||machines.get(context.accountKey(t.machineId))||''}))};}

function allowedAccountIds(u){const t=accountTasks();return new Set([...t.personal.filter(t=>context.accounts.task(u,t,'personal')),...t.equipment.filter(t=>context.accounts.task(u,t,'equipment'))].map(t=>context.accountKey(t.id)));}

function projectAccount(u,scope,d){
 if(u.role==='admin')return d;
 if(scope==='options'){const tasks=accountTasks(),result={};for(const k of ['personal','todo','gorulen']){if(!d[k])continue;const list=k==='personal'?tasks.personal.filter(t=>context.accounts.task(u,t,'personal')):tasks.equipment.filter(t=>t.sourceKey===k&&context.accounts.task(u,t,'equipment'));result[k]={};for(const field of Object.keys(d[k])){const values=[...new Set(list.flatMap(t=>t[field]||[]))];result[k][field]={type:d[k][field].type,options:values};}}return result;}
 if(scope==='users')return {users:(d.users||[]).filter(x=>[u.rules.assignee,u.name].includes(x.id)||[u.rules.assignee,u.name].includes(x.name)).map(({id,name})=>({id,name}))};
 if(scope==='realtime'){return {...d,kind:'full',data:projectAccount(u,d.scope,d.data),baseRevision:undefined};}
 if(scope==='personal'||scope==='equipment')return context.accounts.filter(u,scope,d);
 const ids=allowedAccountIds(u);
 if(scope==='pomodoro'){const result={...d,sessions:(d.sessions||[]).filter(s=>ids.has(context.accountKey(s.taskId))),timers:(d.timers||[]).filter(t=>t.id!=='__global__'&&ids.has(context.accountKey(t.id)))};if(d.timer&&!ids.has(context.accountKey(d.timer.id)))delete result.timer;return result;}
 if(scope==='management'){const v=structuredClone(d);v.tasks=Object.fromEntries(Object.entries(v.tasks||{}).filter(([id])=>ids.has(context.accountKey(id))));for(const t of Object.values(v.tasks))if(t.parentId&&!ids.has(context.accountKey(t.parentId)))t.parentId='';for(const day of Object.values(v.days||{})){day.ids=(day.ids||[]).filter(id=>ids.has(context.accountKey(id)));if(!ids.has(context.accountKey(day.mainId)))day.mainId='';}return v;}
 return d;
}

async function accountTask(u,id,kind){
 let found;const find=()=>{const tasks=accountTasks();for(const k of kind?[kind]:['personal','equipment']){const t=tasks[k].find(t=>context.accountKey(t.id)===context.accountKey(id));if(t){found={task:t,kind:k};return;}}};find();
 if(!found){if(!kind||kind==='personal')await context.personalSnapshot(false);if(!found&&(!kind||kind==='equipment'))await context.snapshot(false);find();}
 if(!found||!context.accounts.task(u,found.task,found.kind))throw context.accessError('Tapşırıq mövcud deyil');return found;
}

async function accountAuthorize(req,res,url,u,b){
 res.__account=u;res.__accountRequest=req;const p=url.pathname,method=req.method;if(u.role==='admin')return;
 const deny=()=>{throw context.accessError('Bu bölmə və ya fəaliyyətə daxil olmaq mümkün deyil');};const need=a=>{if(!context.accounts.action(u,a))deny();};
 if(p==='/api/user/preferences'){if(!['GET','PUT'].includes(method))deny();res.__accountScope='preferences';return;}
 const scopes={ '/api/personal-snapshot':'personal','/api/plan-snapshot':'equipment','/api/pomodoro-state':'pomodoro','/api/personal-pomodoro':'pomodoro','/api/task-management':'management'};
 if(scopes[p])res.__accountScope=scopes[p];
 if(['/api/time','/api/health','/api/realtime/status'].includes(p))return;
 if(p==='/api/events'){const requested=(url.searchParams.get('scopes')||'personal,equipment,management,pomodoro').split(',');const allowed=requested.filter(s=>s!=='equipment'||context.accounts.section(u,'equipment'));url.searchParams.set('scopes',allowed.join(','));context.accounts.track(req,res,u);return;}
 if(p==='/api/realtime/state'){const scope=url.searchParams.get('scope')||'personal';if(scope==='equipment'&&!context.accounts.section(u,'equipment'))deny();res.__accountScope='realtime';url.searchParams.delete('revision');url.searchParams.delete('epoch');return;}
 if(p==='/api/personal-snapshot')return;
 if(p==='/api/plan-snapshot'){if(!context.accounts.section(u,'equipment'))deny();return;}
 if(p==='/api/team-snapshot'){if(method!=='GET'||!context.accounts.section(u,'team'))deny();return;}
 if(p==='/api/calendar-capabilities'){if(!context.accounts.section(u,'calendar'))deny();return;}
 if(p==='/api/task-options'){if(!['personal','calendar','day','matrix','equipment'].some(s=>context.accounts.section(u,s)))deny();res.__accountScope='options';return;}
 if(p==='/api/users'){res.__accountScope='users';return;}
 if(p==='/api/pomodoro-state')return;
 if(p==='/api/task-management'){if(method==='GET')return;if(!['parent','estimate','day-add','day-remove','main','review','completion','finish'].includes(b.type))deny();need(['completion','finish'].includes(b.type)?'status':'edit');await accountTask(u,b.id);if(b.parentId)await accountTask(u,b.parentId);return;}
 if(['/api/chat-threads','/api/comment-notifications'].includes(p)){if(!context.accounts.section(u,'chat'))deny();const ids=p==='/api/chat-threads'?(b.tasks||[]).map(t=>t.id):(Array.isArray(b.ids)?b.ids:String(b.ids||'').split(','));if(ids.length>120)throw context.accessError('Həddindən artıq tapşırıq',400);for(const id of ids)await accountTask(u,id);return;}
 if(p==='/api/image-upload'){
  if(b.peerId){
   const peer=context.accounts.state.users.find(v=>v.id===String(b.peerId)&&!v.disabled&&v.id!==u.id&&context.accounts.section(v,'chat'));
   if(!context.accounts.section(u,'chat')||!context.accounts.action(u,'comment')||!peer||!(u.personalPageId||peer.personalPageId))deny();
  }else{need('edit');if(b.id)await accountTask(u,b.id);}
  return;
 }
 if(p==='/api/task-photos'&&method==='GET'){await accountTask(u,url.searchParams.get('id'));return;}
 if(p==='/api/task-photo'){need(b.remove?'delete':'edit');await accountTask(u,b.id);return;}
 if(p==='/api/task-photo-schema')deny();
 if(p==='/api/work-state'){if(!context.accounts.section(u,'equipment')&&!context.accounts.section(u,'calendar'))deny();return;}
 if(p==='/api/work-schema')deny();
 if(p==='/api/work-timer'){need('timer');const id=b.action==='start'?b.id:context.workTimer.data.sessions.find(s=>s.id===b.sessionId)?.taskId;if(!id)deny();req.__workTarget=await workAccountTask(u,id);return;}
 const reads=['/api/task-comments','/api/task-images','/api/personal-task-content','/api/personal-task-blocks'];
 if(reads.includes(p)&&method==='GET'){if(p==='/api/task-comments'&&!context.accounts.section(u,'chat'))deny();await accountTask(u,url.searchParams.get('id'));return;}
 if(p==='/api/task-comments'&&method==='POST'){if(!context.accounts.section(u,'chat'))deny();need('comment');await accountTask(u,b.id);return;}
 if(p==='/api/task-image'){need(b.remove?'delete':'edit');await accountTask(u,b.id);return;}
 if(p==='/api/personal-task-blocks'){need('edit');await accountTask(u,b.id);return;}
 if(p==='/api/personal-pomodoro'){need('timer');await accountTask(u,b.id);return;}
 if(['/api/personal-task','/api/task'].includes(p)){
 const kind=p==='/api/personal-task'?'personal':'equipment';
 if(method==='POST'){need('create');if(kind==='personal'){if(u.rules.containers!=='*'&&!u.rules.containers.includes(context.accountKey(b.containerId)))deny();if(u.rules.assignedOnly&&!(b.assignees||[]).includes(u.rules.assignee))deny();}else{if(!context.accounts.section(u,'equipment'))deny();let equipment=context.buildSnapshotFromRawCache().equipment;if(b.machineId&&!equipment.some(e=>context.accountKey(e.id)===context.accountKey(b.machineId))){const refreshed=await context.snapshot(true);equipment=refreshed.equipment||equipment;}const target=context.resolveEquipmentTaskPlan({machineId:b.machineId,planId:b.planId,allowedPlans:u.rules.plans},equipment);if(!target.ok)deny();b.planId=target.planId;if(u.rules.assignedOnly&&![b.assigneeId,b.assigneeName,...(b.tapsirildi||[])].includes(u.rules.assignee))deny();}if(b.parentId)await accountTask(u,b.parentId,kind);return;}
 const found=await accountTask(u,method==='DELETE'?url.searchParams.get('id'):b.id,kind),t=found.task;
 if(method==='DELETE'){need('delete');if((accountTasks()[kind]||[]).some(x=>context.accountKey(x.parentId)===context.accountKey(t.id)))deny();return;}
 if(method!=='PATCH')deny();
 if(!context.accounts.action(u,'edit')){need('status');const safe=['id','status','completed','process','sourceKey','autosaveBase','autosaveOperationId','overrideWip'];for(const k of Object.keys(b))if(!safe.includes(k)&&JSON.stringify(b[k])!==JSON.stringify(t[k]))deny();}
 if(kind==='equipment'){if(b.sourceKey&&b.sourceKey!==t.sourceKey)deny();if(b.machineId&&!(t.machineIds||[t.machineId]).some(id=>context.accountKey(id)===context.accountKey(b.machineId)))deny();if(b.planId&&context.accountKey(b.planId)!==context.accountKey(t.planId))deny();}
 const changed={...t,...b};if(!context.accounts.task(u,changed,kind))deny();if(b.parentId)await accountTask(u,b.parentId,kind);return;
 }
 deny(); // New endpoints are denied until explicitly reviewed.
}

async function syncTaskSessionTitle(taskId,sourceKey,title){
 const result={workTimer:0,pomodoro:0,notion:0};
 try{result.workTimer=context.workTimer.renameTask(taskId,title)}catch(error){console.warn('Work timer session title update failed:',taskId,error.message)}
 try{result.pomodoro=context.sharedPomodoro.renameTask(taskId,title);if(result.pomodoro)context.realtime.invalidate(['pomodoro','personal'])}catch(error){console.warn('Pomodoro session title update failed:',taskId,error.message)}
 try{const updated=await context.timerSessionLog.renameTask(taskId,sourceKey,title);result.notion=updated.updated||0}catch(error){result.notionError=String(error.message||error).slice(0,300);console.warn('Notion session title update failed:',taskId,error.message)}
 return result;
}

function workActor(request){if(context.accounts.enabled){const u=context.accounts.user(request);return {...u,assignee:u.rules?.assignee||u.name};}return {id:'owner',name:process.env.ADIB_ADMIN_NAME||'Ilqar Mamedov',role:'admin',assignee:process.env.ADIB_ADMIN_NAME||'Ilqar Mamedov'};}

async function workClock(){if(Number.isFinite(context.networkTime.snapshot().now)){void context.networkTime.sync().catch(()=>{});return;}await context.networkTime.sync();if(!Number.isFinite(context.networkTime.snapshot().now))throw Object.assign(Error("Şəbəkə vaxtı təsdiqlənməyib"),{statusCode:503,code:"WORK_CLOCK_UNAVAILABLE"});}

async function workAccountTask(u,id){const cached=accountTasks().equipment.find(t=>context.accountKey(t.id)===context.accountKey(id));if(cached){if(!context.accounts.task(u,cached,'equipment'))throw context.accessError('Tapşırıq mövcud deyil');return {task:cached};}const prepared=await context.workTimer.page(id),spec=context.taskSources().find(s=>s.key===prepared.source.key);const task=[...context.buildTaskMap([{source:spec,pages:[prepared.p]}],[], '',true).values()].flat()[0];if(!task)throw context.accessError('Tapşırıq mövcud deyil');if(!task.planId&&task.machineId){const machine=context.buildSnapshotFromRawCache().equipment.find(m=>context.accountKey(m.id)===context.accountKey(task.machineId));task.planId=machine?.planId||'';if(!task.planId&&u.role!=='admin'&&u.rules.plans!=='*'){const page=await context.notion('/pages/'+task.machineId,{method:'GET'});if(page.archived||page.in_trash)throw context.accessError('Tapşırıq mövcud deyil');task.planId=context.relationIds(page,'Plan')[0]||'';}}if(!context.accounts.task(u,task,'equipment'))throw context.accessError('Tapşırıq mövcud deyil');return {task,prepared};}

function workTasks(actor){return accountTasks().equipment.filter(t=>actor.role==='admin'||context.accounts.task(actor,t,'equipment'));}

async function teamSnapshot(request){
 const baseUrl=context.appBaseUrl(request);
 const [personalData,equipmentData]=await Promise.all([
  context.personalSnapshot(false,false,false),
  context.snapshot(false,baseUrl,false)
 ]);
 const personalRows=context.withTaskEstimates(personalData).tasks||[];
 const equipmentRows=context.withTaskEstimates(equipmentData).pomodoroTasks||[];
 const machines=new Map((equipmentData.equipment||[]).map(item=>[context.accountKey(item.id),item]));
 let tasks=[
  ...personalRows.map(task=>({...task,kind:'personal',source:'Tapşırıqlarım'})),
  ...equipmentRows.map(task=>({...task,kind:'equipment',machineName:machines.get(context.accountKey(task.machineId))?.name||'',source:task.source||'Avadanlıq'}))
 ];
 const actor=request.__accountBody?.__account;
 if(context.accounts.enabled&&actor?.role!=='admin')tasks=tasks.filter(task=>context.accounts.task(actor,task,task.kind==='equipment'?'equipment':'personal'));
 let directory=[];
 try{directory=await context.personalDirectory();}catch(error){console.warn('Team directory lookup deferred:',error.message);}
 const users=context.accounts.enabled?context.accounts.state.users.filter(user=>!user.disabled):[];
 const sessions=context.workTimer.data.sessions.filter(session=>['running','pending'].includes(session.status)).map(session=>({
  taskId:session.taskId,worker:session.worker,status:session.status,startedAt:session.startedAt
 }));
 return {ok:true,...context.buildTeamDashboard({
  users,directory,tasks,sessions,
  now:context.networkTime.snapshot().now||Date.now(),
  timeZone:process.env.ADIB_TIME_ZONE||'Asia/Baku'
 }),refreshedAt:new Date().toISOString()};
}
return { aiChat, notionUsers, observeWrittenPage, mutationScopes, realtimePersonal, managementSnapshotWithTaskEstimates, accountTasks, allowedAccountIds, projectAccount, accountTask, accountAuthorize, syncTaskSessionTitle, workActor, workClock, workAccountTask, workTasks, teamSnapshot };
};
