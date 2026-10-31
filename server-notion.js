// Server domain module. Dependencies are live bindings supplied by server.js.
'use strict';
module.exports = function serverNotion(context) {
function loadDotEnv(file) {
  if (!context.fs.existsSync(file)) return;
  for (const raw of context.fs.readFileSync(file, 'utf8').split(/\r?\n/)) {
    const line = raw.trim();
    if (!line || line.startsWith('#')) continue;
    const i = line.indexOf('=');
    if (i < 0) continue;
    const key = line.slice(0, i).trim();
    const value = line.slice(i + 1).trim().replace(/^['"]|['"]$/g, '');
    if (!process.env[key]) process.env[key] = value;
  }
}

function cleanId(value) {
  if (!value) return '';
  const match = value.match(/[0-9a-f]{32}/i);
  return match ? match[0] : value.replace(/[^0-9a-f-]/gi, '');
}

function checkConfig() {
  const missing = [];
  if (!context.TOKEN) missing.push('NOTION_TOKEN');
  if (!context.PLAN_DB && !context.PLAN_DS) missing.push('PLAN_DATABASE_ID or PLAN_DATA_SOURCE_ID');
  if (!context.MAKINA_DB && !context.MAKINA_DS) missing.push('MAKINA_DATABASE_ID or MAKINA_DATA_SOURCE_ID');
  if (missing.length) throw new Error('Dəyişənlər doldurulmayıb: ' + missing.join(', '));
}

async function notion(endpoint, options = {}, apiVersion = context.NOTION_VERSION) {
  checkConfig();
  if(endpoint.endsWith('/query'))context.queryMetrics.notionQueries++;
  else if(['POST','PATCH','DELETE'].includes(options.method))context.queryMetrics.notionWrites++;
  const uploadOptions=context.TOKEN==='native'?options:context.prepareNotionUpload('https://api.notion.com/v1'+endpoint,options);
  const readStarted=Date.now();
  const response = await context.notionRate.request('https://api.notion.com/v1' + endpoint, {
    ...uploadOptions,
    headers: {
      Authorization: 'Bearer ' + context.TOKEN,
      'Notion-Version': apiVersion,
      'Content-Type': 'application/json',
      ...(uploadOptions.headers || {})
    }
  });
  const text = await response.text();
  let body;
  try { body = JSON.parse(text); } catch { body = { message: text }; }
  const remoteDate=Date.parse(response.headers?.get?.('date')||'');
  if(body&&typeof body==='object'&&Number.isFinite(remoteDate))Object.defineProperty(body,'__readBarrier',{value:new Date(remoteDate-Math.max(0,Date.now()-readStarted)).toISOString()});
  if (!response.ok) {
    const error = new Error('Notion API ' + response.status + ': ' + (body.message || text));
    error.notionStatus = response.status;
    error.notionCode = body.code || '';
    throw error;
  }
  if(response.ok&&['PATCH','POST','DELETE'].includes(options.method))context.observeWrittenPage(endpoint,body);
  return body;
}

function commentText(comment) {
  return (comment.rich_text || []).map(part => part.plain_text || part.text?.content || '').join('');
}

function mapComment(comment) {
  const author = comment.created_by || {};
  const rawText = commentText(comment);
  // Only integration-authored comments use ADIB's [name] prefix.
  // A person's native Notion comment must retain its exact text.
  const authored = author.type === 'bot' ? rawText.match(/^\[([^\]]{1,120})\]\s([\s\S]*)$/) : null;
  return {
    id: comment.id,
    text: authored ? authored[2] : rawText,
    createdAt: comment.created_time || '',
    authorId: author.id || '',
    discussionId: comment.discussion_id || '',
    authorName: authored ? authored[1] : (author.name || comment.display_name?.resolved_name || 'İstifadəçi Notion'),
    attachments: (comment.attachments||[]).filter(a=>a.category==='image').map(a=>({category:'image',url:a.file?.url||a.file?.file?.url||'',expiryTime:a.file?.expiry_time||'',name:a.file?.name||'Şəkil'})).filter(a=>/^https:\/\//.test(a.url))
  };
}

async function resolveCommentAuthor(comment) {
  const mapped = mapComment(comment);
  // Do not replace the service sender with the integration bot's profile.
  if (!mapped.authorId || (comment.created_by?.type === 'bot' && /^\[([^\]]{1,120})\]\s/.test(commentText(comment)))) return mapped;
  if (comment.created_by?.name) return mapped;
  try {
    const cached=await context.authorReads.read(mapped.authorId,{ttlMs:1800000,load:()=>notion('/users/'+encodeURIComponent(mapped.authorId),{method:'GET'})});
    const user=cached.value;
    mapped.authorName = user.name || mapped.authorName;
  } catch (error) {
    console.warn('Comment author lookup failed:', mapped.authorId, error.message);
  }
  return mapped;
}

async function cachedTaskComments(pageId,foreground=false){
 return context.commentReads.read(context.accountKey(pageId),{ttlMs:foreground?30000:300000,load:async()=>{
  const items=[];let cursor=null;const seen=new Set();
  do{const result=await notion('/comments?block_id='+encodeURIComponent(pageId)+(cursor?'&start_cursor='+encodeURIComponent(cursor):''),{method:'GET'});
   items.push(...(result.results||[]));cursor=result.has_more?result.next_cursor:null;
   if(result.has_more&&!cursor)throw Error('Missing comments pagination cursor');
   if(cursor&&seen.has(cursor))throw Error('Repeated comments cursor');if(cursor)seen.add(cursor);
  }while(cursor);
  return (await Promise.all(items.map(resolveCommentAuthor))).sort((a,b)=>String(a.createdAt).localeCompare(String(b.createdAt)));
 }});
}

async function listTaskComments(body){
 const pageId=cleanId(String(body.id||'').trim());if(!pageId)throw new Error('Müəyyən edilməyib ID tapşırıq səhifələri');
 const result=await cachedTaskComments(pageId,true);return {ok:true,id:pageId,comments:result.value,...(result.stale?{stale:true,error:result.error}: {})};
}

async function listEmployeeChatComments(pageId,discussionId){
 const id=cleanId(String(pageId||'')),thread=String(discussionId||'');if(!id||!thread)return[];
 const result=await cachedTaskComments(id,true);return result.value.filter(comment=>comment.discussionId===thread);
}

async function createEmployeeChatComment({pageId,discussionId,user,text,attachments=[]}){
 const id=cleanId(String(pageId||'')),thread=String(discussionId||''),value=String(text||'').trim(),notionAttachments=await validatedCommentAttachments(attachments);
 if(!id||(!value&&!notionAttachments.length)||value.length>1850)throw Object.assign(Error('Personal söhbəti üçün səhifə, mətn və ya şəkil tələb olunur; mətn 1850 simvoldan qısa olmalıdır'),{statusCode:400});
 const authorName=String(user?.name||'Əməkdaş').replace(/[\[\]]/g,'').slice(0,120)||'Əməkdaş',storedText='['+authorName+'] '+(value||'📷 Şəkil');
 const payload={rich_text:[{type:'text',text:{content:storedText}}],...(notionAttachments.length?{attachments:notionAttachments}:{})};if(thread)payload.discussion_id=thread;else payload.parent={page_id:id};
 const raw=await notion('/comments',{method:'POST',body:JSON.stringify(payload)});let mapped=await resolveCommentAuthor(raw),nextThread=String(raw.discussion_id||thread||'');
 if(!nextThread){const cached=await cachedTaskComments(id,true);nextThread=cached.value.find(comment=>comment.id===raw.id)?.discussionId||'';}
 if(!nextThread)throw Object.assign(Error('Notion şərh mövzusunun identifikatorini qaytarmadı'),{statusCode:502});
 mapped.discussionId=nextThread;context.commentReads.append(context.accountKey(id),mapped);return {discussionId:nextThread,comment:mapped};
}

async function requestedCommentAuthor(body) {
  const requestedId = String(body.authorId || '').trim();
  if (requestedId) {
    try {
      const user = (await context.notionUsers()).find(item => item.id === requestedId);
      if (user) return user.name || user.email || 'Tətbiq istifadəçisi';
    } catch (error) {
      console.warn('Comment profile lookup failed:', error.message);
    }
  }
  return String(body.authorName || 'ilqar mamedov').trim().slice(0, 120) || 'ilqar mamedov';
}

async function addTaskComment(body) {
  const pageId = cleanId(String(body.id || '').trim());
  const text = String(body.text || '').trim().slice(0, 1850);
  const attachments=await validatedCommentAttachments(body.attachments);
  if (!pageId || (!text&&!attachments.length)) throw new Error('Lazımdır ID tapşırıqlar və mətn və ya şəkil');
  const authorName = body.__account?.name || await requestedCommentAuthor(body);
  const storedText = '[' + authorName.replace(/[\\[\\]]/g, '') + '] ' + (text||'Şəkil');
  const comment = await notion('/comments', {
    method: 'POST',
    body: JSON.stringify({
      parent: { page_id: pageId },
      rich_text: [{ type: 'text', text: { content: storedText } }],...(attachments.length?{attachments}:{})
    })
  });
  const mapped=await resolveCommentAuthor(comment);context.commentReads.append(context.accountKey(pageId),mapped);
  return {ok:true,comment:mapped,savedAt:new Date().toISOString()};
}

function imageUploadId(value){const id=String(value||'');if(!/^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$/i.test(id))throw Object.assign(new Error('Etibarsızdır ID '),{statusCode:400});return id}

async function ensureUploadedImage(value){const id=imageUploadId(value),file=await notion('/file_uploads/'+id,{method:'GET'});if(file.status!=='uploaded'||!['image/jpeg','image/png','image/gif','image/webp'].includes(file.content_type))throw Object.assign(new Error('Şəkil hələ yüklənməyib və ya format dəstəklənmir'),{statusCode:400});return id}

async function validatedCommentAttachments(value){if(value===undefined)return[];if(!Array.isArray(value)||value.length>3)throw Object.assign(new Error('Şərhə 3-ə qədər şəkil əlavə edə bilərsiniz'),{statusCode:400});const result=[];for(const a of value){const id=await ensureUploadedImage(a?.file_upload_id);if(!result.some(x=>x.file_upload_id===id))result.push({type:'file_upload',file_upload_id:id});}return result}

async function uploadTaskImageFile(body){const image=context.validateImage(body.image);if(body.id&&image.bytes.length>200*1024)throw Object.assign(new Error('Tapşırıq şəkli göndərilməzdən əvvəl 200 KB-a qədər sıxılmalıdır'),{statusCode:400});const created=await notion('/file_uploads',{method:'POST',body:JSON.stringify({mode:'single_part',filename:image.name,content_type:image.mime})});const id=imageUploadId(created.id);const sent=await notion('/file_uploads/'+id+'/send',{method:'POST',body:JSON.stringify({__adibMultipart:{name:image.name,mime:image.mime,data:image.data}})});if(sent.status!=='uploaded')throw new Error('Notion yükləməni təsdiq etmədi. Şəkil əlavə edilməyib.');return {ok:true,fileUploadId:id,name:image.name,mime:image.mime};}

function mappedTaskImage(block){const image=block.image||{},url=image.file?.url||image.external?.url||'';return {id:block.id,url:/^https:\/\//.test(url)?url:'',expiryTime:image.file?.expiry_time||'',caption:(image.caption||[]).map(x=>x.plain_text||x.text?.content||'').join('')}}

async function listTaskImages(idValue){const id=cleanId(String(idValue||''));if(!id)throw new Error('Müəyyən edilməyib ID tapşırıqları');return {ok:true,id,images:(await context.listPageBlocks(id)).filter(b=>b.type==='image').map(mappedTaskImage)};}

async function deleteTaskImage(body){const id=cleanId(String(body.id||'')),blockId=cleanId(String(body.blockId||''));if(!id||!blockId)throw Object.assign(new Error('Tapşırıq və şəkil ID-si tələb olunur'),{statusCode:400});const image=(await context.listPageBlocks(id)).find(block=>context.accountKey(block.id)===context.accountKey(blockId)&&block.type==='image');if(!image)throw Object.assign(new Error('Şəkil bu tapşırıqda tapılmadı'),{statusCode:404});await notion('/blocks/'+encodeURIComponent(image.id),{method:'DELETE'});return {ok:true,id,blockId:image.id,deleted:true};}

async function attachTaskImage(body){const id=cleanId(String(body.id||''));if(!id)throw new Error('Əvvəlcə tapşırığı yadda saxlayın');const fileUploadId=await ensureUploadedImage(body.fileUploadId);let result;try{result=await notion('/blocks/'+encodeURIComponent(id)+'/children',{method:'PATCH',body:JSON.stringify({children:[{object:'block',type:'image',image:{type:'file_upload',file_upload:{id:fileUploadId},caption:context.createText(String(body.caption||'').slice(0,500))}}]})})}catch(error){error.message+=' · Qoşma uğur qazana bilər. Lütfən, yenidən göndərməzdən əvvəl şəkillərinizi yeniləyin.';throw error;}const block=result.results?.[0];if(!block?.id)throw new Error('Qoşma təsdiqi yoxdur. Lütfən, yenidən göndərməzdən əvvəl şəkillərinizi yeniləyin.');return {ok:true,id,blockId:block.id,image:mappedTaskImage(block)};}

async function listChatThreads(body) {
  const raw = Array.isArray(body.tasks) ? body.tasks : [];
  const tasks = [...new Map(raw.map(item => {
    const id = cleanId(String(item?.id || '').trim());
    return [id, id ? {
      id,
      title: String(item?.title || 'Tapşırıq').trim().slice(0, 240) || 'Tapşırıq',
      source: String(item?.source || '').trim().slice(0, 80),
      machineName: String(item?.machineName || '').trim().slice(0, 160)
    } : null];
  }).filter(([id, item]) => id && item))].map(([, item]) => item).slice(0, 120);
  const threads = [],errors=[];
  // Keep Notion API pressure low; two concurrent comment requests at a time.
  for (let i = 0; i < tasks.length; i += 2) {
    const batch = await Promise.all(tasks.slice(i, i + 2).map(async task => {
      try {
        const result=await cachedTaskComments(task.id);const comments=result.value;if(result.stale)errors.push({taskId:task.id,error:result.error});
        return comments.length ? { taskId: task.id, title: task.title, source: task.source, machineName: task.machineName, comments } : null;
      } catch (error) {
        errors.push({taskId:task.id,error:error.message});console.warn('Chat thread lookup failed:',task.id,error.message);
        return null;
      }
    }));
    threads.push(...batch.filter(Boolean));
  }
  threads.sort((a, b) => String(b.comments.at(-1)?.createdAt || '').localeCompare(String(a.comments.at(-1)?.createdAt || '')));
  return {ok:true,threads,...(errors.length?{partial:true,errors}: {})};
}

async function listCommentNotifications(body) {
  const rawIds = Array.isArray(body.ids) ? body.ids : String(body.ids || '').split(',');
  const ids = [...new Set(rawIds.map(value => cleanId(String(value || '').trim())).filter(Boolean))].slice(0, 120);
  const comments=[],errors=[];
  for (const taskId of ids) {
    try {
      const result=await cachedTaskComments(taskId);if(result.stale)errors.push({taskId,error:result.error});for(const item of result.value)comments.push({...item,taskId});
    } catch (error) {
      errors.push({taskId,error:error.message});console.warn('Comment notification lookup failed:',taskId,error.message);
    }
  }
  return {ok:true,comments,...(errors.length?{partial:true,errors}: {})};
}

async function taskSourceOptions(key, force=false) {
  const specs = {personal:[context.TASKS_DS,context.TASKS_DB,{tags:'Tag',assignees:'Tapsirildi'}],todo:[context.TODO_DS,context.TODO_DB,{tapsirildi:'Tapsirildi'}],gorulen:[context.GORULEN_DS,context.GORULEN_DB,{tapsirildi:'Tapsirildi'}]};
  const spec=specs[key];if(!spec)throw Object.assign(new Error('Naməlum variant mənbəyi'),{statusCode:400});
  const cached=context.taskOptionCache.get(key);if(!force&&cached&&Date.now()-cached.at<300000)return cached.value;
  if(context.taskOptionFlights.has(key))return context.taskOptionFlights.get(key);
  const job=(async()=>{let schema;if(key!=='personal')schema=await context.taskStatusOptions.schema(key,force);else try{schema=await notion('/data_sources/'+spec[0],{method:'GET'});}catch(e){if(!/Notion API (400|404):/.test(e.message||'')||!spec[1])throw e;schema=await notion('/databases/'+spec[1],{method:'GET'},'2022-06-28');}
    const value={};for(const [field,name] of Object.entries(spec[2])){const prop=schema.properties?.[name];if(!prop||!['multi_select','select'].includes(prop.type))throw new Error('Sahə '+name+' yoxdur və ya seçim siyahısı deyil');value[field]={type:prop.type,options:[...new Set((prop[prop.type]?.options||[]).map(o=>o.name).filter(x=>typeof x==='string'&&x.trim()))]};}
    if(key!=='personal')Object.assign(value,context.taskStatusOptions.fields(schema,key));context.taskOptionCache.set(key,{at:Date.now(),value});return value;})();
  context.taskOptionFlights.set(key,job);try{return await job;}finally{context.taskOptionFlights.delete(key);}
}

async function taskFieldOptions(source='',force=false){
  if(source)return {[source]:await taskSourceOptions(source,force)};
  const result={};for(const key of ['personal','todo','gorulen']){try{result[key]=await taskSourceOptions(key,force);}catch(e){result.errors=result.errors||{};result.errors[key]=e.message;}}return result;
}

async function queryEndpoint(endpoint, apiVersion, query = {}, onPage=null, priority='', resume={}) {
  const rows = [];
  let cursor=resume.nextCursor||undefined;
  do {
    const body = await notion(endpoint, {
      method: 'POST',
      ...(context.TOKEN==='native'&&priority?{headers:{'X-ADIB-Queue':priority}}:{}),
      body: JSON.stringify({ page_size: 100, ...query, ...(cursor ? { start_cursor: cursor } : {}) })
    }, apiVersion);
    rows.push(...(body.results || []));
    if(onPage)onPage(body.results||[],{hasMore:!!body.has_more,nextCursor:body.next_cursor||null,readBarrier:body.__readBarrier||''});
    cursor = body.has_more ? body.next_cursor : null;
  } while (cursor);
  console.log('Notion query:', endpoint, '=>', rows.length, 'rows');
  return rows;
}

async function queryDatabase(databaseId, dataSourceId = '', query = {}, onPage=null, priority='', resume={}) {
  if (!databaseId && !dataSourceId) return [];
  const candidates = [];
  if (dataSourceId) candidates.push({ endpoint: '/data_sources/' + dataSourceId + '/query', version: context.NOTION_VERSION });
  if (databaseId) candidates.push({ endpoint: '/databases/' + databaseId + '/query', version: '2022-06-28' });
  let lastError;
  for (const candidate of candidates) {
    try {
      const rows = await queryEndpoint(candidate.endpoint, candidate.version, query,onPage,priority,resume);
      return rows;
    } catch (error) {
      lastError = error;
      console.error('Notion query failed:', candidate.endpoint, error.message);
      if(resume.nextCursor&&/cursor|pagination/i.test(error.message||''))throw error;
      if(!/Notion API (400|404):/.test(error.message||''))throw error;
    }
  }
  if (lastError) throw lastError;
  return [];
}
return { loadDotEnv, cleanId, checkConfig, notion, commentText, mapComment, resolveCommentAuthor, cachedTaskComments, listTaskComments, listEmployeeChatComments, createEmployeeChatComment, requestedCommentAuthor, addTaskComment, imageUploadId, ensureUploadedImage, validatedCommentAttachments, uploadTaskImageFile, mappedTaskImage, listTaskImages, deleteTaskImage, attachTaskImage, listChatThreads, listCommentNotifications, taskSourceOptions, taskFieldOptions, queryEndpoint, queryDatabase };
};
