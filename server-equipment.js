// Server domain module. Dependencies are live bindings supplied by server.js.
'use strict';
module.exports = function serverEquipment(context) {
function isLocalBaseUrl(baseUrl) {
  try { return /^(localhost|127\.0\.0\.1)(:\d+)?$/i.test(new context.URL(baseUrl).host); }
  catch { return true; }
}

async function patchServiceLink(page, propertyName, link) {
  if (!page || !propertyName || !link) return false;
  const current = context.property(page, propertyName)?.url || '';
  if (current === link) return false;
  await context.notion('/pages/' + encodeURIComponent(page.id), {
    method: 'PATCH',
    body: JSON.stringify({ properties: { [propertyName]: { url: link } } })
  });
  return true;
}

async function syncServiceLinks(baseUrl, force = false) {
  const normalized = context.normalizeBaseUrl(baseUrl);
  if (!normalized || (isLocalBaseUrl(normalized) && !context.PUBLIC_APP_URL)) {
    return { ok: true, skipped: true, reason: 'İctimaiyyətə ehtiyac var PUBLIC_APP_URL' };
  }
  if (!force && context.linkSyncState.baseUrl === normalized && Date.now() - context.linkSyncState.at < context.LINK_SYNC_TTL_MS) {
    return { ok: true, skipped: true, updated: 0 };
  }
  if (context.linkSyncState.inFlight) return context.linkSyncState.inFlight;
  context.linkSyncState.inFlight = (async () => {
    const targets = [];
    const machines = await context.queryDatabase(context.MAKINA_DB, context.MAKINA_DS);
    for (const page of machines) targets.push({ page, propertyName: process.env.MAKINA_LINK_PROPERTY || context.LINK_PROPERTY_DEFAULT, link: context.serviceLink(normalized, 'equipment', page.id) });
    for (const source of context.taskSources()) {
      const pages = await context.queryDatabase(source.databaseId, source.dataSourceId);
      for (const page of pages) {
        const machineId = context.relationIds(page, source.relationName)[0] || '';
        const planId = context.relationIds(page, source.planRelationName)[0] || '';
        if (!machineId && !planId) continue;
        targets.push({ page, propertyName: source.linkProperty || context.TASK_LINK_PROPERTY_DEFAULT, link: context.taskAppLink(normalized, page.id, machineId, planId) });
      }
    }
    let updated = 0;
    let failed = 0;
    for (let i = 0; i < targets.length; i += 8) {
      const batch = targets.slice(i, i + 8);
      const results = await Promise.all(batch.map(async target => {
        try { return await patchServiceLink(target.page, target.propertyName, target.link); }
        catch (error) { failed++; console.warn('Service link update failed:', target.page.id, error.message); return false; }
      }));
      updated += results.filter(Boolean).length;
    }
    context.linkSyncState.baseUrl = normalized;
    context.linkSyncState.at = Date.now();
    console.log('Service links synced:', updated, 'updated,', failed, 'failed');
    return { ok: true, updated, failed, total: targets.length, baseUrl: normalized };
  })().finally(() => { context.linkSyncState.inFlight = null; });
  return context.linkSyncState.inFlight;
}

function json(response, status, body, extraHeaders = {}) {
  if(status>=400&&typeof body?.error==='string'&&/^Notion API \d+:/i.test(body.error)){body={...body,technicalDetails:body.error,error:body.error.startsWith('Notion API 400:')?'Notion sahə xətası: '+body.error.slice('Notion API 400:'.length).trim():'Notion əməliyyatı alınmadı. HTTP '+(body.error.match(/Notion API (\d+)/)?.[1]||status)+'. Yenidən cəhd edin.'};}

  if(response.__accountRequest&&status<300)context.accounts.user(response.__accountRequest);
  if(response.__account&&status<300&&response.__account.disabled)throw context.accessError('Giriş qeyri-aktivdir',401);
  if(response.__account&&status<300&&response.__accountScope)body=context.projectAccount(response.__account,response.__accountScope,body);
  response.writeHead(status, {
    'Content-Type': 'application/json; charset=utf-8',
    'Access-Control-Allow-Origin': context.CORS_ORIGIN,
    'Access-Control-Allow-Headers': 'Content-Type, If-None-Match, Authorization',
    'Cache-Control': 'no-store',
    ...context.SECURITY_HEADERS,
    ...extraHeaders
  });
  response.end(JSON.stringify(body));
  if(status>=200&&status<300&&body?.ok!==false&&response.__realtimeScopes?.length)context.realtime.invalidate(response.__realtimeScopes);
}

function file(response, filename, contentType = 'text/html; charset=utf-8', cacheControl = 'no-store', request = null) {
  const encoded=contentType.startsWith('text/html')?context.uiAssets.encodeHtml(filename,request?.headers||{}):{body:context.fs.readFileSync(filename),headers:{}};
  response.writeHead(200, { 'Content-Type': contentType, 'Cache-Control': cacheControl, ...context.SECURITY_HEADERS, ...encoded.headers });
  response.end(encoded.body);
}

function requestError(message, statusCode) {
  const error = new Error(message);
  error.statusCode = statusCode;
  return error;
}

function readBody(request) {
  if(request.__accountBody!==undefined)return Promise.resolve(request.__accountBody);
  return new Promise((resolve, reject) => {
    let body = '';
    let bytes = 0;
    let settled = false;
    request.on('data', chunk => {
      if (settled) return;
      bytes += Buffer.byteLength(chunk);
      if (bytes > (String(request.url||'').split('?')[0]==='/api/image-upload'?8*1024*1024:100000)) {
        settled = true;
        reject(requestError('Sorğunun ölçüsü icazə verilən limiti keçir', 413));
        request.resume();
        return;
      }
      body += chunk;
    });
    request.on('end', () => {
      if (settled) return;
      try { resolve(JSON.parse(body || '{}')); }
      catch { reject(requestError('Etibarsızdır JSON sorğuda', 400)); }
    });
    request.on('error', error => { if (!settled) reject(error); });
  });
}

function enforceAiRateLimit() {
  const now = Date.now();
  while (context.aiRequestTimes.length && now - context.aiRequestTimes[0] >= context.AI_RATE_WINDOW_MS) context.aiRequestTimes.shift();
  if (context.aiRequestTimes.length >= context.AI_REQUESTS_PER_MINUTE) {
    const error = requestError('Çoxlu sorğular AI. Bir dəqiqə sonra yenidən cəhd edin.', 429);
    error.retryAfter = Math.max(1, Math.ceil((context.AI_RATE_WINDOW_MS - (now - context.aiRequestTimes[0])) / 1000));
    throw error;
  }
  context.aiRequestTimes.push(now);
}

async function ensureLayoutColorSchema(kind) {
  if (context.layoutColorSchemaReady.has(kind)) return;
  if (context.layoutColorSchemaFlights.has(kind)) return context.layoutColorSchemaFlights.get(kind);
  const config = kind === 'plan'
    ? { database: context.PLAN_DB, dataSource: context.PLAN_DS }
    : { database: context.MAKINA_DB, dataSource: context.MAKINA_DS };
  const flight = (async () => {
    let endpoint = config.dataSource ? '/data_sources/' + encodeURIComponent(config.dataSource) : '';
    let version = context.NOTION_VERSION;
    let schema;
    try {
      if (!endpoint) throw new Error('Data source is not configured');
      schema = await context.notion(endpoint, { method: 'GET' });
    } catch (error) {
      if (!config.database || (endpoint && !/Notion API (400|404):/.test(error.message || ''))) throw error;
      endpoint = '/databases/' + encodeURIComponent(config.database);
      version = '2022-06-28';
      schema = await context.notion(endpoint, { method: 'GET' }, version);
    }
    const existing = schema.properties?.Color;
    if (existing && existing.type !== 'select') {
      throw new Error('Notion sahəsi Color seçim siyahısı deyil; mövcud sahəni dəyişmədim.');
    }
    const existingOptions = (existing?.select?.options || []).map(option => ({
      name: option.name,
      ...(option.color ? { color: option.color } : {})
    }));
    const names = new Set(existingOptions.map(option => option.name));
    const missing = context.LAYOUT_COLORS.filter(option => !names.has(option.name));
    if (!existing || missing.length) {
      const options = [...existingOptions, ...missing.map(({ name, color }) => ({ name, color }))];
      await context.notion(endpoint, {
        method: 'PATCH',
        body: JSON.stringify({ properties: { Color: { select: { options } } } })
      }, version);
    }
    context.layoutColorSchemaReady.add(kind);
  })().finally(() => context.layoutColorSchemaFlights.delete(kind));
  context.layoutColorSchemaFlights.set(kind, flight);
  return flight;
}

function updateLayoutCaches(id, values) {
  const page = context.rawCache.plans.get(id) || context.rawCache.machines.get(id);
  if (page) {
    page.properties = page.properties || {};
    for (const [name, value] of Object.entries({ X: values.x, Y: values.y, Eni: values.width, Uzunluğu: values.height })) {
      page.properties[name] = { ...(page.properties[name] || {}), type: 'number', number: value };
    }
    if (Object.prototype.hasOwnProperty.call(values, 'parentId')) page.properties['Parent Plan'] = { type: 'relation', relation: values.parentId ? [{ id: values.parentId }] : [] };
    if (Object.prototype.hasOwnProperty.call(values, 'planId')) page.properties.Plan = { type: 'relation', relation: values.planId ? [{ id: values.planId }] : [] };
    if (Object.prototype.hasOwnProperty.call(values, 'color')) page.properties.Color = { type: 'select', select: values.color ? { name: values.color } : null };
    page.last_edited_time = new Date().toISOString();
  }
  if (context.snapshotCache) {
    for (const item of [...(context.snapshotCache.plans || []), ...(context.snapshotCache.equipment || [])]) {
      if (item.id === id) Object.assign(item, values);
    }
    context.snapshotCache.fetchedAt = new Date().toISOString();
  }
  // Keep Railway's mounted raw snapshot in step with a successful Notion PATCH;
  // otherwise a process restart can restore the old coordinates from disk.
  context.saveRawSnapshotCache();
}

async function saveLayoutColor(body) {
  const id = context.cleanId(String(body.id || '').trim());
  const color = String(body.color || '').trim();
  if (!id) throw Object.assign(new Error('Element ID-si tələb olunur'), { statusCode: 400 });
  if (color && !context.LAYOUT_COLORS.some(option => option.name === color)) {
    throw Object.assign(new Error('Rəng siyahıdan seçilməlidir'), { statusCode: 400 });
  }
  const kind = context.rawCache.plans.has(id) ? 'plan' : context.rawCache.machines.has(id) ? 'equipment' : '';
  if (!kind) throw Object.assign(new Error('Plan və ya avadanlıq tapılmadı'), { statusCode: 404 });
  await ensureLayoutColorSchema(kind === 'plan' ? 'plan' : 'equipment');
  await context.notion('/pages/' + encodeURIComponent(id), {
    method: 'PATCH',
    body: JSON.stringify({ properties: { Color: color ? { select: { name: color } } : { select: null } } })
  });
  const values = { color };
  updateLayoutCaches(id, values);
  context.realtime.invalidate(['equipment']);
  console.log('Layout color saved:', id, color || '(automatic)');
  return { ok: true, id, color, savedAt: new Date().toISOString() };
}

async function saveLayout(body) {
  const id = String(body.id || '').trim();
  const values = { x: Number(body.x), y: Number(body.y), width: Number(body.width), height: Number(body.height) };
  if (body.planId !== undefined) values.planId = body.planId ? context.cleanId(String(body.planId)) : null;
  if (!id || ['x', 'y', 'width', 'height'].some(key => !Number.isFinite(values[key]))) {
    throw new Error('Lazımdır id, x, y, width və height');
  }
  const properties = {
    X: { number: values.x },
    Y: { number: values.y },
    Eni: { number: values.width },
    Uzunluğu: { number: values.height }
  };
  if (body.parentId !== undefined) {
    const parentId = body.parentId ? context.cleanId(String(body.parentId)) : '';
    if (parentId === id) throw new Error('Plan öz daxilində yerləşdirilə bilməz');
    properties['Parent Plan'] = { relation: parentId ? [{ id: parentId }] : [] };
    values.parentId = parentId || null;
  }
  if (body.planId !== undefined) properties.Plan = { relation: values.planId ? [{ id: values.planId }] : [] };
  const writtenPage = await context.notion('/pages/' + encodeURIComponent(id), {
    method: 'PATCH',
    body: JSON.stringify({ properties })
  });
  const savedProperties = writtenPage?.properties || {};
  const confirmed = {
    x: savedProperties.X?.number,
    y: savedProperties.Y?.number,
    width: savedProperties.Eni?.number,
    height: savedProperties['Uzunluğu']?.number
  };
  const mismatches = Object.entries({ x: values.x, y: values.y, width: values.width, height: values.height })
    .filter(([key, expected]) => !Number.isFinite(confirmed[key]) || Math.abs(confirmed[key] - expected) > 0.001);
  if (mismatches.length) {
    const actual = mismatches.map(([key]) => key + '=' + String(confirmed[key])).join(', ');
    const expected = mismatches.map(([key, value]) => key + '=' + String(value)).join(', ');
    throw Object.assign(new Error('Notion координаттарды тастыкламады. Сақталуы керек: ' + expected + '; Notion қайтарды: ' + actual), {
      statusCode: 502,
      code: 'NOTION_LAYOUT_SAVE_UNCONFIRMED'
    });
  }
  updateLayoutCaches(id, values);
  context.realtime.invalidate(['equipment']);
  console.log('Layout saved and confirmed by Notion:', id, confirmed);
  return { ok: true, id, values, confirmedFromNotion: confirmed, savedAt: new Date().toISOString() };
}

function notionDateStart(value) {
  const text = String(value ?? '').trim();
  if (!text) return '';
  return /^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}$/.test(text) ? text + ':00' : text;
}

function personalCalendarDate(body,previous={}) {
 const invalid=message=>{throw Object.assign(new Error(message),{statusCode:400,code:'INVALID_CALENDAR_RANGE'});};
 if(body.date===undefined){if(body.dateEnd!==undefined)invalid('Sonu ilə birlikdə başlanğıcı da göstərin');return undefined;}
 const start=notionDateStart(body.date);
 if(!start){if(body.dateEnd)invalid('Bitirmək üçün başlanğıc lazımdır');return null;}
 let end=body.dateEnd===undefined?null:body.dateEnd?notionDateStart(body.dateEnd):null;
 if(body.dateEnd===undefined&&start.includes('T')&&previous.date&&previous.dateEnd){const duration=Date.parse(previous.dateEnd)-Date.parse(previous.date);if(duration>0&&duration<=7*86400000&&Number.isFinite(Date.parse(start)))end=new Date(Date.parse(start)+duration).toISOString();}
 if(end){if(!start.includes('T')||!end.includes('T')||!Number.isFinite(Date.parse(start))||!Number.isFinite(Date.parse(end))||Date.parse(end)<=Date.parse(start)||Date.parse(end)-Date.parse(start)>7*86400000)invalid('Təqvim intervalı: başladıqdan sonra bitir, 7 gündən çox olmayaraq');}
 return {start,end};
}

function buildTaskProperties(body, config, includeMachine = false) {
  const properties = {};
  const textBlocks = value => { const content = String(value ?? '').trim().slice(0, 2000); return content ? [{ type: 'text', text: { content } }] : []; };
  if (body.title !== undefined) properties[config.title] = { title: [{ type: 'text', text: { content: String(body.title).trim().slice(0, 2000) || 'Tapşırıq' } }] };
  if (body.process !== undefined && String(body.process).trim()) properties[config.process] = { status: { name: String(body.process).trim() } };
  if (body.priority !== undefined && String(body.priority).trim()) properties[config.priority] = { status: { name: String(body.priority).trim() } };
  if (body.date !== undefined) properties[config.date] = { date: personalCalendarDate(body) };
  if (body.assigneeId !== undefined) properties[config.assignee] = { people: body.assigneeId ? [{ object: 'user', id: String(body.assigneeId) }] : [] };
  if (body.tapsirildi !== undefined) properties[config.tapsirildi] = { multi_select: (Array.isArray(body.tapsirildi) ? body.tapsirildi : []).filter(Boolean).map(name => ({ name: String(name) })) };
  if (body.gtd !== undefined && config.gtdProperty) properties[config.gtdProperty] = body.gtd ? { status: { name: String(body.gtd).trim() } } : { status: null };
  if (body.workType !== undefined && config.workTypeProperty) properties[config.workTypeProperty] = body.workType ? { status: { name: String(body.workType).trim() } } : { status: null };
  if (body.isciTag !== undefined && config.isciTagProperty) properties[config.isciTagProperty] = body.isciTag ? { select: { name: String(body.isciTag).trim() } } : { select: null };
  if (body.tag !== undefined && config.tagProperty) properties[config.tagProperty] = body.tag ? { select: { name: String(body.tag).trim() } } : { select: null };
  if (body.doneWork !== undefined) properties[config.doneWork] = config.doneWorkType === 'title' ? { title: textBlocks(body.doneWork) } : { rich_text: textBlocks(body.doneWork) };
  if (body.completed !== undefined) properties[config.complete] = { checkbox: Boolean(body.completed) };
  if (includeMachine && body.machineId) properties[config.relation] = { relation: [{ id: String(body.machineId) }] };
  if (body.planId) properties[config.planRelation] = { relation: [{ id: String(body.planId) }] };
  return properties;
}

function databaseParent(databaseId, dataSourceId) {
  return databaseId ? { database_id: databaseId } : { data_source_id: dataSourceId };
}

function createText(value) {
  const content=String(value??'').trim().slice(0,2000);
  return content ? [{type:'text',text:{content}}] : [];
}

function createSelect(name,value){const clean=String(value||'').trim();return clean?{[name]:{select:{name:clean}}}:{};}

function createNumber(name,value,fallback){const n=Number(value);return {[name]:{number:Number.isFinite(n)?n:fallback}};}

function planCreateProperties(body){
  const name=String(body.name||'').trim(); if(!name) throw new Error('Plan adı tələb olunur');
  return {Plan:{title:createText(name)},...createSelect('Tip',body.type||'Zona'),...createSelect('Status',body.status||'Aktiv'),...createNumber('X',body.x,0),...createNumber('Y',body.y,0),...createNumber('Eni',body.width,200),...createNumber('Uzunluğu',body.height,200),...createNumber('Scale',body.scale,1),...(body.object?{Obyekt:{rich_text:createText(body.object)}}:{}),...(body.parentId?{'Parent Plan':{relation:[{id:context.cleanId(String(body.parentId))}]}}:{})};
}

function equipmentCreateProperties(body){
  const name=String(body.name||'').trim(),planId=context.cleanId(String(body.planId||'').trim()); if(!name||!planId) throw new Error('Avadanlığın adı və planı tələb olunur');
  return {Makina:{title:createText(name)},...createSelect('Tip',body.type||'Maşın'),...createSelect('Status',body.status||'İşləyir'),...createNumber('X',body.x,0),...createNumber('Y',body.y,0),...createNumber('Eni',body.width,200),...createNumber('Uzunluğu',body.height,200),...createNumber('Dönmə bucağı',body.rotation,0),Plan:{relation:[{id:planId}]},...(body.zone?{Zona:{rich_text:createText(body.zone)}}:{})};
}

async function createPlan(body){
  if(!context.PLAN_DB&&!context.PLAN_DS) throw new Error('Verilənlər bazası konfiqurasiya edilməyib Plan');
  const page=await context.notion('/pages',{method:'POST',body:JSON.stringify({parent:databaseParent(context.PLAN_DB,context.PLAN_DS),properties:planCreateProperties(body)})}); context.snapshotCache=null;
  return {ok:true,id:page.id,url:page.url||'',savedAt:new Date().toISOString()};
}

async function createEquipment(body){
  if(!context.MAKINA_DB&&!context.MAKINA_DS) throw new Error('Verilənlər bazası konfiqurasiya edilməyib Makina');
  const page=await context.notion('/pages',{method:'POST',body:JSON.stringify({parent:databaseParent(context.MAKINA_DB,context.MAKINA_DS),properties:equipmentCreateProperties(body)})}); context.snapshotCache=null;
  return {ok:true,id:page.id,url:page.url||'',savedAt:new Date().toISOString()};
}

function validateTaskEstimate(body){if(body.estimateMinutes!==undefined&&body.estimateMinutes!==null&&(!Number.isInteger(body.estimateMinutes)||body.estimateMinutes<1||body.estimateMinutes>43200))throw Object.assign(new Error('Vaxt təxmini: 1-dən 43200 dəqiqəyə qədər tam ədəd və ya boş dəyər'),{statusCode:400,code:'INVALID_ESTIMATE'});}

async function persistTaskEstimate(body,id,created=false){if(body.estimateMinutes===undefined&&body.parentId===undefined&&body.machineId===undefined&&body.planId===undefined)return;try{if(body.machineId!==undefined||body.planId!==undefined)context.taskManagement.update({type:'context',id,...(body.machineId!==undefined?{machineId:body.machineId}:{}),...(body.planId!==undefined?{planId:body.planId}:{})});if(body.estimateMinutes!==undefined){const sourceKey=body.sourceKey||'personal';await context.taskEstimates.save(sourceKey,id,body.estimateMinutes);context.taskManagement.update({type:'estimate',id,minutes:body.estimateMinutes});}else if(body.parentId!==undefined||body.machineId!==undefined||body.planId!==undefined){const saved=context.taskManagement.getEstimate(id);if(saved!==null){const sourceKey=body.sourceKey||'personal',page=await context.notion('/pages/'+encodeURIComponent(id),{method:'GET'});if(context.taskEstimates.read(page)===null)await context.taskEstimates.save(sourceKey,id,saved);}}if(body.parentId!==undefined&&body.sourceKey!=='personal')context.taskManagement.update({type:'parent',id,parentId:body.parentId})}catch(error){context.snapshotCache=null;context.invalidatePersonalTasks();context.taskCache.clear();if(created){try{await context.notion('/pages/'+encodeURIComponent(id),{method:'PATCH',body:JSON.stringify({archived:true})})}catch(rollback){error.code='TASK_CREATE_PARTIAL';error.createdTaskId=id;error.message='Tapşırıq yaradıldı ('+id+'), lakin qiymətləndirmə yadda saxlanmadı və yaradılması ləğv edilə bilmədi. Yaradıcılığı təkrarlamayın; mövcud tapşırığı açın. '+error.message;throw error}}else error.message='Tapşırıq sahələri saxlanılır, lakin vaxt təxmini qeyd olunmur. Yenidən saxla. '+error.message;throw error}}

function withTaskEstimates(data){const metadata=context.taskManagement.state.tasks,visible=value=>!metadata[value.id]?.deleted,task=value=>({...value,parentId:value.sourceKey&&Object.prototype.hasOwnProperty.call(metadata[value.id]||{},'parentId')?metadata[value.id].parentId:(value.parentId||metadata[value.id]?.parentId||''),estimateMinutes:value.estimateMinutes??context.taskManagement.getEstimate(value.id)}),item=value=>({...value,...(Array.isArray(value.tasks)?{tasks:value.tasks.filter(visible).map(task)}:{})});return require('./pomodoro-rollup').attach({...data,historyNow:context.taskHistory.now(),...(Array.isArray(data.tasks)?{tasks:data.tasks.filter(visible).map(task)}:{}),...(Array.isArray(data.plans)?{plans:data.plans.map(item)}:{}),...(Array.isArray(data.equipment)?{equipment:data.equipment.map(item)}:{}),...(Array.isArray(data.pomodoroTasks)?{pomodoroTasks:data.pomodoroTasks.filter(visible).map(task)}:{})});}

async function saveTask(body, baseUrl = '') {
  validateTaskEstimate(body);
  const id = String(body.id || '').trim();
  const sourceKey = String(body.sourceKey || 'todo');
  if (!id) throw new Error('Müəyyən edilməyib ID tapşırıqları');
  const config = context.taskConfig(sourceKey);
  const properties = await context.taskStatusOptions.properties(body,sourceKey,buildTaskProperties(body, config, Boolean(body.machineId)));
  const appLink = context.taskAppLink(baseUrl, id, body.machineId, body.planId);
  if (appLink) properties[config.linkProperty || context.TASK_LINK_PROPERTY_DEFAULT] = { url: appLink };
  await context.notion('/pages/' + encodeURIComponent(id), { method: 'PATCH', body: JSON.stringify({ properties }) });
  const sessionTitleSync = body.title !== undefined
    ? await context.syncTaskSessionTitle(id, sourceKey, String(body.title || '').trim())
    : undefined;
  await persistTaskEstimate({...body,sourceKey},id);
  if(body.completed!==undefined||body.process!==undefined)context.recordCompletion(id,body.completed!==undefined?body.completed===true:context.taskHistory.done({process:body.process}));
  if (body.machineId) context.taskCache.delete(String(body.machineId));
  context.snapshotCache = null;
  console.log('Task saved:', id, sourceKey);
  return { ok: true, id, sourceKey,...(sessionTitleSync?{sessionTitleSync}:{}),completedAt:context.taskManagement.state.tasks[id]?.completedAt||null, estimateMinutes:context.taskManagement.getEstimate(id), savedAt: new Date().toISOString() };
}

async function createTask(body, baseUrl = '') {
 if(body.autosaveOperationId)return context.guardedAutosaveCreate('equipment',body,b=>createTask({...b,autosaveOperationId:undefined},baseUrl));
  if(body.parentId){await context.notion('/pages/'+encodeURIComponent(String(body.parentId)),{method:'GET'});body={...body,sourceKey:'todo'};}
  validateTaskEstimate(body);
  const sourceKey = String(body.sourceKey || 'todo');
  const machineId = String(body.machineId || '').trim();
  const planId = String(body.planId || '').trim();
  const titleValue = String(body.title || '').trim();
  if ((!machineId && !planId) || !titleValue) throw new Error('Tapşırığın adını və avadanlıq və ya planı göstərin');
  const config = context.taskConfig(sourceKey);
  const page = await context.notion('/pages', { method: 'POST', body: JSON.stringify({ parent: databaseParent(config.database, config.dataSourceId), properties: await context.taskStatusOptions.properties(body,sourceKey,buildTaskProperties({ ...body, machineId, planId, title: titleValue, completed: false }, config, Boolean(machineId)),{creating:true}) }) });
  const appLink = context.taskAppLink(baseUrl, page.id, machineId, planId);
  if (appLink) { try { await patchServiceLink(page, config.linkProperty || context.TASK_LINK_PROPERTY_DEFAULT, appLink); } catch (error) { console.warn('Task app link update failed:', page.id, error.message); } }
  await persistTaskEstimate({...body,sourceKey},page.id,true);
  if (machineId) context.taskCache.delete(machineId);
  context.snapshotCache = null;
  return { ok: true, id: page.id, estimateMinutes:context.taskManagement.getEstimate(page.id), url: page.url || '', serviceUrl: context.serviceLink(baseUrl, 'task', page.id, machineId ? { machine: machineId } : { plan: planId }), sourceKey, savedAt: new Date().toISOString() };
}

async function archiveNotionPage(id) {
  const endpoint = '/pages/' + encodeURIComponent(id);
  try {
    return await context.notion(endpoint, { method: 'PATCH', body: JSON.stringify({ archived: true }) });
  } catch (error) {
    if (error.notionStatus !== 400 || !/can't edit block that is archived/i.test(error.message || '')) throw error;
    let page;
    try { page = await context.notion(endpoint, { method: 'GET' }); } catch { throw error; }
    if (!page || page.object !== 'page' || page.id?.replace(/-/g,'') !== id.replace(/-/g,'') || !(page.archived === true || page.in_trash === true)) throw error;
    context.observeWrittenPage(endpoint, page);
    return page;
  }
}

async function archiveElement(body) {
  const id = String(body.id || '').trim();
  const kind = body.kind === 'plan' ? 'plan' : 'equipment';
  if (!id) throw new Error('Müəyyən edilməyib ID elementi');
  await archiveNotionPage(id);
  if (kind === 'plan') context.rawCache.plans.delete(id); else context.rawCache.machines.delete(id);
  context.snapshotCache = null;
  return { ok: true, id, kind, deleted: true, savedAt: new Date().toISOString() };
}

async function deleteTask(body) {
  const id = String(body.id || '').trim();
  if (!id) throw new Error('Müəyyən edilməyib ID tapşırıqları');
  await archiveNotionPage(id);
  if (body.machineId) context.taskCache.delete(String(body.machineId));
  for (const pages of context.rawCache.tasks.values()) pages.delete(id);
  context.taskManagement.update({type:'archive',id});context.saveRawSnapshotCache();context.snapshotCache = null;
  return { ok: true, id, deleted: true, savedAt: new Date().toISOString() };
}
return { isLocalBaseUrl, patchServiceLink, syncServiceLinks, json, file, requestError, readBody, enforceAiRateLimit, ensureLayoutColorSchema, updateLayoutCaches, saveLayoutColor, saveLayout, notionDateStart, personalCalendarDate, buildTaskProperties, databaseParent, createText, createSelect, createNumber, planCreateProperties, equipmentCreateProperties, createPlan, createEquipment, validateTaskEstimate, persistTaskEstimate, withTaskEstimates, saveTask, createTask, archiveNotionPage, archiveElement, deleteTask };
};
