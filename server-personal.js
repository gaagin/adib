// Server domain module. Dependencies are live bindings supplied by server.js.
'use strict';
module.exports = function serverPersonal(context) {
function invalidatePersonalTasks(){context.personalTasksGeneration++;context.personalTasksCache=null;}

function snapshotScope(){return [context.PLAN_DS||context.PLAN_DB,context.MAKINA_DS||context.MAKINA_DB,context.TASKS_DS||context.TASKS_DB,context.PERSONAL_CONTAINERS_DS||context.PERSONAL_CONTAINERS_DB,...context.taskSources().map(x=>x.dataSourceId||x.databaseId)].join('|');}

function cacheCall(fn){try{const result=fn();context.cacheHealth.error='';return result;}catch(error){context.cacheHealth.error='Yerli keş saxlanılmadı: '+String(error.message||error);error.code='LOCAL_CACHE_WRITE';throw error;}}

function snapshotMetadata(override=null){const meta={version:2,scope:snapshotScope(),equipment:{cursors:structuredClone(context.rawCache.cursors||{}),lastSyncAt:context.rawCache.lastSyncAt,lastFullSyncAt:context.rawCache.lastFullSyncAt},personal:{cursors:structuredClone(context.personalRaw.cursors)}};if(override){const [scope,key]=override.key.split(':');meta[scope].cursors[key]=override.cursor;}return meta;}

function snapshotCollections(){return new Map([['equipment:plans',context.rawCache.plans],['equipment:machines',context.rawCache.machines],...[...context.rawCache.tasks].map(([key,map])=>['equipment:'+key,map]),['personal:tasks',context.personalRaw.tasks],['personal:containers',context.personalRaw.containers]]);}

function saveRawSnapshotCache(){if(!process.env.SNAPSHOT_RAW_CACHE_FILE)return;try{
 if(context.fs.snapshotSave){cacheCall(()=>context.fs.snapshotSave(snapshotScope(),snapshotMetadata(),Object.fromEntries([...snapshotCollections()].map(([key,map])=>[key,[...map.keys()]]))));return;}
 const value={version:1,scope:snapshotScope(),equipment:{plans:[...context.rawCache.plans.values()],machines:[...context.rawCache.machines.values()],tasks:[...context.rawCache.tasks].map(([key,map])=>[key,[...map.values()]]),cursors:context.rawCache.cursors||{},lastSyncAt:context.rawCache.lastSyncAt,lastFullSyncAt:context.rawCache.lastFullSyncAt},personal:{tasks:[...context.personalRaw.tasks.values()],containers:[...context.personalRaw.containers.values()],cursors:context.personalRaw.cursors}};const file=process.env.SNAPSHOT_RAW_CACHE_FILE;context.fs.writeFileSync(file+'.tmp',JSON.stringify(value));context.fs.renameSync(file+'.tmp',file);context.cacheHealth.error='';
 }catch(error){context.cacheHealth.error='Yerli keş saxlanılmadı: '+String(error.message||error);console.warn('Local raw cache could not be saved:',error.message);}}

function restoreRawSnapshotCache(){if(!process.env.SNAPSHOT_RAW_CACHE_FILE)return;try{
 if(context.fs.snapshotState){const meta=cacheCall(()=>context.fs.snapshotState(snapshotScope()));if(!meta)return;if(meta.version!==2||meta.scope!==snapshotScope())throw new Error('Uyğun olmayan keş SQLite');for(const [key,target] of snapshotCollections()){let after='';do{const batch=cacheCall(()=>context.fs.snapshotRows(snapshotScope(),key,after));context.mergePages(target,batch.pages||[]);if(!batch.hasMore)break;if(!batch.nextId||batch.nextId===after)throw new Error('Yanlış yerli keş səhifəsi');after=batch.nextId;}while(true);}context.rawCache.cursors=meta.equipment.cursors||{};context.rawCache.lastSyncAt=meta.equipment.lastSyncAt||'';context.rawCache.lastFullSyncAt=meta.equipment.lastFullSyncAt||0;context.personalRaw.cursors=meta.personal.cursors||{};context.cacheHealth.restored=true;return;}
 const value=JSON.parse(context.fs.readFileSync(process.env.SNAPSHOT_RAW_CACHE_FILE,'utf8'));if(value.version!==1||value.scope!==snapshotScope())return;const e=value.equipment,p=value.personal;context.rawCache.plans=new Map(e.plans.map(x=>[x.id,x]));context.rawCache.machines=new Map(e.machines.map(x=>[x.id,x]));context.rawCache.tasks=new Map(e.tasks.map(([key,pages])=>[key,new Map(pages.map(x=>[x.id,x]))]));context.rawCache.cursors=e.cursors||{};context.rawCache.lastSyncAt=e.lastSyncAt||'';context.rawCache.lastFullSyncAt=e.lastFullSyncAt||0;context.personalRaw.tasks=new Map(p.tasks.map(x=>[x.id,x]));context.personalRaw.containers=new Map(p.containers.map(x=>[x.id,x]));context.personalRaw.cursors=p.cursors||{};context.cacheHealth.restored=true;
 }catch(error){context.cacheHealth.error='Yerli keşi oxumaq alınmadı: '+String(error.message||error);}}

function checkbox(page, name) { return context.property(page, name)?.checkbox === true; }

function mapPersonalTask(page) {
  const taskContext=context.taskManagement.getContext(page.id);
  const parent = context.relationIds(page, 'Parent item')[0] || '';
  const children = context.relationIds(page, 'Sub-item');
  const status = context.select(page, 'Status') || 'Not started';
  const priority = context.select(page, 'Priority');
  const prioritet = context.select(page, 'Prioritet');
  return context.enrichCompletion({
    id: page.id,
    machineId:taskContext.machineId,
    planId:taskContext.planId,
    title: context.title(page, 'Adi') || 'Adsız',
    status,
    completed: checkbox(page, 'Status 1')||context.taskHistory.done({status}),
    parentId: parent,
    childIds: children,
    containerId: context.relationIds(page, 'Personal Container')[0] || '',
    x: context.number(page, 'Personal X'),
    y: context.number(page, 'Personal Y'),
    width: context.number(page, 'Personal Width'),
    height: context.number(page, 'Personal Height'),
    order: context.number(page, 'Personal Order'),
    priority,
    prioritet,
    urgent: priority === '!!!' || prioritet === '!!!',
    category: context.select(page, 'Kateqoriya'),
    url: page.url || '',
    link: context.property(page, 'Link')?.url || '',
    date: context.dateStart(page, 'Tarix'),
    dateEnd: context.property(page, 'Tarix')?.date?.end || '',
    assignees: context.multiSelect(page, 'Tapsirildi'),
    tags: context.multiSelect(page, 'Tag'),
    pomodoroCount: context.number(page, 'Pomodoro количество') ?? 0,
    pomodoroMinutes: context.number(page, 'Pomodoro всего минут') ?? 0,
    pomodoroRunning: checkbox(page, 'Отчет запущен'),
    pomodoroStartedAt: context.dateStart(page, 'Начало отчета'),
    pomodoroEndedAt: context.dateStart(page, 'Конец отчета'),
    pomodoroMode: context.select(page, 'Pomodoro режим'),
    pomodoroDuration: context.number(page, 'Pomodoro текущая длительность') ?? context.pomodoroModeDuration(context.select(page, 'Pomodoro режим')) ,
    estimateMinutes: context.taskEstimates.read(page),
    updatedAt: page.last_edited_time || ''
  },page);
}

function mapPersonalContainer(page) {
  return {
    id: page.id,
    name: context.title(page, 'Name') || 'Qovluq',
    parentId: context.relationIds(page, 'Parent Container')[0] || null,
    x: context.number(page, 'X') ?? 60,
    y: context.number(page, 'Y') ?? 60,
    width: context.number(page, 'Width') ?? 340,
    height: context.number(page, 'Height') ?? 220,
    order: context.number(page, 'Order') ?? 0,
    color: context.select(page, 'Color') || 'Yellow',
    url: page.url || ''
  };
}

function personalNumber(value, fallback = 0) {
  const n = Number(value);
  return Number.isFinite(n) ? n : fallback;
}

function inboxContainerId(containers) {
 const matches=containers.filter(c=>String(c.name||'').trim().toLowerCase()==='inbox'&&c.id);
 if(matches.length!==1)throw Object.assign(new Error(matches.length?'Bir neçə tapıldı INBOX. Bir konteyner göstərin INBOX.':'Qovluq INBOX mövcud deyil. Məlumatlarınızı yeniləyin və inteqrasiya girişinizi yoxlayın. Tapşırıq yaradılmayıb.'),{code:'INBOX_UNAVAILABLE',statusCode:409});
 return matches[0].id;
}

async function personalInboxId(){
 const cached=[...context.personalRaw.containers.values()].filter(p=>!p.archived&&!p.in_trash).map(mapPersonalContainer);
 if(cached.some(c=>String(c.name||'').trim().toLowerCase()==='inbox'))return inboxContainerId(cached);
 const pages=await context.queryDatabase(context.PERSONAL_CONTAINERS_DB,context.PERSONAL_CONTAINERS_DS);
 const live=pages.filter(p=>!p.archived&&!p.in_trash);for(const page of live)context.personalRaw.containers.set(page.id,page);
 return inboxContainerId(live.map(mapPersonalContainer));
}

async function resolvePersonalTaskContainer(body){
 if(String(body.containerId||'').trim())return context.cleanId(String(body.containerId).trim());
 if(String(body.parentId||'').trim())return '';
 return personalInboxId();
}

function applyPersonalContainerDefaults(tasks,containers){
 let inbox;try{inbox=inboxContainerId(containers)}catch{return tasks}
 for(const task of tasks){if(task.containerId||task.parentId||context.taskManagement.state.tasks[task.id]?.parentId||!context.recentTask(task))continue;task.containerId=inbox;task.containerAssignmentPending=true;schedulePersonalContainerRepair(task.id);}
 return tasks;
}

function schedulePersonalContainerRepair(id){
 if(context.personalContainerRepairs.has(id))return;context.personalContainerRepairs.add(id);
 context.personalContainerRepairQueue=context.personalContainerRepairQueue.then(async()=>{
  // Re-read immediately before writing: never move a newly assigned task or a new subtask.
  const page=await context.notion('/pages/'+encodeURIComponent(id));
  if(page.archived||page.in_trash||context.taskManagement.state.tasks[id]?.parentId)return;
  if(context.relationIds(page,'Personal Container').length||context.relationIds(page,'Parent item').length){context.personalRaw.tasks.set(id,page);context.personalTasksCache=null;return;}
  const containerId=await personalInboxId();
  const patched=await context.notion('/pages/'+encodeURIComponent(id),{method:'PATCH',body:JSON.stringify({properties:{'Personal Container':{relation:[{id:containerId}]}}})});
  context.personalRaw.tasks.set(id,patched);context.personalTasksCache=null;context.personalTasksCacheAt=0;saveRawSnapshotCache();
 }).catch(()=>{/* Keep pending presentation in INBOX; retry after the next refresh. */}).finally(()=>context.personalContainerRepairs.delete(id));
}

function personalSnapshot(force=false,fresh=false,retry=false,light=false){return context.queryPolicy.run('personal',{refresh:force||fresh||retry,cached:()=>context.personalTasksCache,load:()=>personalSnapshotUnbounded(force,fresh,retry,light)});}

async function personalSnapshotUnbounded(force=false,fresh=false,retry=false,light=false){
 if(!force&&!fresh&&context.personalTasksCache&&Date.now()-context.personalTasksCacheAt<5000)return context.personalTasksCache;
 if(context.personalTasksInFlight){if(context.personalTasksInFlightGeneration===context.personalTasksGeneration)return context.personalTasksInFlight;await context.personalTasksInFlight.catch(()=>{});return personalSnapshotUnbounded(force,fresh,retry,light);}
 const generation=context.personalTasksGeneration;context.personalTasksInFlightGeneration=generation;
 context.personalTasksInFlight=(async()=>{
  const specs=context.personalSnapshotSpecs(),failed=specs.filter(x=>context.personalRaw.cursors[x.key]?.error),selected=retry&&failed.length?failed:specs;
  const progress=context.beginSnapshotProgress('personal',selected,force);
  const results=await Promise.allSettled(selected.map(spec=>context.streamSnapshotPart(progress,spec,context.personalRaw[spec.key],context.personalRaw.cursors,force,light,()=>generation===context.personalTasksGeneration)));
  progress.running=false;progress.revision=++context.snapshotProgressRevision;
  if(generation!==context.personalTasksGeneration)return null;
  const errors=results.filter(x=>x.status==='rejected').map(x=>x.reason),successful=results.filter(x=>x.status==='fulfilled').map(x=>x.value);
  if(!successful.length&&errors.length)throw Object.assign(new Error(errors.map(x=>x.part+': '+x.error).join('; ')),{statusCode:503,code:'SNAPSHOT_READ_FAILED'});
  const pomodoroTasks=[...context.personalRaw.tasks.values()].filter(p=>!p.archived&&!p.in_trash).map(mapPersonalTask),tasks=pomodoroTasks.filter(context.recentTask),containers=[...context.personalRaw.containers.values()].filter(p=>!p.archived&&!p.in_trash).map(mapPersonalContainer);
  applyPersonalContainerDefaults(pomodoroTasks,containers);
  const result={tasks,containers,pomodoroTasks,fetchedAt:new Date().toISOString(),database:context.TASKS_DB,containersDatabase:context.PERSONAL_CONTAINERS_DB,sync:{mode:force?'full':'incremental',successful,errors,partial:errors.length>0}};context.personalTasksCache=result;context.personalTasksCacheAt=Date.now();saveRawSnapshotCache();return result;
 })().then(result=>result||personalSnapshotAfterMutation(force,fresh,retry,light)).finally(()=>{context.personalTasksInFlight=null;});
 return context.personalTasksInFlight;
}

async function personalSnapshotAfterMutation(force,fresh,retry,light){context.personalTasksInFlight=null;return personalSnapshotUnbounded(force,true,retry,light);}

function personalContainerProperties(body, includeName = false) {
  const properties = {
    X: { number: personalNumber(body.x, 60) },
    Y: { number: personalNumber(body.y, 60) },
    Width: { number: personalNumber(body.width, 340) },
    Height: { number: personalNumber(body.height, 220) },
    Order: { number: personalNumber(body.order, 0) }
  };
  if (includeName) properties.Name = { title: [{ type: 'text', text: { content: String(body.name || 'Qovluq').trim().slice(0, 2000) || 'Qovluq' } }] };
  if (body.parentId !== undefined) properties['Parent Container'] = { relation: body.parentId ? [{ id: context.cleanId(String(body.parentId)) }] : [] };
  if (body.color !== undefined) properties.Color = body.color ? { select: { name: String(body.color) } } : { select: null };
  return properties;
}

async function createPersonalContainer(body) {
  if (!context.PERSONAL_CONTAINERS_DB && !context.PERSONAL_CONTAINERS_DS) throw new Error('Verilənlər bazası konfiqurasiya edilməyib Personal Containers');
  const page = await context.notion('/pages', { method: 'POST', body: JSON.stringify({ parent: context.databaseParent(context.PERSONAL_CONTAINERS_DB, context.PERSONAL_CONTAINERS_DS), properties: personalContainerProperties(body, true) }) });
  invalidatePersonalTasks();
  return { ok: true, container: mapPersonalContainer(page), savedAt: new Date().toISOString() };
}

async function savePersonalLayout(body) {
  const kind = body.kind === 'container' ? 'container' : 'task';
  const id = context.cleanId(String(body.id || '').trim());
  if (!id) throw new Error('Müəyyən edilməyib ID şəxsi element');
  let properties;
  if (kind === 'container') {
    properties = personalContainerProperties(body, false);
  } else {
    properties = {
      'Personal X': { number: personalNumber(body.x, 0) },
      'Personal Y': { number: personalNumber(body.y, 0) },
      'Personal Width': { number: personalNumber(body.width, 220) },
      'Personal Height': { number: personalNumber(body.height, 105) },
      'Personal Order': { number: personalNumber(body.order, 0) }
    };
    if (body.containerId !== undefined) { const parentId=context.relationIds(await context.notion('/pages/'+encodeURIComponent(id)),'Parent item')[0]||'';const destination=await resolvePersonalTaskContainer({...body,parentId});properties['Personal Container']={relation:destination?[{id:destination}]:[]}; }
  }
  await context.notion('/pages/' + encodeURIComponent(id), { method: 'PATCH', body: JSON.stringify({ properties }) });
  invalidatePersonalTasks();
  return { ok: true, kind, id, ...(kind==='task'&&properties['Personal Container']?{containerId:properties['Personal Container'].relation[0]?.id||''}:{}), savedAt: new Date().toISOString() };
}

async function deletePersonalContainer(id) {
  const containerId = context.cleanId(String(id || '').trim());
  if (!containerId) throw new Error('Müəyyən edilməyib ID konteyner');
  try {
    const taskPages = await context.queryDatabase(context.TASKS_DB, context.TASKS_DS);
    const linked = taskPages.filter(page => context.relationIds(page, 'Personal Container').includes(containerId));
    for (const page of linked) {
      await context.notion('/pages/' + encodeURIComponent(page.id), { method: 'PATCH', body: JSON.stringify({ properties: { 'Personal Container': { relation: [] } } }) });
    }
  } catch (error) {
    console.warn('Could not clear container task links:', error.message);
  }
  await context.notion('/pages/' + encodeURIComponent(containerId), { method: 'PATCH', body: JSON.stringify({ archived: true }) });
  context.personalRaw.containers.delete(containerId);context.personalRaw.cursors.tasks={};saveRawSnapshotCache();invalidatePersonalTasks();
  return { ok: true, id: containerId, deleted: true, savedAt: new Date().toISOString() };
}
return { invalidatePersonalTasks, snapshotScope, cacheCall, snapshotMetadata, snapshotCollections, saveRawSnapshotCache, restoreRawSnapshotCache, checkbox, mapPersonalTask, mapPersonalContainer, personalNumber, inboxContainerId, personalInboxId, resolvePersonalTaskContainer, applyPersonalContainerDefaults, schedulePersonalContainerRepair, personalSnapshot, personalSnapshotUnbounded, personalSnapshotAfterMutation, personalContainerProperties, createPersonalContainer, savePersonalLayout, deletePersonalContainer };
};
