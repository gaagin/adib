// Server domain module. Dependencies are live bindings supplied by server.js.
'use strict';
module.exports = function serverTaskWrites(context) {
async function guardedAutosaveCreate(kind,body,create){
 const op=String(body.autosaveOperationId||'');if(!op)return create(body);
 if(!/^[a-zA-Z0-9-]{16,100}$/.test(op))throw Error('Yaradılma açarı etibarsızdır');
 const key=kind+'-'+op,file=context.path.join(__dirname,'data','autosave-'+key+'.json');
 if(context.autosaveCreates.has(key))return context.autosaveCreates.get(key);
 const operation=(async()=>{let prior;try{prior=JSON.parse(context.fs.readFileSync(file,'utf8'))}catch{}if(prior?.result)return prior.result;if(prior&&!prior.rejected){const e=Error('Yaradılma artıq təqdim edilib. Yenidən yaratmazdan əvvəl tapşırıq siyahısını yoxlayın.');e.code='TASK_CREATE_PARTIAL';e.statusCode=409;throw e}
 context.fs.mkdirSync(context.path.dirname(file),{recursive:true});context.fs.writeFileSync(file,JSON.stringify({pending:true,at:Date.now()}));
 if(prior?.rejected){/* Explicit validation rejection: no page was created. */}else if(prior){const e=Error('Yaradılma cavabı məlum deyil. Siyahını yoxlayın.');e.code='TASK_CREATE_PARTIAL';e.statusCode=409;throw e}
 try{const result=await create(body);context.fs.writeFileSync(file,JSON.stringify({result}));return result;}catch(error){if(error.notionStatus===400&&error.notionCode==='validation_error'||['TASK_STATUS_INVALID','TASK_SCHEMA_INVALID'].includes(error.code)){context.fs.writeFileSync(file,JSON.stringify({rejected:true,at:Date.now()}));error.code='TASK_CREATE_REJECTED';error.statusCode=400;}throw error;}})();context.autosaveCreates.set(key,operation);try{return await operation}finally{context.autosaveCreates.delete(key)}
}

async function validatePersonalTaskContext(body){
 if(body.machineId===undefined&&body.planId===undefined)return;
 const old=context.taskManagement.getContext(body.id||'');
 const next={...old};for(const key of ['machineId','planId'])if(body[key]!==undefined){const raw=String(body[key]??'').trim(),id=raw?context.cleanId(raw):'';if(raw&&!id)throw Object.assign(Error('Etibarsız əlaqə: '+key),{statusCode:400});next[key]=id;body[key]=id;}
 if(next.machineId===old.machineId&&next.planId===old.planId)return;
 if(!next.machineId&&!next.planId)return;
 if(body.__account&&typeof context.accounts!=='undefined'&&!context.accounts.section(body.__account,'equipment'))throw Object.assign(Error('Avadanlıq bölməsinə giriş yoxdur'),{statusCode:403});
 let data=await context.snapshot(false);if(body.__account&&typeof context.projectAccount==='function')data=context.projectAccount(body.__account,'equipment',data);
 const equipment=data.equipment||[],plans=data.plans||[];
 if(next.machineId){const machine=equipment.find(e=>context.cleanId(e.id)===next.machineId);if(!machine)throw Object.assign(Error('Avadanlıq mövcud deyil və ya ona giriş yoxdur'),{statusCode:400});const machinePlan=context.cleanId(machine.planId||'');if(next.planId&&machinePlan&&next.planId!==machinePlan)throw Object.assign(Error('Plan seçilmiş avadanlığa uyğun deyil'),{statusCode:400});if(machinePlan){next.planId=machinePlan;body.planId=machinePlan;}}
 if(next.planId&&!plans.some(p=>context.cleanId(p.id)===next.planId))throw Object.assign(Error('Plan mövcud deyil və ya ona giriş yoxdur'),{statusCode:400});
}

async function createPersonalTask(body) {
 if(body.autosaveOperationId)return guardedAutosaveCreate('personal',body,b=>createPersonalTask({...b,autosaveOperationId:undefined}));
  context.validateTaskEstimate(body);
  await validatePersonalTaskContext(body);
  const titleValue = String(body.title || '').trim().slice(0, 2000);
  if (!titleValue) throw new Error('Tapşırığın adını daxil edin');
  const properties = {
    Adi: { title: context.createText(titleValue) },
    Status: { status: { name: String(body.status || 'Not started').trim() || 'Not started' } },
    'Status 1': { checkbox: Boolean(body.completed) }
  };
  if (body.priority) properties.Priority = { select: { name: String(body.priority).trim() } };
  if (body.prioritet) properties.Prioritet = { status: { name: String(body.prioritet).trim() } };
  if (body.category) properties.Kateqoriya = { select: { name: String(body.category).trim() } };
  if(body.date!==undefined||body.dateEnd!==undefined) properties.Tarix={date:context.personalCalendarDate(body)};
  if (Array.isArray(body.tags) && body.tags.length) properties.Tag = { multi_select: body.tags.map(value => ({ name: String(value).trim() })).filter(item => item.name).slice(0, 100) };
  if (Array.isArray(body.assignees) && body.assignees.length) properties.Tapsirildi = { multi_select: body.assignees.map(value => ({ name: String(value).trim() })).filter(item => item.name).slice(0, 100) };
  if (body.parentId) properties['Parent item'] = { relation: [{ id: context.cleanId(String(body.parentId)) }] };
  if (body.containerId) properties['Personal Container'] = { relation: [{ id: context.cleanId(String(body.containerId)) }] };
  const destination=await context.resolvePersonalTaskContainer(body);properties['Personal Container']={relation:destination?[{id:destination}]:[]};
  const parent = context.TASKS_DS ? { data_source_id: context.TASKS_DS } : { database_id: context.TASKS_DB };
  const page = await context.notion('/pages', { method: 'POST', body: JSON.stringify({ parent, properties }) });
  await context.persistTaskEstimate({...body,sourceKey:'personal'},page.id,true);
  if (body.pageBlocks !== undefined) await context.replacePersonalTaskBlocks(page.id, body.pageBlocks);
  else if (body.pageContent !== undefined) await context.replacePersonalTaskContent(page.id, body.pageContent);
  context.invalidatePersonalTasks();
  return { ok: true, id: page.id, task:{...context.mapPersonalTask(page),estimateMinutes:context.taskManagement.getEstimate(page.id)}, estimateMinutes:context.taskManagement.getEstimate(page.id), url: page.url || '', savedAt: new Date().toISOString() };
}

async function deletePersonalTask(idValue) {
  const id = context.cleanId(String(idValue || '').trim());
  if (!id) throw new Error('Müəyyən edilməyib ID tapşırıqları Tasks');
  await context.archiveNotionPage(id);
  context.personalRaw.tasks.delete(id);context.taskManagement.update({type:'archive',id});context.saveRawSnapshotCache();context.invalidatePersonalTasks();
  return { ok: true, id, deleted: true, savedAt: new Date().toISOString() };
}

async function savePersonalTask(body){
 if(String(body.status||'').trim().toLowerCase()==='in progress'){
  const operation=context.personalStatusWriteQueue.then(async()=>{const pages=await context.queryDatabase(context.TASKS_DB,context.TASKS_DS,{filter:{property:'Status 1',checkbox:{equals:false}}});context.taskManagement.checkWip(pages.map(context.mapPersonalTask),context.cleanId(String(body.id||'')),body.wipOverride);return savePersonalTaskUnlocked(body)});
  context.personalStatusWriteQueue=operation.catch(()=>{});return operation;
 }
 return savePersonalTaskUnlocked(body);
}

async function savePersonalTaskUnlocked(body) {
  context.validateTaskEstimate(body);
  await validatePersonalTaskContext(body);
  const id = context.cleanId(String(body.id || '').trim());
  if (!id) throw new Error('Müəyyən edilməyib ID tapşırıqları Tasks');
  if(body.autosaveBase&&typeof body.autosaveBase==='object'){
    const current=context.mapPersonalTask(await context.notion('/pages/'+encodeURIComponent(id)));
    for(const [key,expected]of Object.entries(body.autosaveBase)){
      if(['pageBlocks','pageContent','estimateMinutes'].includes(key)||current[key]===undefined)continue;
      const normalize=value=>{if(['date','dateEnd'].includes(key)&&typeof value==='string'&&value.includes('T')&&Number.isFinite(Date.parse(value)))return 'instant:'+Date.parse(value);return Array.isArray(value)?JSON.stringify([...value].sort()):String(value??'');};
      if(normalize(current[key])!==normalize(expected)&&normalize(current[key])!==normalize(body[key])){const e=Error('Sahəsi “'+key+'» başqa cihazda dəyişdirildi. Tapşırığı yeniləyin və dəyişiklikləri yoxlayın.');e.code='AUTOSAVE_CONFLICT';e.statusCode=409;throw e}
    }
  }
  const properties = {};
  if (body.title !== undefined) properties.Adi = { title: [{ type: 'text', text: { content: String(body.title || '').trim().slice(0, 2000) } }] };
  if (body.status !== undefined && String(body.status).trim()) properties.Status = { status: { name: String(body.status).trim() } };
  if (body.completed !== undefined) properties['Status 1'] = { checkbox: Boolean(body.completed) };
  if (body.priority !== undefined) properties.Priority = body.priority ? { select: { name: String(body.priority).trim() } } : { select: null };
  if (body.prioritet !== undefined) properties.Prioritet = body.prioritet ? { status: { name: String(body.prioritet).trim() } } : { status: null };
  if (body.category !== undefined) properties.Kateqoriya = body.category ? { select: { name: String(body.category).trim() } } : { select: null };
  if(body.date!==undefined||body.dateEnd!==undefined){const previous=body.dateEnd===undefined&&body.date?context.mapPersonalTask(await context.notion('/pages/'+encodeURIComponent(id))):{};properties.Tarix={date:context.personalCalendarDate(body,previous)};}
  if (body.tags !== undefined) properties.Tag = { multi_select: (Array.isArray(body.tags) ? body.tags : String(body.tags || '').split(',')).map(value => String(value).trim()).filter(Boolean).slice(0, 100).map(name => ({ name })) };
  if (body.assignees !== undefined) properties.Tapsirildi = { multi_select: (Array.isArray(body.assignees) ? body.assignees : String(body.assignees || '').split(',')).map(value => String(value).trim()).filter(Boolean).slice(0, 100).map(name => ({ name })) };
  if (body.parentId !== undefined) {
    const parentId = context.cleanId(String(body.parentId || '').trim());
    properties['Parent item'] = { relation: parentId ? [{ id: parentId }] : [] };
  }
  if (body.containerId !== undefined) { const parentId=body.parentId!==undefined?body.parentId:context.relationIds(await context.notion('/pages/'+encodeURIComponent(id)),'Parent item')[0]||'';const destination=await context.resolvePersonalTaskContainer({...body,parentId});properties['Personal Container']={relation:destination?[{id:destination}]:[]}; }
  if (!Object.keys(properties).length && body.estimateMinutes===undefined && body.pageBlocks===undefined && body.pageContent===undefined && body.machineId===undefined && body.planId===undefined) throw new Error('Tapşırıq dəyişikliyi yoxdur');
  if(Object.keys(properties).length) await context.notion('/pages/' + encodeURIComponent(id), { method: 'PATCH', body: JSON.stringify({ properties }) });
  const sessionTitleSync = body.title !== undefined
    ? await context.syncTaskSessionTitle(id, 'personal', String(body.title || '').trim())
    : undefined;
  if (body.pageBlocks !== undefined) await context.replacePersonalTaskBlocks(id, body.pageBlocks);
  else if (body.pageContent !== undefined) await context.replacePersonalTaskContent(id, body.pageContent);
  await context.persistTaskEstimate({...body,sourceKey:'personal'},id);
  if(body.completed!==undefined||body.status!==undefined){const completed=body.completed!==undefined?body.completed===true:context.taskHistory.done({status:body.status});context.recordCompletion(id,completed);if(completed)context.taskManagement.update({type:'finish',id});}
  context.invalidatePersonalTasks();
  return { ok: true, id,...(sessionTitleSync?{sessionTitleSync}:{}),...context.taskManagement.getContext(id),...(properties.Tarix?{date:properties.Tarix.date?.start||'',dateEnd:properties.Tarix.date?.end||'',task:{id,date:properties.Tarix.date?.start||'',dateEnd:properties.Tarix.date?.end||''}}:{}),...(properties['Personal Container']?{task:{id,containerId:properties['Personal Container'].relation[0]?.id||'',...(properties.Tarix?{date:properties.Tarix.date?.start||'',dateEnd:properties.Tarix.date?.end||''}:{})}}:{}),completedAt:context.taskManagement.state.tasks[id]?.completedAt||null, estimateMinutes:context.taskManagement.getEstimate(id), savedAt: new Date().toISOString() };
}
return { guardedAutosaveCreate, validatePersonalTaskContext, createPersonalTask, deletePersonalTask, savePersonalTask, savePersonalTaskUnlocked };
};
