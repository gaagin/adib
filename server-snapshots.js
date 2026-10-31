// Server domain module. Dependencies are live bindings supplied by server.js.
'use strict';
module.exports = function serverSnapshots(context) {
function enrichCompletion(task,page){return context.completionHistory.enrich(task,page,context.taskManagement.state.tasks[task.id]||{});}

function recordCompletion(id,completed){const known=context.completionHistory.rows[id];if(completed&&known?.ignoredMetaAt&&known.ignoredMetaAt===context.taskManagement.state.tasks[id]?.completedAt)context.taskManagement.update({type:'completion',id,completed:false});return context.taskManagement.update({type:'completion',id,completed,...(completed?{completedAt:known?.done&&known.completedAt||new Date(context.taskHistory.now()).toISOString(),completionDateSource:known?.done?known.source:'recorded'}:{})});}

function recentTask(task){return context.taskHistory.visible(task);}

function taskIsCompleted(page, source) {
  const checkbox = context.property(page, source.completeName)?.checkbox;
  if (checkbox === true) return true;
  const process = source.statusNames.map(name => context.select(page, name)).find(Boolean) || '';
  return /^(done|complete|completed|is goruldu|tamamlandi|bitdi|bitib)$/i.test(process.trim());
}

function relationFilter(propertyName, pageIds) {
  const filters = pageIds.map(id => ({ property: propertyName, relation: { contains: id } }));
  if (!filters.length) return null;
  return filters.length === 1 ? filters[0] : { or: filters };
}

function taskSources() {
  const sources = [];
  const todo = context.taskConfig('todo');
  const gorulen = context.taskConfig('gorulen');
  if (context.TODO_DB || context.TODO_DS) sources.push({ key: 'todo', databaseId: context.TODO_DB, dataSourceId: context.TODO_DS, source: 'ToDo', relationName: context.machineRelationProperty(), planRelationName: todo.planRelation, titleNames: [todo.title, 'ToDo', 'Name'], statusNames: [todo.process, 'Proses', 'Status'], priorityName: todo.priority, dateName: todo.date, assigneeName: todo.assignee, tapsirildiName: todo.tapsirildi, doneWorkName: todo.doneWork, doneWorkType: todo.doneWorkType, gtdName: todo.gtdProperty, gtdValue: todo.gtdValue, isciTagName: todo.isciTagProperty, completeName: todo.complete, linkProperty: todo.linkProperty });
  if (context.GORULEN_DB || context.GORULEN_DS) sources.push({ key: 'gorulen', databaseId: context.GORULEN_DB, dataSourceId: context.GORULEN_DS, source: 'Gorulen isler', relationName: context.machineRelationProperty(), planRelationName: gorulen.planRelation, titleNames: [gorulen.title, 'Gorulmeli is', 'Name'], statusNames: [gorulen.process, 'Proses', 'Status'], priorityName: gorulen.priority, dateName: gorulen.date, assigneeName: gorulen.assignee, tapsirildiName: gorulen.tapsirildi, gtdName: gorulen.gtdProperty, workTypeName: gorulen.workTypeProperty, tagName: gorulen.tagProperty, doneWorkName: gorulen.doneWork, doneWorkType: gorulen.doneWorkType, periodicName: gorulen.periodicProperty, periodicValue: gorulen.periodicValue, completeName: gorulen.complete, linkProperty: gorulen.linkProperty });
  return sources;
}

function combineFilters(...filters) {
  const list = filters.flat().filter(Boolean);
  if (!list.length) return null;
  return list.length === 1 ? list[0] : { and: list };
}

function editedSinceFilter(since) {
  const date=Date.parse(since);return Number.isFinite(date)?{timestamp:'last_edited_time',last_edited_time:{on_or_after:new Date(Math.max(0,date-120000)).toISOString()}}:null;
}

function equipmentTaskWindowFilter(dateName){
 const cutoff=new Date(Date.now()-context.taskHistory.WINDOW).toISOString(),recentEdit={timestamp:'last_edited_time',last_edited_time:{on_or_after:cutoff}};
 return dateName?{or:[{property:dateName,date:{on_or_after:cutoff}},recentEdit]}:recentEdit;
}

function changedCursor(pages,previous=''){let max=Date.parse(previous)||0;for(const p of pages)max=Math.max(max,Date.parse(p.last_edited_time)||0);return max?new Date(max).toISOString():previous;}

function collectionNeedsFull(cursor,force,windowVersion=0){return force||!cursor?.since||!cursor.fullAt||Date.now()-cursor.fullAt>=context.FULL_RECONCILE_MS||cursor.fullAt>Date.now()+60000||windowVersion>0&&cursor.windowVersion!==windowVersion;}

function syncError(part,error){return {part,error:String(error?.message||error||'Cavab yoxdur Notion').slice(0,700)};}

async function queryTaskPages(machineIds = [], since = '', restrictToMachines = true) {
  const queried = await Promise.all(taskSources().map(async source => {
    try {
      const filter = combineFilters(
        restrictToMachines ? relationFilter(source.relationName, machineIds) : null,
        editedSinceFilter(since),
        equipmentTaskWindowFilter(source.dateName)
      );
      return { source, pages: await context.queryDatabase(source.databaseId, source.dataSourceId, filter ? { filter } : {}) };
    } catch (error) {
      console.error('Task source unavailable:', source.source, error.message);
      return { source, pages: [] };
    }
  }));
  return queried;
}

function buildTaskMap(pageSets, machineIds = [], baseUrl = '', includeCompleted = false) {
  const result = new Map();
  for (const { source, pages } of pageSets) {
    for (const page of pages) {
      const linkedMachines = context.relationIds(page, source.relationName);
      const linkedPlan = context.relationIds(page, source.planRelationName)[0] || '';
      if (!linkedMachines.length && !linkedPlan) continue;
      if (machineIds.length && !linkedMachines.some(id => machineIds.includes(id)) && !linkedPlan) continue;
      if (source.key === 'gorulen' && context.select(page, source.periodicName).trim().toLowerCase() === String(source.periodicValue).trim().toLowerCase()) continue;
      if (source.key === 'todo' && context.select(page, source.gtdName).trim().toLowerCase() === String(source.gtdValue).trim().toLowerCase()) continue;
      if(page.archived||page.in_trash)continue;
      const taskTitle = source.titleNames.map(name => context.title(page, name)).find(Boolean) || 'Tapşırıq';
      const taskStatus = source.statusNames.map(name => context.select(page, name)).find(Boolean) || 'Açıq';
      const assignee = context.person(page, source.assigneeName);
      const taskPriority = context.select(page, source.priorityName); let task = { id: page.id, sourceKey: source.key, title: taskTitle, meta: taskStatus, status: taskStatus, process: taskStatus, priority: taskPriority, urgent: String(taskPriority).trim() === '!!!', assigneeId: assignee.id, assigneeName: assignee.name, tapsirildi: context.multiSelect(page, source.tapsirildiName), gtd: context.select(page, source.gtdName), workType: context.select(page, source.workTypeName), isciTag: context.select(page, source.isciTagName), tag: context.select(page, source.tagName), doneWork: context.richText(page, source.doneWorkName), source: source.source, date: context.dateStart(page, source.dateName), dateEnd: context.property(page,source.dateName)?.date?.end||'', createdAt:page.created_time||'', machineId:linkedMachines[0]||'',machineIds:linkedMachines,completed: taskIsCompleted(page,source), parentId:context.taskManagement.state.tasks[page.id]?.parentId||'', estimateMinutes:context.taskEstimates.read(page), pomodoroCount:context.number(page,'Pomodoro количество')||0,pomodoroMinutes:context.number(page,'Pomodoro всего минут')||0, planId: linkedPlan || null, url: context.pageUrl(page), serviceUrl: context.serviceLink(baseUrl, 'task', page.id, linkedMachines[0] ? { machine: linkedMachines[0] } : { plan: linkedPlan }) };
      task=enrichCompletion({...task,updatedAt:page.last_edited_time||''},page);if(!includeCompleted&&!context.taskHistory.visibleEquipment(task))continue;
      for (const machineId of linkedMachines) {
        if (!result.has(machineId)) result.set(machineId, []);
        result.get(machineId).push(task);
      }
      if (!linkedMachines.length && linkedPlan) {
        const key = `plan:${linkedPlan}`;
        if (!result.has(key)) result.set(key, []);
        result.get(key).push(task);
      }
    }
  }
  return result;
}

function buildSnapshotFromRawCache(baseUrl = '') {
  const machinePages = [...context.rawCache.machines.values()];
  const machineIds = machinePages.map(page => page.id);
  const taskSets = taskSources().map(source => ({ source, pages: [...(context.rawCache.tasks.get(source.key) || new Map()).values()] }));
  const tasks = buildTaskMap(taskSets, machineIds, baseUrl);
  const mappedPlans = context.mapPlans([...context.rawCache.plans.values()], baseUrl).map(plan => ({ ...plan, tasks: tasks.get(`plan:${plan.id}`) || [] }));
  const mappedEquipment = context.mapEquipment(machinePages, tasks, baseUrl);
  attachTaskCounts(mappedPlans, mappedEquipment);
  return { fetchedAt: new Date().toISOString(), plans: mappedPlans, equipment: mappedEquipment, pomodoroTasks:[...buildTaskMap(taskSets,machineIds,baseUrl,true).values()].flat().filter(task=>context.taskHistory.visibleEquipment(task)) };
}

function mergePages(target, pages) {
  for (const page of pages) {
    const deletedUntil=context.realtimeTombstones.get(page.id)||0;if(deletedUntil>Date.now()&&!page.archived&&!page.in_trash)continue;if(deletedUntil&&deletedUntil<=Date.now())context.realtimeTombstones.delete(page.id);
    if (page.archived||page.in_trash) {
      target.delete(page.id);
      continue;
    }
    const existing = target.get(page.id);
    if (!existing || !existing.last_edited_time || !page.last_edited_time || page.last_edited_time >= existing.last_edited_time) target.set(page.id, page);
  }
}

function beginSnapshotProgress(scope,specs,full,background=false){
 const state={revision:++context.snapshotProgressRevision,running:true,mode:full?'full':'incremental',pending:specs.map(s=>({key:s.key,part:s.label})),successful:[],available:[],loaded:{},pages:{},fullReads:[],resumedRecords:0,errors:[]};
 (background?context.backgroundProgress:context.snapshotProgress)[scope]=state;return state;
}

function completeSnapshotPart(state,spec,error){
 state.pending=state.pending.filter(x=>x.key!==spec.key);
 if(error)state.errors.push(syncError(spec.label,error));else state.successful.push(spec.key);
 state.revision=++context.snapshotProgressRevision;
}

function progressiveSnapshot(scope){
 const state=context.snapshotProgress[scope];
 const pomodoroTasks=scope==='personal'?[...context.personalRaw.tasks.values()].filter(p=>!p.archived&&!p.in_trash).map(context.mapPersonalTask):null;
 const data=scope==='personal'?{tasks:pomodoroTasks.filter(recentTask),containers:[...context.personalRaw.containers.values()].filter(p=>!p.archived&&!p.in_trash).map(context.mapPersonalContainer),pomodoroTasks,database:context.TASKS_DB,containersDatabase:context.PERSONAL_CONTAINERS_DB}:buildSnapshotFromRawCache();
 if(scope==='personal')context.applyPersonalContainerDefaults(data.pomodoroTasks,data.containers);
 return {...data,cache:{...context.cacheHealth},sync:state?{...state,partial:state.pending.length>0||state.errors.length>0}:{revision:0,running:false,successful:[],errors:[],pending:[],partial:true}};
}

function equipmentSnapshotSpecs(){return [{key:'plans',label:'Planlar',db:context.PLAN_DB,ds:context.PLAN_DS},{key:'machines',label:'Avadanlıq',db:context.MAKINA_DB,ds:context.MAKINA_DS},...taskSources().map(source=>({key:source.key,label:source.source,db:source.databaseId,ds:source.dataSourceId,dateName:source.dateName,windowVersion:1}))];}

function personalSnapshotSpecs(){return [{key:'tasks',label:'Tapşırıqlarım',db:context.TASKS_DB,ds:context.TASKS_DS},{key:'containers',label:'Qovluqlar',db:context.PERSONAL_CONTAINERS_DB,ds:context.PERSONAL_CONTAINERS_DS}];}

function streamSnapshotPart(progress,spec,target,cursors,force,light=false,valid=()=>true,background=false){
 const cursor=cursors[spec.key]||{},scopeKey=(cursors===context.personalRaw.cursors?'personal:':'equipment:')+spec.key;
 const sql=typeof context.fs.snapshotBatch==='function',checkpointKey=background?'auditResume':'resume';
 const readStartedAt=new Date().toISOString();
 const windowVersion=spec.windowVersion||0;
 let scan=(!force||background)&&cursor[checkpointKey]?structuredClone(cursor[checkpointKey]):null;
 if(scan&&scan.windowVersion!==windowVersion)scan=null;
 const resumed=!!scan;
 const isFull=scan?!!scan.isFull:(force||!cursor.fullAt||windowVersion>0&&cursor.windowVersion!==windowVersion||!light&&collectionNeedsFull(cursor,false,windowVersion));
 if(isFull)progress.fullReads.push(spec.key);
 if(!scan)scan={startedAt:readStartedAt,isFull,id:isFull?context.crypto.randomUUID():'',nextCursor:null,done:false,loaded:0,maxEdited:cursor.since||'',filterSince:cursor.since||'',windowVersion,...(!sql&&isFull?{baseline:[...target].map(([id,page])=>[id,page.last_edited_time||'']),seen:[]}: {})};
 if(resumed)progress.resumedRecords+=scan.loaded||0;
 if(scan.loaded){progress.available.push(spec.key);progress.pages[spec.key]=1;}
 const metadataFor=value=>context.snapshotMetadata({key:scopeKey,cursor:value});
 const commitCheckpoint=(next,pages,begin=false)=>{
  const state={...(cursors[spec.key]||cursor),[checkpointKey]:next};
  if(sql){context.cacheCall(()=>begin?context.fs.snapshotBegin(context.snapshotScope(),scopeKey,next.id,metadataFor(state)):context.fs.snapshotBatch(context.snapshotScope(),scopeKey,pages,next.id,metadataFor(state)));cursors[spec.key]=state;}
  else{cursors[spec.key]=state;mergePages(target,pages);context.saveRawSnapshotCache();}
 };
 if(!resumed){try{commitCheckpoint(scan,[],isFull);}catch(error){completeSnapshotPart(progress,spec,error);return Promise.reject(syncError(spec.label,error));}}
 const filter=combineFilters(isFull?null:editedSinceFilter(scan.filterSince),windowVersion?equipmentTaskWindowFilter(spec.dateName):null);
 const query={...(filter?{filter}:{}),sorts:[{timestamp:'last_edited_time',direction:'descending'}]};
 const read=scan.done?Promise.resolve([]):context.queryDatabase(spec.db,spec.ds,query,(page,info)=>{
  if(!valid())return;
  const next={...scan,nextCursor:info.nextCursor,done:!info.hasMore,loaded:scan.loaded+page.length,maxEdited:changedCursor(page,scan.maxEdited),readBarrier:scan.readBarrier||info.readBarrier||''};
  if(!sql&&isFull)next.seen=[...new Set([...(scan.seen||[]),...page.map(p=>p.id)])];
  // SQL commits each page and its next cursor atomically; never advance the completed-read watermark early.
  commitCheckpoint(next,page);scan=next;mergePages(target,page);
  progress.loaded[spec.key]=(progress.loaded[spec.key]||0)+page.length;
  progress.pages[spec.key]=(progress.pages[spec.key]||0)+1;
  if(!progress.available.includes(spec.key))progress.available.push(spec.key);
  progress.revision=++context.snapshotProgressRevision;
 },background?'history':'interactive',scan);
 return read.then(()=>{
  if(valid()){
   const current=cursors[spec.key]||{};const finished={...current,...(windowVersion?{windowVersion}:{}),since:scan.readBarrier||scan.maxEdited||current.since||scan.startedAt||readStartedAt,fullAt:isFull?Date.now():current.fullAt,error:background?(current.error||''):'',auditError:''};delete finished[checkpointKey];
   if(sql){const removed=context.cacheCall(()=>context.fs.snapshotFinish(context.snapshotScope(),scopeKey,scan.id,metadataFor(finished)))||[];for(const id of removed)target.delete(id);cursors[spec.key]=finished;}
   else{if(isFull){const seen=new Set(scan.seen||[]);for(const [id,edited] of scan.baseline||[]){const live=target.get(id);if(!seen.has(id)&&live&&live.last_edited_time===edited)target.delete(id);}}cursors[spec.key]=finished;context.saveRawSnapshotCache();}
  }
  completeSnapshotPart(progress,spec);return spec.key;
 }).catch(error=>{if(valid()){const current=cursors[spec.key]||cursor;cursors[spec.key]={...current,[background?'auditError':'error']:String(error.message||error)};if(/Notion API 400:.*(?:cursor|pagination)/i.test(error.message||''))delete cursors[spec.key][checkpointKey];context.saveRawSnapshotCache();}completeSnapshotPart(progress,spec,error);throw syncError(spec.label,error);});
}

async function syncEquipmentCollections(full,startedAt,baseUrl='',retry=false,light=false){
 context.rawCache.cursors=context.rawCache.cursors||{};
 const specs=equipmentSnapshotSpecs(),failed=specs.filter(x=>context.rawCache.cursors[x.key]?.error),selected=retry&&failed.length?failed:specs;
 const progress=beginSnapshotProgress('equipment',selected,full);
 const results=await Promise.allSettled(selected.map(spec=>streamSnapshotPart(progress,spec,spec.key==='plans'?context.rawCache.plans:spec.key==='machines'?context.rawCache.machines:context.rawCache.tasks.get(spec.key),context.rawCache.cursors,full,light)));
 const errors=results.filter(x=>x.status==='rejected').map(x=>x.reason),successful=results.filter(x=>x.status==='fulfilled').map(x=>x.value);
 progress.running=false;progress.revision=++context.snapshotProgressRevision;
 if(!successful.length&&errors.length)throw Object.assign(new Error(errors.map(x=>x.part+': '+x.error).join('; ')),{statusCode:503,code:'SNAPSHOT_READ_FAILED'});
 context.rawCache.lastSyncAt=startedAt;if(!errors.length)context.rawCache.lastFullSyncAt=Date.now();context.saveRawSnapshotCache();
 return {...buildSnapshotFromRawCache(baseUrl),sync:{mode:full?'full':'incremental',successful,errors,partial:errors.length>0}};
}

function reconcileSnapshot(scope){
 if(context.backgroundJobs.has(scope))return context.backgroundJobs.get(scope);
 const personal=scope==='personal',cursors=personal?context.personalRaw.cursors:(context.rawCache.cursors=context.rawCache.cursors||{});
 const specs=(personal?personalSnapshotSpecs():equipmentSnapshotSpecs()).filter(spec=>{const c=cursors[spec.key];return c?.fullAt&&!c.error&&collectionNeedsFull(c,false,spec.windowVersion||0);});
 if(!specs.length)return Promise.resolve(null);
 const generation=context.personalTasksGeneration,valid=()=>!personal||generation===context.personalTasksGeneration;
 const progress=beginSnapshotProgress(scope,specs,true,true);
 const work=(async()=>{for(const spec of specs){try{await streamSnapshotPart(progress,spec,personal?context.personalRaw[spec.key]:spec.key==='plans'?context.rawCache.plans:spec.key==='machines'?context.rawCache.machines:context.rawCache.tasks.get(spec.key),cursors,true,true,valid,true);}catch{/* Specific error is already recorded in the audit state. */}}
  progress.running=false;progress.revision=++context.snapshotProgressRevision;
  context.snapshotCache=null;context.personalTasksCache=null;context.saveRawSnapshotCache();return progress;
 })().finally(()=>context.backgroundJobs.delete(scope));context.backgroundJobs.set(scope,work);return work;
}

async function fullSync(startedAt,baseUrl='',retry=false,light=false){return syncEquipmentCollections(true,startedAt,baseUrl,retry,light);}

async function incrementalSync(startedAt,baseUrl='',retry=false,light=false){return syncEquipmentCollections(false,startedAt,baseUrl,retry,light);}

function snapshot(full=false,baseUrl='',fresh=false,retry=false,light=false){return context.queryPolicy.run('equipment',{refresh:full||fresh||retry,cached:()=>context.snapshotCache?(context.snapshotCacheBaseUrl===baseUrl?context.snapshotCache:{...buildSnapshotFromRawCache(baseUrl),sync:context.snapshotCache.sync}):null,load:()=>snapshotUnbounded(full,baseUrl,fresh,retry,light)});}

async function snapshotUnbounded(full = false, baseUrl = '', fresh=false,retry=false,light=false) {
  if (context.snapshotCache && !full && !fresh && context.snapshotCacheBaseUrl === baseUrl && Date.now() - context.snapshotCacheAt < context.SNAPSHOT_CACHE_MS) return context.snapshotCache;
  if (context.snapshotInFlight) return context.snapshotInFlight;
  const startedAt = new Date().toISOString();
  const needsFull = full || (!light&&!context.rawCache.lastSyncAt);
  context.snapshotInFlight = (needsFull ? fullSync(startedAt, baseUrl,retry,light) : incrementalSync(startedAt, baseUrl,retry,light))
    .then(result => { const payload = JSON.stringify({ plans: result.plans || [], equipment: result.equipment || [], pomodoroTasks:result.pomodoroTasks||[] }); context.snapshotEtag = '"' + context.crypto.createHash('sha1').update(payload).digest('hex') + '"'; result.etag = context.snapshotEtag; context.snapshotCache = result; context.snapshotCacheBaseUrl = baseUrl; context.snapshotCacheAt = Date.now(); return result; })
    .finally(() => { context.snapshotInFlight = null; });
  return context.snapshotInFlight;
}

function zeroTaskCounts() { return { gorulen: 0, todo: 0, total: 0, urgent: 0,open:0,done:0 }; }

function countTasks(tasks) { return context.taskHistory.counts(tasks); }

function attachTaskCounts(plans, equipment) {
  const own = new Map();
  for (const machine of equipment) { machine.taskCounts = countTasks(machine.tasks); const current = own.get(machine.planId) || zeroTaskCounts(); current.open+=machine.taskCounts.open;current.done+=machine.taskCounts.done;current.gorulen += machine.taskCounts.gorulen; current.todo += machine.taskCounts.todo; current.total += machine.taskCounts.total; current.urgent += machine.taskCounts.urgent || 0; own.set(machine.planId, current); }
  for (const plan of plans) { const current = own.get(plan.id) || zeroTaskCounts(); const direct = countTasks(plan.tasks); current.open+=direct.open;current.done+=direct.done;current.gorulen += direct.gorulen; current.todo += direct.todo; current.total += direct.total; current.urgent += direct.urgent; own.set(plan.id, current); }
  const children = new Map();
  for (const plan of plans) { const list = children.get(plan.parentId || '') || []; list.push(plan); children.set(plan.parentId || '', list); }
  const visit = plan => { const counts = own.get(plan.id) || zeroTaskCounts(); for (const child of children.get(plan.id) || []) { const childCounts = visit(child); counts.open+=childCounts.open;counts.done+=childCounts.done;counts.gorulen += childCounts.gorulen; counts.todo += childCounts.todo; counts.total += childCounts.total; } plan.taskCounts = counts; return counts; };
  for (const plan of plans.filter(p => !p.parentId)) visit(plan);
}
return { enrichCompletion, recordCompletion, recentTask, taskIsCompleted, relationFilter, taskSources, combineFilters, editedSinceFilter, equipmentTaskWindowFilter, changedCursor, collectionNeedsFull, syncError, queryTaskPages, buildTaskMap, buildSnapshotFromRawCache, mergePages, beginSnapshotProgress, completeSnapshotPart, progressiveSnapshot, equipmentSnapshotSpecs, personalSnapshotSpecs, streamSnapshotPart, syncEquipmentCollections, reconcileSnapshot, fullSync, incrementalSync, snapshot, snapshotUnbounded, zeroTaskCounts, countTasks, attachTaskCounts };
};
