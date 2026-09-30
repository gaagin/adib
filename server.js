const http = require('node:http');
const fs = require('node:fs');
const path = require('node:path');
const { URL } = require('node:url');
const crypto = require('node:crypto');

loadDotEnv(path.join(__dirname, '.env'));

const PORT = Number(process.env.PORT || 3000);
const TOKEN = process.env.NOTION_TOKEN || '';
const NOTION_VERSION = process.env.NOTION_VERSION || '2025-09-03';
const PLAN_DB = cleanId(process.env.PLAN_DATABASE_ID);
const MAKINA_DB = cleanId(process.env.MAKINA_DATABASE_ID);
const PLAN_DS = cleanId(process.env.PLAN_DATA_SOURCE_ID);
const MAKINA_DS = cleanId(process.env.MAKINA_DATA_SOURCE_ID);
const TODO_DB = cleanId(process.env.TODO_DATABASE_ID || '0ac3a96e-4687-4194-84cd-de563a12d85a');
const TODO_DS = cleanId(process.env.TODO_DATA_SOURCE_ID || 'b3d991ebc75b47ab8a88d2c723bc56db');
const GORULEN_DB = cleanId(process.env.GORULEN_ISLER_DATABASE_ID || '02f39358-ebb4-4d32-b164-249f39ea2949');
const GORULEN_DS = cleanId(process.env.GORULEN_ISLER_DATA_SOURCE_ID || '3136a23f839c40d3b6387de4d60af7f5');
const TASKS_DB = cleanId(process.env.TASKS_DATABASE_ID || '275e0789-d560-8063-8af3-efcbf4729097');
const TASKS_DS = cleanId(process.env.TASKS_DATA_SOURCE_ID || '275e0789-d560-80ea-9d85-000b5d73a234');
const PERSONAL_CONTAINERS_DB = cleanId(process.env.PERSONAL_CONTAINERS_DATABASE_ID || '73df6f961625407d89c202bc1c3b749c');
const PERSONAL_CONTAINERS_DS = cleanId(process.env.PERSONAL_CONTAINERS_DATA_SOURCE_ID || '78daa90023f0496da65a864f8d63b0c5');
const CORS_ORIGIN = process.env.CORS_ORIGIN || '*';
const GEMINI_API_KEY = String(process.env.GEMINI_API_KEY || '').trim();
const GEMINI_MODEL = String(process.env.GEMINI_MODEL || 'gemini-3.6-flash').trim();
const GEMINI_MODEL_FALLBACK = 'gemini-3.6-flash';
const GEMINI_API_URL = String(process.env.GEMINI_API_URL || 'https://generativelanguage.googleapis.com/v1beta').replace(/\/$/, '');
const GEMINI_TIMEOUT_MS = Math.min(60000, Math.max(5000, Number(process.env.GEMINI_TIMEOUT_MS) || 25000));
const AI_REQUESTS_PER_MINUTE = Math.min(120, Math.max(1, Number(process.env.AI_REQUESTS_PER_MINUTE) || 20));
const AI_RATE_WINDOW_MS = 60000;
const aiRequestTimes = [];
const PUBLIC_APP_URL = String(process.env.PUBLIC_APP_URL || process.env.RAILWAY_PUBLIC_DOMAIN || '').trim();
const LINK_SYNC_TTL_MS = Math.max(60000, Number(process.env.LINK_SYNC_TTL_MS) || 15 * 60 * 1000);
const LINK_PROPERTY_DEFAULT = 'ADIB link';
const linkSyncState = { baseUrl: '', at: 0, inFlight: null };

function loadDotEnv(file) {
  if (!fs.existsSync(file)) return;
  for (const raw of fs.readFileSync(file, 'utf8').split(/\r?\n/)) {
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
  if (!TOKEN) missing.push('NOTION_TOKEN');
  if (!PLAN_DB && !PLAN_DS) missing.push('PLAN_DATABASE_ID or PLAN_DATA_SOURCE_ID');
  if (!MAKINA_DB && !MAKINA_DS) missing.push('MAKINA_DATABASE_ID or MAKINA_DATA_SOURCE_ID');
  if (missing.length) throw new Error('Не заполнены переменные: ' + missing.join(', '));
}

async function notion(endpoint, options = {}, apiVersion = NOTION_VERSION) {
  checkConfig();
  const response = await fetch('https://api.notion.com/v1' + endpoint, {
    ...options,
    headers: {
      Authorization: 'Bearer ' + TOKEN,
      'Notion-Version': apiVersion,
      'Content-Type': 'application/json',
      ...(options.headers || {})
    }
  });
  const text = await response.text();
  let body;
  try { body = JSON.parse(text); } catch { body = { message: text }; }
  if (!response.ok) throw new Error('Notion API ' + response.status + ': ' + (body.message || text));
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
    authorName: authored ? authored[1] : (author.name || comment.display_name?.resolved_name || 'Пользователь Notion')
  };
}

async function resolveCommentAuthor(comment) {
  const mapped = mapComment(comment);
  // Do not replace the service sender with the integration bot's profile.
  if (!mapped.authorId || (comment.created_by?.type === 'bot' && /^\[([^\]]{1,120})\]\s/.test(commentText(comment)))) return mapped;
  if (comment.created_by?.name) return mapped;
  try {
    const user = await notion('/users/' + encodeURIComponent(mapped.authorId), { method: 'GET' });
    mapped.authorName = user.name || mapped.authorName;
  } catch (error) {
    console.warn('Comment author lookup failed:', mapped.authorId, error.message);
  }
  return mapped;
}

async function listTaskComments(body) {
  const pageId = cleanId(String(body.id || '').trim());
  if (!pageId) throw new Error('Не указан ID страницы задачи');
  const result = await notion('/comments?block_id=' + encodeURIComponent(pageId), { method: 'GET' });
  const comments = await Promise.all((result.results || []).map(resolveCommentAuthor));
  return { ok: true, id: pageId, comments };
}

async function requestedCommentAuthor(body) {
  const requestedId = String(body.authorId || '').trim();
  if (requestedId) {
    try {
      const user = (await notionUsers()).find(item => item.id === requestedId);
      if (user) return user.name || user.email || 'Пользователь сервиса';
    } catch (error) {
      console.warn('Comment profile lookup failed:', error.message);
    }
  }
  return String(body.authorName || 'ilqar mamedov').trim().slice(0, 120) || 'ilqar mamedov';
}

async function addTaskComment(body) {
  const pageId = cleanId(String(body.id || '').trim());
  const text = String(body.text || '').trim().slice(0, 1850);
  if (!pageId || !text) throw new Error('Нужны ID страницы задачи и текст комментария');
  const authorName = await requestedCommentAuthor(body);
  const storedText = '[' + authorName.replace(/[\\[\\]]/g, '') + '] ' + text;
  const comment = await notion('/comments', {
    method: 'POST',
    body: JSON.stringify({
      parent: { page_id: pageId },
      rich_text: [{ type: 'text', text: { content: storedText } }]
    })
  });
  return { ok: true, comment: await resolveCommentAuthor(comment), savedAt: new Date().toISOString() };
}

async function listChatThreads(body) {
  const raw = Array.isArray(body.tasks) ? body.tasks : [];
  const tasks = [...new Map(raw.map(item => {
    const id = cleanId(String(item?.id || '').trim());
    return [id, id ? {
      id,
      title: String(item?.title || 'Задача').trim().slice(0, 240) || 'Задача',
      source: String(item?.source || '').trim().slice(0, 80),
      machineName: String(item?.machineName || '').trim().slice(0, 160)
    } : null];
  }).filter(([id, item]) => id && item))].map(([, item]) => item).slice(0, 120);
  const threads = [];
  // Keep Notion API pressure low; two concurrent comment requests at a time.
  for (let i = 0; i < tasks.length; i += 2) {
    const batch = await Promise.all(tasks.slice(i, i + 2).map(async task => {
      try {
        const result = await notion('/comments?block_id=' + encodeURIComponent(task.id), { method: 'GET' });
        const comments = (await Promise.all((result.results || []).map(resolveCommentAuthor))).sort((a, b) => String(a.createdAt).localeCompare(String(b.createdAt)));
        return comments.length ? { taskId: task.id, title: task.title, source: task.source, machineName: task.machineName, comments } : null;
      } catch (error) {
        console.warn('Chat thread lookup failed:', task.id, error.message);
        return null;
      }
    }));
    threads.push(...batch.filter(Boolean));
  }
  threads.sort((a, b) => String(b.comments.at(-1)?.createdAt || '').localeCompare(String(a.comments.at(-1)?.createdAt || '')));
  return { ok: true, threads };
}

async function listCommentNotifications(body) {
  const rawIds = Array.isArray(body.ids) ? body.ids : String(body.ids || '').split(',');
  const ids = [...new Set(rawIds.map(value => cleanId(String(value || '').trim())).filter(Boolean))].slice(0, 120);
  const comments = [];
  for (const taskId of ids) {
    try {
      const result = await notion('/comments?block_id=' + encodeURIComponent(taskId), { method: 'GET' });
      for (const item of result.results || []) comments.push({ ...(await resolveCommentAuthor(item)), taskId });
    } catch (error) {
      console.warn('Comment notification lookup failed:', taskId, error.message);
    }
  }
  return { ok: true, comments };
}

async function queryEndpoint(endpoint, apiVersion, query = {}) {
  const rows = [];
  let cursor;
  do {
    const body = await notion(endpoint, {
      method: 'POST',
      body: JSON.stringify({ page_size: 100, ...query, ...(cursor ? { start_cursor: cursor } : {}) })
    }, apiVersion);
    rows.push(...(body.results || []));
    cursor = body.has_more ? body.next_cursor : null;
  } while (cursor);
  console.log('Notion query:', endpoint, '=>', rows.length, 'rows');
  return rows;
}

async function queryDatabase(databaseId, dataSourceId = '', query = {}) {
  if (!databaseId && !dataSourceId) return [];
  const candidates = [];
  if (dataSourceId) candidates.push({ endpoint: '/data_sources/' + dataSourceId + '/query', version: NOTION_VERSION });
  if (databaseId) candidates.push({ endpoint: '/databases/' + databaseId + '/query', version: '2022-06-28' });
  let lastError;
  for (const candidate of candidates) {
    try {
      const rows = await queryEndpoint(candidate.endpoint, candidate.version, query);
      return rows;
    } catch (error) {
      lastError = error;
      console.error('Notion query failed:', candidate.endpoint, error.message);
    }
  }
  if (lastError) throw lastError;
  return [];
}

function property(page, name) { return page.properties?.[name] || null; }
function title(page, name) { return (property(page, name)?.title || []).map(x => x.plain_text || x.text?.content || '').join('').trim(); }
function richText(page, name) { const value = property(page, name); return (value?.rich_text || value?.title || []).map(x => x.plain_text || x.text?.content || '').join('').trim(); }
function number(page, name) { return property(page, name)?.number ?? null; }
function select(page, name) { const p = property(page, name); return p?.select?.name || p?.status?.name || ''; }
function multiSelect(page, name) { return (property(page, name)?.multi_select || []).map(x => x.name).filter(Boolean); }
function relationIds(page, name) { return (property(page, name)?.relation || []).map(x => x.id); }
function dateStart(page, name) { return property(page, name)?.date?.start || ''; }
function pomodoroModeDuration(mode) { const value=String(mode||''); if(value.includes('Короткий')) return 5; if(value.includes('Длинный')) return 15; return 25; }
function pomodoroModeName(mode,duration) { if(mode==='break') return Number(duration)===15?'Длинный перерыв — 15 мин':'Короткий перерыв — 5 мин'; return Number(duration)===25?'Работа — 25 мин':'Работа — 25 мин'; }
function person(page, name) { const value = (property(page, name)?.people || [])[0]; return { id: value?.id || '', name: value?.name || value?.person?.email || '' }; }
function pageUrl(page) { return page.url || ''; }
function normalizeBaseUrl(value) {
  let base = String(value || '').trim();
  if (!base) return '';
  if (!/^https?:\/\//i.test(base)) base = 'https://' + base;
  return base.replace(/\/+$/, '');
}
function appBaseUrl(request) {
  const configured = normalizeBaseUrl(PUBLIC_APP_URL);
  if (configured) return configured;
  const forwardedProto = String(request?.headers?.['x-forwarded-proto'] || '').split(',')[0].trim();
  const protocol = forwardedProto || (request?.socket?.encrypted ? 'https' : 'http');
  const host = request?.headers?.host || `localhost:${PORT}`;
  return `${protocol}://${host}`.replace(/\/+$/, '');
}
function serviceLink(baseUrl, element, id, extra = {}) {
  const base = normalizeBaseUrl(baseUrl);
  if (!base || !id) return '';
  const params = new URLSearchParams({ element, id: String(id), zoom: '2' });
  for (const [key, value] of Object.entries(extra)) if (value) params.set(key, String(value));
  return `${base}/ela-nov-paketleme-dynamic.html#${params.toString()}`;
}
function linkPropertyName(sourceKey) {
  if (sourceKey === 'gorulen') return process.env.GORULEN_LINK_PROPERTY || LINK_PROPERTY_DEFAULT;
  if (sourceKey === 'todo') return process.env.TODO_LINK_PROPERTY || LINK_PROPERTY_DEFAULT;
  return process.env.MAKINA_LINK_PROPERTY || LINK_PROPERTY_DEFAULT;
}

function mapPlans(pages, baseUrl = '') {
  return pages.map(page => ({
    id: page.id,
    name: title(page, 'Plan') || 'Без названия',
    parentId: relationIds(page, 'Parent Plan')[0] || null,
    type: select(page, 'Tip'),
    x: number(page, 'X') || 0,
    y: number(page, 'Y') || 0,
    width: number(page, 'Eni') || 2400,
    height: number(page, 'Uzunluğu') || 1400,
    scale: number(page, 'Scale') || 1,
    status: select(page, 'Status'),
    notionUrl: pageUrl(page),
    serviceUrl: serviceLink(baseUrl, 'plan', page.id)
  }));
}

function mapEquipment(pages, tasks, baseUrl = '') {
  return pages.map(page => ({
    id: page.id,
    name: title(page, 'Makina') || 'Без названия',
    planId: relationIds(page, 'Plan')[0] || null,
    type: select(page, 'Tip'),
    status: select(page, 'Status'),
    x: number(page, 'X') || 0,
    y: number(page, 'Y') || 0,
    width: number(page, 'Eni') || 100,
    height: number(page, 'Uzunluğu') || 100,
    rotation: number(page, 'Dönmə bucağı') || 0,
    notionUrl: pageUrl(page),
    serviceUrl: serviceLink(baseUrl, 'equipment', page.id),
    tasks: tasks.get(page.id) || []
  }));
}

function machineRelationProperty() {
  // Both machine task databases expose the equipment relation as Makina.
  return 'Makina';
}

function taskConfig(sourceKey) {
  if (sourceKey === 'gorulen') return {
    title: process.env.GORULEN_TITLE_PROPERTY || 'Gorulmeli isler',
    process: process.env.GORULEN_STATUS_PROPERTY || 'Proses',
    priority: process.env.GORULEN_PRIORITY_PROPERTY || 'Prioritet',
    date: process.env.GORULEN_DATE_PROPERTY || 'Tarix',
    assignee: process.env.GORULEN_ASSIGNEE_PROPERTY || 'Kime tapsirilib',
    relation: machineRelationProperty(),
    planRelation: process.env.GORULEN_PLAN_RELATION_PROPERTY || 'Plan',
    tapsirildi: process.env.GORULEN_TAPSIRILDI_PROPERTY || 'Tapsirildi',
    gtdProperty: process.env.GORULEN_GTD_PROPERTY || 'GTD',
    workTypeProperty: process.env.GORULEN_WORK_TYPE_PROPERTY || 'Is',
    tagProperty: process.env.GORULEN_TAG_PROPERTY || 'Tag',
    doneWork: process.env.GORULEN_DONE_WORK_PROPERTY || 'Gorulen is',
    doneWorkType: process.env.GORULEN_DONE_WORK_TYPE || 'rich_text',
    periodicProperty: process.env.GORULEN_PERIODIC_PROPERTY || 'Is',
    periodicValue: process.env.GORULEN_PERIODIC_VALUE || 'Periodik',
    database: GORULEN_DB,
    dataSourceId: GORULEN_DS,
    complete: process.env.GORULEN_COMPLETE_PROPERTY || 'Status',
    linkProperty: linkPropertyName('gorulen')
  };
  return {
    title: process.env.TODO_TITLE_PROPERTY || 'Name',
    process: process.env.TODO_STATUS_PROPERTY || 'Proses',
    priority: process.env.TODO_PRIORITY_PROPERTY || 'Prioritet',
    date: process.env.TODO_DUE_PROPERTY || 'Tarix',
    assignee: process.env.TODO_ASSIGNEE_PROPERTY || 'Kime tapsirilib',
    gtdProperty: process.env.TODO_GTD_PROPERTY || 'GTD',
    isciTagProperty: process.env.TODO_ISCI_TAG_PROPERTY || 'Isci tag',
    gtdValue: process.env.TODO_GTD_VALUE || 'Check list',
    relation: machineRelationProperty(),
    planRelation: process.env.TODO_PLAN_RELATION_PROPERTY || 'Plan',
    tapsirildi: process.env.TODO_TAPSIRILDI_PROPERTY || 'Tapsirildi',
    doneWork: process.env.TODO_DONE_WORK_PROPERTY || 'Gorulen is',
    doneWorkType: process.env.TODO_DONE_WORK_TYPE || 'rich_text',
    database: TODO_DB,
    dataSourceId: TODO_DS,
    complete: process.env.TODO_COMPLETE_PROPERTY || 'Status',
    linkProperty: linkPropertyName('todo')
  };
}

function taskIsCompleted(page, source) {
  const checkbox = property(page, source.completeName)?.checkbox;
  if (checkbox === true) return true;
  const process = source.statusNames.map(name => select(page, name)).find(Boolean) || '';
  return /^(done|complete|completed|is goruldu|tamamlandi|bitdi|bitib)$/i.test(process.trim());
}

function relationFilter(propertyName, pageIds) {
  const filters = pageIds.map(id => ({ property: propertyName, relation: { contains: id } }));
  if (!filters.length) return null;
  return filters.length === 1 ? filters[0] : { or: filters };
}

function taskSources() {
  const sources = [];
  const todo = taskConfig('todo');
  const gorulen = taskConfig('gorulen');
  if (TODO_DB || TODO_DS) sources.push({ key: 'todo', databaseId: TODO_DB, dataSourceId: TODO_DS, source: 'ToDo', relationName: machineRelationProperty(), planRelationName: todo.planRelation, titleNames: [todo.title, 'ToDo', 'Name'], statusNames: [todo.process, 'Proses', 'Status'], priorityName: todo.priority, dateName: todo.date, assigneeName: todo.assignee, tapsirildiName: todo.tapsirildi, doneWorkName: todo.doneWork, doneWorkType: todo.doneWorkType, gtdName: todo.gtdProperty, gtdValue: todo.gtdValue, isciTagName: todo.isciTagProperty, completeName: todo.complete, linkProperty: todo.linkProperty });
  if (GORULEN_DB || GORULEN_DS) sources.push({ key: 'gorulen', databaseId: GORULEN_DB, dataSourceId: GORULEN_DS, source: 'Gorulen isler', relationName: machineRelationProperty(), planRelationName: gorulen.planRelation, titleNames: [gorulen.title, 'Gorulmeli is', 'Name'], statusNames: [gorulen.process, 'Proses', 'Status'], priorityName: gorulen.priority, dateName: gorulen.date, assigneeName: gorulen.assignee, tapsirildiName: gorulen.tapsirildi, gtdName: gorulen.gtdProperty, workTypeName: gorulen.workTypeProperty, tagName: gorulen.tagProperty, doneWorkName: gorulen.doneWork, doneWorkType: gorulen.doneWorkType, periodicName: gorulen.periodicProperty, periodicValue: gorulen.periodicValue, completeName: gorulen.complete, linkProperty: gorulen.linkProperty });
  return sources;
}

function combineFilters(...filters) {
  const list = filters.flat().filter(Boolean);
  if (!list.length) return null;
  return list.length === 1 ? list[0] : { and: list };
}

function editedSinceFilter(since) {
  return since ? { timestamp: 'last_edited_time', last_edited_time: { on_or_after: since } } : null;
}

async function queryTaskPages(machineIds = [], since = '', restrictToMachines = true) {
  const queried = await Promise.all(taskSources().map(async source => {
    try {
      const filter = combineFilters(
        restrictToMachines ? relationFilter(source.relationName, machineIds) : null,
        editedSinceFilter(since)
      );
      return { source, pages: await queryDatabase(source.databaseId, source.dataSourceId, filter ? { filter } : {}) };
    } catch (error) {
      console.error('Task source unavailable:', source.source, error.message);
      return { source, pages: [] };
    }
  }));
  return queried;
}

function buildTaskMap(pageSets, machineIds = [], baseUrl = '') {
  const result = new Map();
  for (const { source, pages } of pageSets) {
    for (const page of pages) {
      const linkedMachines = relationIds(page, source.relationName);
      const linkedPlan = relationIds(page, source.planRelationName)[0] || '';
      if (!linkedMachines.length && !linkedPlan) continue;
      if (machineIds.length && !linkedMachines.some(id => machineIds.includes(id)) && !linkedPlan) continue;
      if (source.key === 'gorulen' && select(page, source.periodicName).trim().toLowerCase() === String(source.periodicValue).trim().toLowerCase()) continue;
      if (source.key === 'todo' && select(page, source.gtdName).trim().toLowerCase() === String(source.gtdValue).trim().toLowerCase()) continue;
      if (taskIsCompleted(page, source)) continue;
      const taskTitle = source.titleNames.map(name => title(page, name)).find(Boolean) || 'Задача';
      const taskStatus = source.statusNames.map(name => select(page, name)).find(Boolean) || 'Открыта';
      const assignee = person(page, source.assigneeName);
      const taskPriority = select(page, source.priorityName); const task = { id: page.id, sourceKey: source.key, title: taskTitle, meta: taskStatus, status: taskStatus, process: taskStatus, priority: taskPriority, urgent: String(taskPriority).trim() === '!!!', assigneeId: assignee.id, assigneeName: assignee.name, tapsirildi: multiSelect(page, source.tapsirildiName), gtd: select(page, source.gtdName), workType: select(page, source.workTypeName), isciTag: select(page, source.isciTagName), tag: select(page, source.tagName), doneWork: richText(page, source.doneWorkName), source: source.source, date: dateStart(page, source.dateName), completed: false, planId: linkedPlan || null, url: pageUrl(page), serviceUrl: serviceLink(baseUrl, 'task', page.id, linkedMachines[0] ? { machine: linkedMachines[0] } : { plan: linkedPlan }) };
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

const rawCache = {
  plans: new Map(),
  machines: new Map(),
  tasks: new Map(taskSources().map(source => [source.key, new Map()])),
  lastSyncAt: '',
  lastFullSyncAt: 0
};
let snapshotCache = null;
let snapshotCacheAt = 0;
let snapshotInFlight = null;
let snapshotEtag = '';
let snapshotCacheBaseUrl = '';
const SNAPSHOT_CACHE_MS = 5000;
const FULL_RECONCILE_MS = 2 * 60 * 60 * 1000;

function buildSnapshotFromRawCache(baseUrl = '') {
  const machinePages = [...rawCache.machines.values()];
  const machineIds = machinePages.map(page => page.id);
  const taskSets = taskSources().map(source => ({ source, pages: [...(rawCache.tasks.get(source.key) || new Map()).values()] }));
  const tasks = buildTaskMap(taskSets, machineIds, baseUrl);
  const mappedPlans = mapPlans([...rawCache.plans.values()], baseUrl).map(plan => ({ ...plan, tasks: tasks.get(`plan:${plan.id}`) || [] }));
  const mappedEquipment = mapEquipment(machinePages, tasks, baseUrl);
  attachTaskCounts(mappedPlans, mappedEquipment);
  return { fetchedAt: new Date().toISOString(), plans: mappedPlans, equipment: mappedEquipment };
}

function mergePages(target, pages) {
  for (const page of pages) {
    if (page.archived) {
      target.delete(page.id);
      continue;
    }
    const existing = target.get(page.id);
    if (!existing || !existing.last_edited_time || !page.last_edited_time || page.last_edited_time >= existing.last_edited_time) target.set(page.id, page);
  }
}

async function fullSync(startedAt, baseUrl = '') {
  const [plans, machines] = await Promise.all([queryDatabase(PLAN_DB, PLAN_DS), queryDatabase(MAKINA_DB, MAKINA_DS)]);
  // Read task databases without a machine-only relation filter so plan-only tasks are included.
  const taskSets = await queryTaskPages([], '', false);
  rawCache.plans = new Map(plans.map(page => [page.id, page]));
  rawCache.machines = new Map(machines.map(page => [page.id, page]));
  rawCache.tasks = new Map(taskSources().map(source => [source.key, new Map()]));
  for (const { source, pages } of taskSets) mergePages(rawCache.tasks.get(source.key), pages);
  rawCache.lastSyncAt = startedAt;
  rawCache.lastFullSyncAt = Date.now();
  const snapshot = buildSnapshotFromRawCache(baseUrl);
  console.log('Full sync:', snapshot.plans.length, 'plans,', snapshot.equipment.length, 'machines');
  return snapshot;
}

async function incrementalSync(startedAt, baseUrl = '') {
  const since = rawCache.lastSyncAt;
  const [plans, machines, taskSets] = await Promise.all([
    queryDatabase(PLAN_DB, PLAN_DS, { filter: editedSinceFilter(since) }),
    queryDatabase(MAKINA_DB, MAKINA_DS, { filter: editedSinceFilter(since) }),
    queryTaskPages([], since, false)
  ]);
  mergePages(rawCache.plans, plans);
  mergePages(rawCache.machines, machines);
  for (const { source, pages } of taskSets) mergePages(rawCache.tasks.get(source.key), pages);
  rawCache.lastSyncAt = startedAt;
  const snapshot = buildSnapshotFromRawCache(baseUrl);
  console.log('Incremental sync:', plans.length, 'plans,', machines.length, 'machines,', taskSets.reduce((n, item) => n + item.pages.length, 0), 'task changes');
  return snapshot;
}

async function snapshot(full = false, baseUrl = '') {
  if (snapshotCache && !full && snapshotCacheBaseUrl === baseUrl && Date.now() - snapshotCacheAt < SNAPSHOT_CACHE_MS) return snapshotCache;
  if (snapshotInFlight) return snapshotInFlight;
  const startedAt = new Date().toISOString();
  const needsFull = full || !rawCache.lastSyncAt || Date.now() - rawCache.lastFullSyncAt >= FULL_RECONCILE_MS;
  snapshotInFlight = (needsFull ? fullSync(startedAt, baseUrl) : incrementalSync(startedAt, baseUrl))
    .then(result => { const payload = JSON.stringify({ plans: result.plans || [], equipment: result.equipment || [] }); snapshotEtag = '"' + crypto.createHash('sha1').update(payload).digest('hex') + '"'; result.etag = snapshotEtag; snapshotCache = result; snapshotCacheBaseUrl = baseUrl; snapshotCacheAt = Date.now(); return result; })
    .finally(() => { snapshotInFlight = null; });
  return snapshotInFlight;
}

function zeroTaskCounts() { return { gorulen: 0, todo: 0, total: 0, urgent: 0 }; }
function countTasks(tasks) { const counts = zeroTaskCounts(); for (const task of tasks || []) { if (task.sourceKey === 'gorulen') counts.gorulen++; else counts.todo++; counts.total++; if (task.urgent || String(task.priority || '').trim() === '!!!') counts.urgent++; } return counts; }
function attachTaskCounts(plans, equipment) {
  const own = new Map();
  for (const machine of equipment) { machine.taskCounts = countTasks(machine.tasks); const current = own.get(machine.planId) || zeroTaskCounts(); current.gorulen += machine.taskCounts.gorulen; current.todo += machine.taskCounts.todo; current.total += machine.taskCounts.total; current.urgent += machine.taskCounts.urgent || 0; own.set(machine.planId, current); }
  for (const plan of plans) { const current = own.get(plan.id) || zeroTaskCounts(); const direct = countTasks(plan.tasks); current.gorulen += direct.gorulen; current.todo += direct.todo; current.total += direct.total; current.urgent += direct.urgent; own.set(plan.id, current); }
  const children = new Map();
  for (const plan of plans) { const list = children.get(plan.parentId || '') || []; list.push(plan); children.set(plan.parentId || '', list); }
  const visit = plan => { const counts = own.get(plan.id) || zeroTaskCounts(); for (const child of children.get(plan.id) || []) { const childCounts = visit(child); counts.gorulen += childCounts.gorulen; counts.todo += childCounts.todo; counts.total += childCounts.total; } plan.taskCounts = counts; return counts; };
  for (const plan of plans.filter(p => !p.parentId)) visit(plan);
}

function isLocalBaseUrl(baseUrl) {
  try { return /^(localhost|127\.0\.0\.1)(:\d+)?$/i.test(new URL(baseUrl).host); }
  catch { return true; }
}

async function patchServiceLink(page, propertyName, link) {
  if (!page || !propertyName || !link) return false;
  const current = property(page, propertyName)?.url || '';
  if (current === link) return false;
  await notion('/pages/' + encodeURIComponent(page.id), {
    method: 'PATCH',
    body: JSON.stringify({ properties: { [propertyName]: { url: link } } })
  });
  return true;
}

async function syncServiceLinks(baseUrl, force = false) {
  const normalized = normalizeBaseUrl(baseUrl);
  if (!normalized || (isLocalBaseUrl(normalized) && !PUBLIC_APP_URL)) {
    return { ok: true, skipped: true, reason: 'Нужен публичный PUBLIC_APP_URL' };
  }
  if (!force && linkSyncState.baseUrl === normalized && Date.now() - linkSyncState.at < LINK_SYNC_TTL_MS) {
    return { ok: true, skipped: true, updated: 0 };
  }
  if (linkSyncState.inFlight) return linkSyncState.inFlight;
  linkSyncState.inFlight = (async () => {
    const targets = [];
    const machines = await queryDatabase(MAKINA_DB, MAKINA_DS);
    for (const page of machines) targets.push({ page, propertyName: process.env.MAKINA_LINK_PROPERTY || LINK_PROPERTY_DEFAULT, link: serviceLink(normalized, 'equipment', page.id) });
    for (const source of taskSources()) {
      const pages = await queryDatabase(source.databaseId, source.dataSourceId);
      for (const page of pages) {
        const machineId = relationIds(page, source.relationName)[0] || '';
        targets.push({ page, propertyName: source.linkProperty || LINK_PROPERTY_DEFAULT, link: serviceLink(normalized, 'task', page.id, { machine: machineId }) });
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
    linkSyncState.baseUrl = normalized;
    linkSyncState.at = Date.now();
    console.log('Service links synced:', updated, 'updated,', failed, 'failed');
    return { ok: true, updated, failed, total: targets.length, baseUrl: normalized };
  })().finally(() => { linkSyncState.inFlight = null; });
  return linkSyncState.inFlight;
}

const taskCache = new Map();
const userCache = { value: null, at: 0 };

const SECURITY_HEADERS = {
  'X-Content-Type-Options': 'nosniff',
  'X-Frame-Options': 'DENY',
  'Referrer-Policy': 'strict-origin-when-cross-origin',
  'Permissions-Policy': 'camera=(), microphone=(), geolocation=()'
};

function json(response, status, body, extraHeaders = {}) {
  response.writeHead(status, {
    'Content-Type': 'application/json; charset=utf-8',
    'Access-Control-Allow-Origin': CORS_ORIGIN,
    'Access-Control-Allow-Headers': 'Content-Type, If-None-Match',
    'Cache-Control': 'no-store',
    ...SECURITY_HEADERS,
    ...extraHeaders
  });
  response.end(JSON.stringify(body));
}

function file(response, filename, contentType = 'text/html; charset=utf-8', cacheControl = 'no-store') {
  response.writeHead(200, { 'Content-Type': contentType, 'Cache-Control': cacheControl, ...SECURITY_HEADERS });
  response.end(fs.readFileSync(filename));
}

function requestError(message, statusCode) {
  const error = new Error(message);
  error.statusCode = statusCode;
  return error;
}

function readBody(request) {
  return new Promise((resolve, reject) => {
    let body = '';
    let bytes = 0;
    let settled = false;
    request.on('data', chunk => {
      if (settled) return;
      bytes += Buffer.byteLength(chunk);
      if (bytes > 100000) {
        settled = true;
        reject(requestError('Размер запроса превышает 100 КБ', 413));
        request.resume();
        return;
      }
      body += chunk;
    });
    request.on('end', () => {
      if (settled) return;
      try { resolve(JSON.parse(body || '{}')); }
      catch { reject(requestError('Некорректный JSON в запросе', 400)); }
    });
    request.on('error', error => { if (!settled) reject(error); });
  });
}

function enforceAiRateLimit() {
  const now = Date.now();
  while (aiRequestTimes.length && now - aiRequestTimes[0] >= AI_RATE_WINDOW_MS) aiRequestTimes.shift();
  if (aiRequestTimes.length >= AI_REQUESTS_PER_MINUTE) {
    const error = requestError('Слишком много запросов к AI. Попробуйте ещё раз через минуту.', 429);
    error.retryAfter = Math.max(1, Math.ceil((AI_RATE_WINDOW_MS - (now - aiRequestTimes[0])) / 1000));
    throw error;
  }
  aiRequestTimes.push(now);
}

function updateLayoutCaches(id, values) {
  const page = rawCache.plans.get(id) || rawCache.machines.get(id);
  if (page) {
    page.properties = page.properties || {};
    for (const [name, value] of Object.entries({ X: values.x, Y: values.y, Eni: values.width, Uzunluğu: values.height })) {
      page.properties[name] = { ...(page.properties[name] || {}), type: 'number', number: value };
    }
    if (Object.prototype.hasOwnProperty.call(values, 'parentId')) page.properties['Parent Plan'] = { type: 'relation', relation: values.parentId ? [{ id: values.parentId }] : [] };
    if (Object.prototype.hasOwnProperty.call(values, 'planId')) page.properties.Plan = { type: 'relation', relation: values.planId ? [{ id: values.planId }] : [] };
    page.last_edited_time = new Date().toISOString();
  }
  if (snapshotCache) {
    for (const item of [...(snapshotCache.plans || []), ...(snapshotCache.equipment || [])]) {
      if (item.id === id) Object.assign(item, values);
    }
    snapshotCache.fetchedAt = new Date().toISOString();
  }
}

async function saveLayout(body) {
  const id = String(body.id || '').trim();
  const values = { x: Number(body.x), y: Number(body.y), width: Number(body.width), height: Number(body.height) };
  if (body.planId !== undefined) values.planId = body.planId ? cleanId(String(body.planId)) : null;
  if (!id || Object.values(values).some(value => !Number.isFinite(value))) {
    throw new Error('Нужны id, x, y, width и height');
  }
  const properties = {
    X: { number: values.x },
    Y: { number: values.y },
    Eni: { number: values.width },
    Uzunluğu: { number: values.height }
  };
  if (body.parentId !== undefined) {
    const parentId = body.parentId ? cleanId(String(body.parentId)) : '';
    if (parentId === id) throw new Error('План нельзя вложить сам в себя');
    properties['Parent Plan'] = { relation: parentId ? [{ id: parentId }] : [] };
    values.parentId = parentId || null;
  }
  if (body.planId !== undefined) properties.Plan = { relation: values.planId ? [{ id: values.planId }] : [] };
  await notion('/pages/' + encodeURIComponent(id), {
    method: 'PATCH',
    body: JSON.stringify({ properties })
  });
  updateLayoutCaches(id, values);
  console.log('Layout saved:', id, values);
  return { ok: true, id, values, savedAt: new Date().toISOString() };
}

function notionDateStart(value) {
  const text = String(value ?? '').trim();
  if (!text) return '';
  return /^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}$/.test(text) ? text + ':00' : text;
}

function buildTaskProperties(body, config, includeMachine = false) {
  const properties = {};
  const textBlocks = value => { const content = String(value ?? '').trim().slice(0, 2000); return content ? [{ type: 'text', text: { content } }] : []; };
  if (body.title !== undefined) properties[config.title] = { title: [{ type: 'text', text: { content: String(body.title).trim().slice(0, 2000) || 'Задача' } }] };
  if (body.process !== undefined && String(body.process).trim()) properties[config.process] = { status: { name: String(body.process).trim() } };
  if (body.priority !== undefined && String(body.priority).trim()) properties[config.priority] = { status: { name: String(body.priority).trim() } };
  if (body.date !== undefined) properties[config.date] = { date: body.date ? { start: notionDateStart(body.date) } : null };
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
  const name=String(body.name||'').trim(); if(!name) throw new Error('Нужно название плана');
  return {Plan:{title:createText(name)},...createSelect('Tip',body.type||'Zona'),...createSelect('Status',body.status||'Aktiv'),...createNumber('X',body.x,0),...createNumber('Y',body.y,0),...createNumber('Eni',body.width,200),...createNumber('Uzunluğu',body.height,200),...createNumber('Scale',body.scale,1),...(body.object?{Obyekt:{rich_text:createText(body.object)}}:{}),...(body.parentId?{'Parent Plan':{relation:[{id:cleanId(String(body.parentId))}]}}:{})};
}
function equipmentCreateProperties(body){
  const name=String(body.name||'').trim(),planId=cleanId(String(body.planId||'').trim()); if(!name||!planId) throw new Error('Нужны название оборудования и план');
  return {Makina:{title:createText(name)},...createSelect('Tip',body.type||'Maşın'),...createSelect('Status',body.status||'İşləyir'),...createNumber('X',body.x,0),...createNumber('Y',body.y,0),...createNumber('Eni',body.width,200),...createNumber('Uzunluğu',body.height,200),...createNumber('Dönmə bucağı',body.rotation,0),Plan:{relation:[{id:planId}]},...(body.zone?{Zona:{rich_text:createText(body.zone)}}:{})};
}
async function createPlan(body){
  if(!PLAN_DB&&!PLAN_DS) throw new Error('Не настроена база Plan');
  const page=await notion('/pages',{method:'POST',body:JSON.stringify({parent:databaseParent(PLAN_DB,PLAN_DS),properties:planCreateProperties(body)})}); snapshotCache=null;
  return {ok:true,id:page.id,url:page.url||'',savedAt:new Date().toISOString()};
}
async function createEquipment(body){
  if(!MAKINA_DB&&!MAKINA_DS) throw new Error('Не настроена база Makina');
  const page=await notion('/pages',{method:'POST',body:JSON.stringify({parent:databaseParent(MAKINA_DB,MAKINA_DS),properties:equipmentCreateProperties(body)})}); snapshotCache=null;
  return {ok:true,id:page.id,url:page.url||'',savedAt:new Date().toISOString()};
}

async function saveTask(body) {
  const id = String(body.id || '').trim();
  const sourceKey = String(body.sourceKey || 'todo');
  if (!id) throw new Error('Не указан ID задачи');
  const config = taskConfig(sourceKey);
  await notion('/pages/' + encodeURIComponent(id), { method: 'PATCH', body: JSON.stringify({ properties: buildTaskProperties(body, config, Boolean(body.machineId)) }) });
  if (body.machineId) taskCache.delete(String(body.machineId));
  snapshotCache = null;
  console.log('Task saved:', id, sourceKey);
  return { ok: true, id, sourceKey, savedAt: new Date().toISOString() };
}

async function createTask(body, baseUrl = '') {
  const sourceKey = String(body.sourceKey || 'todo');
  const machineId = String(body.machineId || '').trim();
  const planId = String(body.planId || '').trim();
  const titleValue = String(body.title || '').trim();
  if ((!machineId && !planId) || !titleValue) throw new Error('Укажите название задачи и оборудование или план');
  const config = taskConfig(sourceKey);
  const page = await notion('/pages', { method: 'POST', body: JSON.stringify({ parent: databaseParent(config.database, config.dataSourceId), properties: buildTaskProperties({ ...body, machineId, planId, title: titleValue, completed: false }, config, Boolean(machineId)) }) });
  if (machineId) taskCache.delete(machineId);
  snapshotCache = null;
  return { ok: true, id: page.id, url: page.url || '', serviceUrl: serviceLink(baseUrl, 'task', page.id, machineId ? { machine: machineId } : { plan: planId }), sourceKey, savedAt: new Date().toISOString() };
}

async function archiveElement(body) {
  const id = String(body.id || '').trim();
  const kind = body.kind === 'plan' ? 'plan' : 'equipment';
  if (!id) throw new Error('Не указан ID элемента');
  await notion('/pages/' + encodeURIComponent(id), { method: 'PATCH', body: JSON.stringify({ archived: true }) });
  if (kind === 'plan') rawCache.plans.delete(id); else rawCache.machines.delete(id);
  snapshotCache = null;
  return { ok: true, id, kind, deleted: true, savedAt: new Date().toISOString() };
}

async function deleteTask(body) {
  const id = String(body.id || '').trim();
  if (!id) throw new Error('Не указан ID задачи');
  await notion('/pages/' + encodeURIComponent(id), { method: 'PATCH', body: JSON.stringify({ archived: true }) });
  if (body.machineId) taskCache.delete(String(body.machineId));
  for (const pages of rawCache.tasks.values()) pages.delete(id);
  snapshotCache = null;
  return { ok: true, id, deleted: true, savedAt: new Date().toISOString() };
}

let personalTasksCache = null;
let personalTasksCacheAt = 0;
let personalTasksInFlight = null;

function checkbox(page, name) { return property(page, name)?.checkbox === true; }

function mapPersonalTask(page) {
  const parent = relationIds(page, 'Parent item')[0] || '';
  const children = relationIds(page, 'Sub-item');
  const status = select(page, 'Status') || 'Not started';
  const priority = select(page, 'Priority');
  const prioritet = select(page, 'Prioritet');
  return {
    id: page.id,
    title: title(page, 'Adi') || 'Без названия',
    status,
    completed: checkbox(page, 'Status 1'),
    parentId: parent,
    childIds: children,
    containerId: relationIds(page, 'Personal Container')[0] || '',
    x: number(page, 'Personal X'),
    y: number(page, 'Personal Y'),
    width: number(page, 'Personal Width'),
    height: number(page, 'Personal Height'),
    order: number(page, 'Personal Order'),
    priority,
    prioritet,
    urgent: priority === '!!!' || prioritet === '!!!',
    category: select(page, 'Kateqoriya'),
    url: page.url || '',
    link: property(page, 'Link')?.url || '',
    date: dateStart(page, 'Tarix'),
    assignees: multiSelect(page, 'Tapsirildi'),
    tags: multiSelect(page, 'Tag'),
    pomodoroCount: number(page, 'Pomodoro количество') ?? 0,
    pomodoroMinutes: number(page, 'Pomodoro всего минут') ?? 0,
    pomodoroRunning: checkbox(page, 'Отчет запущен'),
    pomodoroStartedAt: dateStart(page, 'Начало отчета'),
    pomodoroEndedAt: dateStart(page, 'Конец отчета'),
    pomodoroMode: select(page, 'Pomodoro режим'),
    pomodoroDuration: number(page, 'Pomodoro текущая длительность') ?? pomodoroModeDuration(select(page, 'Pomodoro режим')) ,
    updatedAt: page.last_edited_time || ''
  };
}

function mapPersonalContainer(page) {
  return {
    id: page.id,
    name: title(page, 'Name') || 'Контейнер',
    parentId: relationIds(page, 'Parent Container')[0] || null,
    x: number(page, 'X') ?? 60,
    y: number(page, 'Y') ?? 60,
    width: number(page, 'Width') ?? 340,
    height: number(page, 'Height') ?? 220,
    order: number(page, 'Order') ?? 0,
    color: select(page, 'Color') || 'Yellow',
    url: page.url || ''
  };
}

function personalNumber(value, fallback = 0) {
  const n = Number(value);
  return Number.isFinite(n) ? n : fallback;
}

async function personalSnapshot(force = false) {
  if (!force && personalTasksCache && Date.now() - personalTasksCacheAt < 5000) return personalTasksCache;
  if (personalTasksInFlight) return personalTasksInFlight;
  personalTasksInFlight = Promise.all([
    queryDatabase(TASKS_DB, TASKS_DS),
    queryDatabase(PERSONAL_CONTAINERS_DB, PERSONAL_CONTAINERS_DS)
  ]).then(([taskPages, containerPages]) => {
    const tasks = taskPages.map(mapPersonalTask).filter(task => !task.completed);
    const containers = containerPages.map(mapPersonalContainer);
    const result = { tasks, containers, fetchedAt: new Date().toISOString(), database: TASKS_DB, containersDatabase: PERSONAL_CONTAINERS_DB };
    personalTasksCache = result;
    personalTasksCacheAt = Date.now();
    return result;
  }).finally(() => { personalTasksInFlight = null; });
  return personalTasksInFlight;
}

function personalContainerProperties(body, includeName = false) {
  const properties = {
    X: { number: personalNumber(body.x, 60) },
    Y: { number: personalNumber(body.y, 60) },
    Width: { number: personalNumber(body.width, 340) },
    Height: { number: personalNumber(body.height, 220) },
    Order: { number: personalNumber(body.order, 0) }
  };
  if (includeName) properties.Name = { title: [{ type: 'text', text: { content: String(body.name || 'Контейнер').trim().slice(0, 2000) || 'Контейнер' } }] };
  if (body.parentId !== undefined) properties['Parent Container'] = { relation: body.parentId ? [{ id: cleanId(String(body.parentId)) }] : [] };
  if (body.color !== undefined) properties.Color = body.color ? { select: { name: String(body.color) } } : { select: null };
  return properties;
}

async function createPersonalContainer(body) {
  if (!PERSONAL_CONTAINERS_DB && !PERSONAL_CONTAINERS_DS) throw new Error('Не настроена база Personal Containers');
  const page = await notion('/pages', { method: 'POST', body: JSON.stringify({ parent: databaseParent(PERSONAL_CONTAINERS_DB, PERSONAL_CONTAINERS_DS), properties: personalContainerProperties(body, true) }) });
  personalTasksCache = null;
  return { ok: true, container: mapPersonalContainer(page), savedAt: new Date().toISOString() };
}

async function savePersonalLayout(body) {
  const kind = body.kind === 'container' ? 'container' : 'task';
  const id = cleanId(String(body.id || '').trim());
  if (!id) throw new Error('Не указан ID личного элемента');
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
    if (body.containerId !== undefined) properties['Personal Container'] = { relation: body.containerId ? [{ id: cleanId(String(body.containerId)) }] : [] };
  }
  await notion('/pages/' + encodeURIComponent(id), { method: 'PATCH', body: JSON.stringify({ properties }) });
  personalTasksCache = null;
  return { ok: true, kind, id, savedAt: new Date().toISOString() };
}

async function deletePersonalContainer(id) {
  const containerId = cleanId(String(id || '').trim());
  if (!containerId) throw new Error('Не указан ID контейнера');
  try {
    const taskPages = await queryDatabase(TASKS_DB, TASKS_DS);
    const linked = taskPages.filter(page => relationIds(page, 'Personal Container').includes(containerId));
    for (const page of linked) {
      await notion('/pages/' + encodeURIComponent(page.id), { method: 'PATCH', body: JSON.stringify({ properties: { 'Personal Container': { relation: [] } } }) });
    }
  } catch (error) {
    console.warn('Could not clear container task links:', error.message);
  }
  await notion('/pages/' + encodeURIComponent(containerId), { method: 'PATCH', body: JSON.stringify({ archived: true }) });
  personalTasksCache = null;
  return { ok: true, id: containerId, deleted: true, savedAt: new Date().toISOString() };
}

async function listPageBlocks(pageId) {
  const blocks = [];
  let cursor = '';
  do {
    const suffix = cursor ? '&start_cursor=' + encodeURIComponent(cursor) : '';
    const result = await notion('/blocks/' + encodeURIComponent(pageId) + '/children?page_size=100' + suffix, { method: 'GET' });
    blocks.push(...(result.results || []));
    cursor = result.has_more ? result.next_cursor : '';
  } while (cursor);
  return blocks;
}
function blockRichText(block) { const value = block?.[block?.type] || {}; return (value.rich_text || []).map(part => part.plain_text || part.text?.content || '').join(''); }
async function blockContentText(block) {
  const type = block?.type || '';
  if (type === 'table_row') return (block.table_row?.cells || []).map(cell => (cell || []).map(part => part.plain_text || part.text?.content || '').join('')).join('\t');
  let text = blockRichText(block);
  if (type === 'to_do') text = (block.to_do?.checked ? '[x] ' : '[ ] ') + text;
  if (type === 'bulleted_list_item') text = '- ' + text;
  if (type === 'numbered_list_item') text = '1. ' + text;
  if (type === 'code' && block.code?.language) text = '```' + block.code.language + '\n' + text + '\n```';
  if (block.has_children) { const children = await listPageBlocks(block.id); const childText = (await Promise.all(children.map(blockContentText))).filter(Boolean).join('\n'); if (childText) text = text ? text + '\n' + childText : childText; }
  return text;
}
async function getPersonalTaskContent(idValue) { const id = cleanId(String(idValue || '').trim()); if (!id) throw new Error('Не указан ID задачи Tasks'); const blocks = await listPageBlocks(id); return { ok: true, id, content: (await Promise.all(blocks.map(blockContentText))).join('\n') }; }
function contentBlocks(value) { return String(value ?? '').replace(/\r\n/g, '\n').split('\n').map(line => ({ object: 'block', type: 'paragraph', paragraph: { rich_text: line ? [{ type: 'text', text: { content: line.slice(0, 2000) } }] : [] } })); }
async function replacePersonalTaskContent(idValue, value) { const id = cleanId(String(idValue || '').trim()); if (!id) throw new Error('Не указан ID задачи Tasks'); const oldBlocks = await listPageBlocks(id); for (const block of oldBlocks) await notion('/blocks/' + encodeURIComponent(block.id), { method: 'DELETE' }); const children = contentBlocks(value); for (let index = 0; index < children.length; index += 100) await notion('/blocks/' + encodeURIComponent(id) + '/children', { method: 'PATCH', body: JSON.stringify({ children: children.slice(index, index + 100) }) }); return { ok: true, id }; }

async function listStructuredPageBlocks(pageId) {
  const result = [];
  let cursor = '';
  do {
    const suffix = cursor ? '&start_cursor=' + encodeURIComponent(cursor) : '';
    const page = await notion('/blocks/' + encodeURIComponent(pageId) + '/children?page_size=100' + suffix, { method: 'GET' });
    result.push(...(page.results || []));
    cursor = page.has_more ? page.next_cursor : '';
  } while (cursor);
  return result;
}
async function loadStructuredBlockTree(pageId) {
  const blocks = await listStructuredPageBlocks(pageId);
  for (const block of blocks) if (block.has_children) block.children = await loadStructuredBlockTree(block.id);
  return blocks;
}
function decodeHtmlText(value) { return String(value || '').replace(/<br\s*\/?>/gi, '\n').replace(/&nbsp;/g, ' ').replace(/&amp;/g, '&').replace(/&lt;/g, '<').replace(/&gt;/g, '>').replace(/&quot;/g, '"').replace(/&#39;/g, "'"); }
function htmlToNotionRichText(html) {
  const runs = [], stack = [];
  const source = String(html || '').replace(/<div>/gi, '').replace(/<\/div>/gi, '\n');
  for (const token of source.split(/(<[^>]+>)/g).filter(Boolean)) {
    if (token[0] === '<') {
      const tag = token.match(/^<\/?\s*([a-z0-9]+)/i)?.[1]?.toLowerCase() || '';
      if (token[1] === '/') { const index = stack.lastIndexOf(tag); if (index >= 0) stack.splice(index, 1); continue; }
      if (tag === 'br') { runs.push({ type: 'text', text: { content: '\n' } }); continue; }
      if (['strong','b','em','i','u','s','strike','code','a','span'].includes(tag)) stack.push(tag);
      continue;
    }
    const text = decodeHtmlText(token); if (!text) continue;
    const annotations = { bold: stack.some(x => x === 'strong' || x === 'b'), italic: stack.some(x => x === 'em' || x === 'i'), underline: stack.includes('u'), strikethrough: stack.some(x => x === 's' || x === 'strike'), code: stack.includes('code'), color: 'default' };
    const item = { type: 'text', text: { content: text }, annotations };
    runs.push(item);
  }
  return runs.length ? runs : [];
}
function structuredTableRows(dto) { return (dto.rows || []).map(row => ({ object: 'block', type: 'table_row', table_row: { cells: (row || []).map(cell => htmlToNotionRichText(cell)) } })); }
function structuredSimpleBlock(dto) {
  const type = ['paragraph','heading_1','heading_2','heading_3','bulleted_list_item','numbered_list_item','quote','callout','code','to_do'].includes(dto.type) ? dto.type : 'paragraph';
  const value = { rich_text: htmlToNotionRichText(dto.html || '') };
  if (type === 'to_do') value.checked = Boolean(dto.checked);
  if (type === 'code') value.language = String(dto.language || 'plain text');
  if (type === 'callout') value.icon = { type: 'emoji', emoji: String(dto.icon || '💡') };
  return { object: 'block', type, [type]: value };
}
async function getPersonalTaskBlocks(idValue) { const id = cleanId(String(idValue || '').trim()); if (!id) throw new Error('Не указан ID задачи Tasks'); return { ok: true, id, blocks: await loadStructuredBlockTree(id) }; }
function structuredTablePlan(dto) {
  const inputRows = Array.isArray(dto.rows) && dto.rows.length ? dto.rows : [['']];
  if (inputRows.some(row => !Array.isArray(row))) throw new Error('Строки таблицы должны быть массивами ячеек');
  const declaredWidth = Number(dto.width) || 0;
  if (declaredWidth && (!Number.isInteger(declaredWidth) || declaredWidth < 1)) throw new Error('Некорректная ширина таблицы');
  const width = Math.max(1, declaredWidth, ...inputRows.map(row => row.length));
  if (width > 100) throw new Error('Таблица может содержать не более 100 столбцов');
  const normalized = inputRows.map(row => Array.from({length: width}, (_, i) => row[i] ?? ''));
  const rows = structuredTableRows({rows: normalized});
  return {
    block: {object: 'block', type: 'table', table: {
      table_width: width, has_column_header: Boolean(dto.hasColumnHeader), has_row_header: false,
      children: rows.slice(0, 100)
    }}, extraRows: rows.slice(100)
  };
}
async function replacePersonalTaskBlocks(idValue, blocks) {
  const id = cleanId(String(idValue || '').trim()); if (!id) throw new Error('Не указан ID задачи Tasks');
  const items = Array.isArray(blocks) && blocks.length ? blocks : [{type: 'paragraph', html: ''}];
  // Validate/build the entire payload before making changes in Notion.
  const plan = items.map(dto => {
    if (!dto || typeof dto !== 'object') throw new Error('Некорректный блок содержимого задачи');
    return dto.type === 'table' ? structuredTablePlan(dto) : {block: structuredSimpleBlock(dto), extraRows: []};
  });
  const oldBlocks = await listStructuredPageBlocks(id), createdIds = [], archiveAttempted = [];
  try {
    // Stage all new content first. A rejected table must not erase existing content.
    for (const item of plan) {
      const created = await notion('/blocks/' + encodeURIComponent(id) + '/children', {method: 'PATCH', body: JSON.stringify({children: [item.block]})});
      const blockId = created.results?.[0]?.id;
      if (!blockId) throw new Error('Notion не вернул ID созданного блока; старое содержимое не удалено');
      createdIds.push(blockId);
      for (let offset = 0; offset < item.extraRows.length; offset += 100) {
        await notion('/blocks/' + encodeURIComponent(blockId) + '/children', {method: 'PATCH', body: JSON.stringify({children: item.extraRows.slice(offset, offset + 100)})});
      }
    }
    for (const block of oldBlocks) {
      archiveAttempted.push(block.id);
      await notion('/blocks/' + encodeURIComponent(block.id), {method: 'DELETE'});
    }
  } catch (error) {
    const recoveryErrors = [];
    // Best-effort rollback: Notion has no atomic replace API.
    for (const blockId of archiveAttempted) {
      try {await notion('/blocks/' + encodeURIComponent(blockId), {method: 'PATCH', body: JSON.stringify({archived: false})});}
      catch (recovery) {recoveryErrors.push(recovery.message);}
    }
    for (const blockId of createdIds.reverse()) {
      try {await notion('/blocks/' + encodeURIComponent(blockId), {method: 'DELETE'});}
      catch (recovery) {recoveryErrors.push(recovery.message);}
    }
    if (recoveryErrors.length) error.message += ' · Не удалось полностью отменить частичное сохранение. Не закрывайте редактор и сохраните копию текста.';
    throw error;
  }
  return {ok: true, id};
}

async function createPersonalTask(body) {
  const titleValue = String(body.title || '').trim().slice(0, 2000);
  if (!titleValue) throw new Error('Введите название задачи');
  const properties = {
    Adi: { title: createText(titleValue) },
    Status: { status: { name: String(body.status || 'Not started').trim() || 'Not started' } },
    'Status 1': { checkbox: Boolean(body.completed) }
  };
  if (body.priority) properties.Priority = { select: { name: String(body.priority).trim() } };
  if (body.prioritet) properties.Prioritet = { status: { name: String(body.prioritet).trim() } };
  if (body.category) properties.Kateqoriya = { select: { name: String(body.category).trim() } };
  if (body.date) properties.Tarix = { date: { start: notionDateStart(body.date) } };
  if (Array.isArray(body.tags) && body.tags.length) properties.Tag = { multi_select: body.tags.map(value => ({ name: String(value).trim() })).filter(item => item.name).slice(0, 100) };
  if (Array.isArray(body.assignees) && body.assignees.length) properties.Tapsirildi = { multi_select: body.assignees.map(value => ({ name: String(value).trim() })).filter(item => item.name).slice(0, 100) };
  if (body.parentId) properties['Parent item'] = { relation: [{ id: cleanId(String(body.parentId)) }] };
  if (body.containerId) properties['Personal Container'] = { relation: [{ id: cleanId(String(body.containerId)) }] };
  const parent = TASKS_DS ? { data_source_id: TASKS_DS } : { database_id: TASKS_DB };
  const page = await notion('/pages', { method: 'POST', body: JSON.stringify({ parent, properties }) });
  if (body.pageBlocks !== undefined) await replacePersonalTaskBlocks(page.id, body.pageBlocks);
  else if (body.pageContent !== undefined) await replacePersonalTaskContent(page.id, body.pageContent);
  personalTasksCache = null;
  return { ok: true, id: page.id, url: page.url || '', savedAt: new Date().toISOString() };
}

async function deletePersonalTask(idValue) {
  const id = cleanId(String(idValue || '').trim());
  if (!id) throw new Error('Не указан ID задачи Tasks');
  await notion('/pages/' + encodeURIComponent(id), { method: 'PATCH', body: JSON.stringify({ archived: true }) });
  personalTasksCache = null;
  return { ok: true, id, deleted: true, savedAt: new Date().toISOString() };
}

const {TaskManagementStore}=require('./task-management');
const taskManagement=new TaskManagementStore(process.env.TASK_MANAGEMENT_FILE||path.join(process.env.POMODORO_STATE_FILE?path.dirname(process.env.POMODORO_STATE_FILE):path.join(__dirname,'data'),'task-management.json'));
let personalStatusWriteQueue=Promise.resolve();
async function savePersonalTask(body){
 if(String(body.status||'').trim().toLowerCase()==='in progress'){
  const operation=personalStatusWriteQueue.then(async()=>{const pages=await queryDatabase(TASKS_DB,TASKS_DS,{filter:{property:'Status 1',checkbox:{equals:false}}});taskManagement.checkWip(pages.map(mapPersonalTask),cleanId(String(body.id||'')),body.wipOverride);return savePersonalTaskUnlocked(body)});
  personalStatusWriteQueue=operation.catch(()=>{});return operation;
 }
 return savePersonalTaskUnlocked(body);
}

async function savePersonalTaskUnlocked(body) {
  const id = cleanId(String(body.id || '').trim());
  if (!id) throw new Error('Не указан ID задачи Tasks');
  const properties = {};
  if (body.title !== undefined) properties.Adi = { title: [{ type: 'text', text: { content: String(body.title || '').trim().slice(0, 2000) } }] };
  if (body.status !== undefined && String(body.status).trim()) properties.Status = { status: { name: String(body.status).trim() } };
  if (body.completed !== undefined) properties['Status 1'] = { checkbox: Boolean(body.completed) };
  if (body.priority !== undefined) properties.Priority = body.priority ? { select: { name: String(body.priority).trim() } } : { select: null };
  if (body.prioritet !== undefined) properties.Prioritet = body.prioritet ? { status: { name: String(body.prioritet).trim() } } : { status: null };
  if (body.category !== undefined) properties.Kateqoriya = body.category ? { select: { name: String(body.category).trim() } } : { select: null };
  if (body.date !== undefined) properties.Tarix = body.date ? { date: { start: notionDateStart(body.date) } } : { date: null };
  if (body.tags !== undefined) properties.Tag = { multi_select: (Array.isArray(body.tags) ? body.tags : String(body.tags || '').split(',')).map(value => String(value).trim()).filter(Boolean).slice(0, 100).map(name => ({ name })) };
  if (body.assignees !== undefined) properties.Tapsirildi = { multi_select: (Array.isArray(body.assignees) ? body.assignees : String(body.assignees || '').split(',')).map(value => String(value).trim()).filter(Boolean).slice(0, 100).map(name => ({ name })) };
  if (body.parentId !== undefined) {
    const parentId = cleanId(String(body.parentId || '').trim());
    properties['Parent item'] = { relation: parentId ? [{ id: parentId }] : [] };
  }
  if (body.containerId !== undefined) properties['Personal Container'] = { relation: body.containerId ? [{ id: cleanId(String(body.containerId)) }] : [] };
  if (!Object.keys(properties).length) throw new Error('Нет изменений задачи');
  await notion('/pages/' + encodeURIComponent(id), { method: 'PATCH', body: JSON.stringify({ properties }) });
  if (body.pageBlocks !== undefined) await replacePersonalTaskBlocks(id, body.pageBlocks);
  else if (body.pageContent !== undefined) await replacePersonalTaskContent(id, body.pageContent);
  if(body.completed===true||body.status==='Done')taskManagement.update({type:'finish',id});
  personalTasksCache = null;
  return { ok: true, id, savedAt: new Date().toISOString() };
}

const {SharedPomodoroStore,timerFromTask}=require('./pomodoro-shared');
const sharedPomodoro=new SharedPomodoroStore(process.env.POMODORO_STATE_FILE||path.join(__dirname,'data','pomodoro-state.json'));
let pomodoroRefreshAt=0,pomodoroRefreshPromise=null;
async function sharedPomodoroSnapshot(){
  if(Date.now()-pomodoroRefreshAt>30000){
    if(!pomodoroRefreshPromise){const requestedAt=Date.now();pomodoroRefreshPromise=queryDatabase(TASKS_DB,TASKS_DS,{filter:{property:'Отчет запущен',checkbox:{equals:true}}}).then(pages=>{const found=new Set();for(const page of pages){const timer=timerFromTask(mapPersonalTask(page));found.add(timer.id);const current=sharedPomodoro.get(timer.id);if(current&&current.revision>=requestedAt)continue;if(!current||current.sessionId!==timer.sessionId||!current.running)sharedPomodoro.put({...timer,discovered:true,openedAt:current?.openedAt||0})}for(const current of [...sharedPomodoro.timers.values()])if(current.discovered&&current.running&&!found.has(current.id)&&current.revision<requestedAt)sharedPomodoro.put({...current,running:false,status:'stopped',endsAt:0,remainingSeconds:0});pomodoroRefreshAt=Date.now()}).catch(error=>{console.warn("Pomodoro discovery temporarily unavailable:",error.message);pomodoroRefreshAt=Date.now()}).finally(()=>{pomodoroRefreshPromise=null})}
    await pomodoroRefreshPromise;
  }
  return sharedPomodoro.snapshot();
}
const personalPomodoroLocks = new Map();
async function savePersonalPomodoro(body) {
  const id=cleanId(String(body.id||'').trim());if(!id)throw new Error('Не указан ID задачи Tasks');
  const previous=personalPomodoroLocks.get(id)||Promise.resolve();let release;const current=new Promise(resolve=>{release=resolve});personalPomodoroLocks.set(id,current);await previous;
  try{return await savePersonalPomodoroUnlocked(body)}finally{release();if(personalPomodoroLocks.get(id)===current)personalPomodoroLocks.delete(id)}
}
async function savePersonalPomodoroUnlocked(body){
 const id=cleanId(String(body.id||'').trim()),action=String(body.action||'').trim();
 if(!['open','start','pause','finish','break-finish','reset'].includes(action))throw new Error('Неизвестное действие Pomodoro');
 const global=id==='00000000-0000-4000-8000-000000000001',existing=sharedPomodoro.get(id),now=Date.now(),page=global?null:await notion('/pages/'+encodeURIComponent(id),{method:'GET'}),task=global?{id,title:'Помодоро',pomodoroRunning:existing?.running||false,pomodoroStartedAt:existing?.startedAt||'',pomodoroCount:existing?.pomodoroCount||0,pomodoroMinutes:existing?.pomodoroMinutes||0}:mapPersonalTask(page);
 let timer=existing||timerFromTask(task,now);
 const answer=(timer,extra={})=>({ok:true,id,action,...extra,timer,serverNow:Date.now(),pomodoroCount:timer.pomodoroCount,pomodoroMinutes:timer.pomodoroMinutes,startedAt:timer.startedAt||'',savedAt:new Date().toISOString()});
 if(body.sessionId&&timer.sessionId&&body.sessionId!==timer.sessionId&&action!=='open')return answer(timer,{duplicate:true,stale:true});
 if(action==='open'){if(!timer.running&&timer.status!=='paused'){const openMode=body.mode==='break'?'break':'work',openDuration=Math.max(1,Math.min(openMode==='break'?60:180,Math.round(Number(body.duration))||timer.duration||25));timer={...timer,mode:openMode,duration:openDuration,plannedDuration:openDuration,remainingSeconds:openDuration*60};}timer=sharedPomodoro.put({...timer,openedAt:now,status:timer.running?'running':timer.status==='paused'?'paused':'ready',remainingSeconds:timer.remainingSeconds||timer.duration*60});return answer(timer)}
 if(action==='start'&&task.pomodoroRunning&&task.pomodoroStartedAt){if(!existing||!existing.running)timer=sharedPomodoro.put(timerFromTask(task,now));return answer(timer,{duplicate:true})}
 if((action==='finish'||action==='break-finish')&&!task.pomodoroRunning&&timer.status!=='paused')return answer(timer,{duplicate:true});
 if(action==='pause'&&!timer.running)return answer(timer,{duplicate:true});
 const mode=body.mode==='break'?'break':'work',duration=Math.max(1,Math.min(mode==='break'?60:180,Math.round(timer.status==='paused'&&timer.mode===mode?timer.plannedDuration||timer.duration:Number(body.plannedDuration||body.duration))||(mode==='break'?5:25))),iso=new Date(now).toISOString(),properties={};
 if(action==='start'){
  const requested=Number(body.remainingSeconds),remaining=Number.isFinite(requested)&&requested>0?Math.min(duration*60,Math.ceil(requested)):timer.status==='paused'&&timer.mode===mode?timer.remainingSeconds:duration*60;
  const effectiveStart=new Date(now-(duration*60-remaining)*1000).toISOString();
  properties['Отчет запущен']={checkbox:true};properties['Начало отчета']={date:{start:effectiveStart}};properties['Конец отчета']={date:null};properties['Pomodoro режим']={select:{name:pomodoroModeName(mode,duration)}};properties['Pomodoro текущая длительность']={number:duration};
  timer={...timer,mode,duration,plannedDuration:duration,running:true,status:'running',startedAt:effectiveStart,endsAt:now+remaining*1000,remainingSeconds:remaining,sessionId:id+':'+effectiveStart,completedAt:null,completionReason:null,creditedMinutes:null};
 }else if(action==='pause'){
  const remaining=timer.running?Math.max(0,Math.ceil((timer.endsAt-now)/1000)):Math.max(0,Math.min(duration*60,Number(body.remainingSeconds)||timer.remainingSeconds||duration*60));
  properties['Отчет запущен']={checkbox:false};timer={...timer,running:false,status:'paused',endsAt:0,remainingSeconds:remaining};
 }else if(action==='finish'||action==='break-finish'){
  const fullMinutes=Math.max(1,Math.round(Number(timer.plannedDuration||timer.duration)||duration)),left=timer.running?Math.max(0,Math.ceil((timer.endsAt-now)/1000)):Math.max(0,Number(timer.remainingSeconds)||0),workedSeconds=Math.max(0,Math.min(fullMinutes*60,fullMinutes*60-left)),early=body.early===true&&left>0,credited=early?Math.round(workedSeconds/60):fullMinutes;properties['Отчет запущен']={checkbox:false};properties['Конец отчета']={date:{start:iso}};
  if(action==='finish'){properties['Pomodoro количество']={number:task.pomodoroCount+1};properties['Pomodoro всего минут']={number:Math.round(Number(task.pomodoroMinutes)||0)+credited}}
  timer={...timer,running:false,status:'completed',endsAt:0,remainingSeconds:0,completedAt:iso,completionReason:early?'early':'elapsed',creditedMinutes:action==='finish'?credited:0,pomodoroCount:action==='finish'?task.pomodoroCount+1:task.pomodoroCount,pomodoroMinutes:action==='finish'?Math.round(Number(task.pomodoroMinutes)||0)+credited:task.pomodoroMinutes};
 }else{
  properties['Отчет запущен']={checkbox:false};properties['Начало отчета']={date:null};properties['Конец отчета']={date:null};properties['Pomodoro текущая длительность']={number:null};timer={...timer,running:false,status:'stopped',endsAt:0,remainingSeconds:0,completedAt:null,completionReason:'reset',creditedMinutes:null};
 }
 if(!global)await notion('/pages/'+encodeURIComponent(id),{method:'PATCH',body:JSON.stringify({properties})});personalTasksCache=null;timer=sharedPomodoro.put(timer);return answer(timer);
}

async function aiChat(body) {
  const message=String(body?.message||'').trim();
  if(!message) throw requestError('Введите сообщение для Gemini', 400);
  if(message.length > 4000) throw requestError('Сообщение слишком длинное (максимум 4000 символов)', 413);
  if(!GEMINI_API_KEY){const error=new Error('Gemini не настроен. Добавьте GEMINI_API_KEY и GEMINI_MODEL в файл .env на сервере.');error.statusCode=503;throw error}
  const context=body?.context&&typeof body.context==='object'?body.context:{};
  const safeContext=JSON.stringify(context).slice(0,12000);
  const system='Ты AI-помощник сервиса ADIB для ведения задач и оборудования. Отвечай на языке пользователя, кратко и практично. Анализируй переданный контекст, но не выдумывай данные. В этой версии ты только консультируешь: не утверждай, что изменил задачу или базу.';
  const models=[...new Set([GEMINI_MODEL,GEMINI_MODEL_FALLBACK])];let data=null,usedModel=GEMINI_MODEL,lastStatus=0,lastError='';
  for(const model of models){
    const endpoint=GEMINI_API_URL+'/models/'+encodeURIComponent(model)+':generateContent?key='+encodeURIComponent(GEMINI_API_KEY);
    let response;
    const controller=new AbortController();
    const timeout=setTimeout(()=>controller.abort(),GEMINI_TIMEOUT_MS);
    try {
      response=await fetch(endpoint,{method:'POST',headers:{'Content-Type':'application/json'},signal:controller.signal,body:JSON.stringify({systemInstruction:{parts:[{text:system}]},contents:[{role:'user',parts:[{text:message+'\n\nКонтекст сервиса:\n'+safeContext}]}],generationConfig:{temperature:0.2,maxOutputTokens:1000}})});
    } catch(error) {
      if(error.name==='AbortError') throw requestError('Gemini не ответил вовремя. Попробуйте ещё раз.',504);
      throw error;
    } finally { clearTimeout(timeout); }
    const text=await response.text();try{data=JSON.parse(text)}catch{data={error:{message:text}}}
    if(response.ok){usedModel=model;break}
    lastStatus=response.status;lastError=data.error?.message||data.message||text;
    if(response.status!==404||model===models.at(-1))throw new Error('Gemini API '+response.status+': '+lastError);
  }
  const reply=(data?.candidates?.[0]?.content?.parts||[]).map(part=>part.text||'').join('').trim();
  if(!reply)throw new Error('Gemini не вернул ответ'+(lastStatus?' ('+lastStatus+')':''));
  return {reply,model:usedModel,provider:'gemini'};
}

async function notionUsers(force = false) {
  if (!force && userCache.value && Date.now() - userCache.at < 300000) return userCache.value;
  const users = [];
  let cursor = '';
  do {
    const suffix = cursor ? '&start_cursor=' + encodeURIComponent(cursor) : '';
    const page = await notion('/users?page_size=100' + suffix, { method: 'GET' });
    users.push(...(page.results || []));
    cursor = page.has_more ? page.next_cursor : '';
  } while (cursor);
  userCache.value = users.filter(user => user.type === 'person').map(user => ({ id: user.id, name: user.name || user.person?.email || 'Без имени', email: user.person?.email || '' }));
  userCache.at = Date.now();
  return userCache.value;
}

const server = http.createServer(async (request, response) => {
  try {
    if (request.method === 'OPTIONS') {
      response.writeHead(204, { 'Access-Control-Allow-Origin': CORS_ORIGIN, 'Access-Control-Allow-Methods': 'GET, POST, PATCH, DELETE, OPTIONS', 'Access-Control-Allow-Headers': 'Content-Type', ...SECURITY_HEADERS });
      return response.end();
    }
    const url = new URL(request.url, 'http://localhost');
    if (request.method === 'POST' && url.pathname === '/api/ai/chat') {
      const body = await readBody(request);
      try { enforceAiRateLimit(); return json(response, 200, await aiChat(body)); }
      catch (error) {
        if (error.retryAfter) response.setHeader('Retry-After', String(error.retryAfter));
        return json(response, error.statusCode || 502, { error: error.message });
      }
    }
    if (request.method === 'GET' && url.pathname === '/api/ai/status') return json(response, 200, { configured: Boolean(GEMINI_API_KEY), model: GEMINI_MODEL, provider: 'gemini' });
    if (request.method === 'PATCH' && url.pathname === '/api/layout') {
      const body = await readBody(request);
      return json(response, 200, await saveLayout(body));
    }
    if (request.method === 'GET' && url.pathname === '/api/task-comments') {
      return json(response, 200, await listTaskComments({ id: url.searchParams.get('id') }));
    }
    if (request.method === 'POST' && url.pathname === '/api/task-comments') {
      const body = await readBody(request);
      return json(response, 201, await addTaskComment(body));
    }
    if (request.method === 'POST' && url.pathname === '/api/chat-threads') {
      const body = await readBody(request);
      return json(response, 200, await listChatThreads(body));
    }
    if (request.method === 'POST' && url.pathname === '/api/comment-notifications') {
      const body = await readBody(request);
      return json(response, 200, await listCommentNotifications(body));
    }
    if (request.method === 'POST' && url.pathname === '/api/plan') {
      const body = await readBody(request);
      return json(response, 201, await createPlan(body));
    }
    if (request.method === 'POST' && url.pathname === '/api/equipment') {
      const body = await readBody(request);
      return json(response, 201, await createEquipment(body));
    }
    if (request.method === 'POST' && url.pathname === '/api/personal-container') {
      const body = await readBody(request);
      return json(response, 201, await createPersonalContainer(body));
    }
    if (request.method === 'PATCH' && url.pathname === '/api/personal-layout') {
      const body = await readBody(request);
      return json(response, 200, await savePersonalLayout(body));
    }
    if (request.method === 'DELETE' && url.pathname === '/api/personal-container') {
      return json(response, 200, await deletePersonalContainer(url.searchParams.get('id')));
    }
    if (request.method === 'GET' && url.pathname === '/api/personal-snapshot') {
      return json(response, 200, await personalSnapshot(url.searchParams.get('force') === '1'));
    }
    if (request.method === 'GET' && url.pathname === '/api/task-management') return json(response,200,{ok:true,...taskManagement.snapshot()});
    if (request.method === 'POST' && url.pathname === '/api/task-management') return json(response,200,{ok:true,...taskManagement.update(await readBody(request))});
    if (request.method === 'GET' && url.pathname === '/api/personal-task-content') {
      return json(response, 200, await getPersonalTaskContent(url.searchParams.get('id')));
    }
    if (request.method === 'GET' && url.pathname === '/api/personal-task-blocks') {
      return json(response, 200, await getPersonalTaskBlocks(url.searchParams.get('id')));
    }
    if (request.method === 'PATCH' && url.pathname === '/api/personal-task-blocks') {
      const body = await readBody(request);
      return json(response, 200, await replacePersonalTaskBlocks(body.id, body.blocks));
    }
    if (request.method === 'POST' && url.pathname === '/api/personal-task') {
      const body = await readBody(request);
      return json(response, 201, await createPersonalTask(body));
    }
    if (request.method === 'DELETE' && url.pathname === '/api/personal-task') {
      return json(response, 200, await deletePersonalTask(url.searchParams.get('id')));
    }
    if (request.method === 'PATCH' && url.pathname === '/api/personal-task') {
      const body = await readBody(request);
      return json(response, 200, await savePersonalTask(body));
    }
    if (request.method === 'GET' && url.pathname === '/api/pomodoro-state') return json(response,200,await sharedPomodoroSnapshot());
    if (request.method === 'POST' && url.pathname === '/api/personal-pomodoro') {
      const body = await readBody(request);
      return json(response, 200, await savePersonalPomodoro(body));
    }
    if (request.method === 'PATCH' && url.pathname === '/api/task') {
      const body = await readBody(request);
      return json(response, 200, await saveTask(body));
    }
    if (request.method === 'POST' && url.pathname === '/api/task') {
      const body = await readBody(request);
      return json(response, 201, await createTask(body, appBaseUrl(request)));
    }
    if (request.method === 'DELETE' && url.pathname === '/api/plan') {
      return json(response, 200, await archiveElement({ id: url.searchParams.get('id'), kind: 'plan' }));
    }
    if (request.method === 'DELETE' && url.pathname === '/api/equipment') {
      return json(response, 200, await archiveElement({ id: url.searchParams.get('id'), kind: 'equipment' }));
    }
    if (request.method === 'DELETE' && url.pathname === '/api/task') {
      return json(response, 200, await deleteTask({ id: url.searchParams.get('id'), machineId: url.searchParams.get('machineId') }));
    }
    if (request.method === 'GET' && url.pathname === '/api/users') return json(response, 200, { users: await notionUsers() });
    if (request.method === 'POST' && url.pathname === '/api/sync-links') {
      return json(response, 200, await syncServiceLinks(appBaseUrl(request), true));
    }
    if (url.pathname === '/api/health') return json(response, 200, { ok: true, time: new Date().toISOString() });
    if (url.pathname === '/api/plan-snapshot') { const full = url.searchParams.get('full') === '1' || url.searchParams.get('force') === '1'; const baseUrl = appBaseUrl(request); const result = await snapshot(full, baseUrl); syncServiceLinks(baseUrl).catch(error => console.warn('Service link sync failed:', error.message)); if (!full && result.etag && request.headers['if-none-match'] === result.etag) { response.writeHead(304, { 'ETag': result.etag, 'Cache-Control': 'no-cache', 'Access-Control-Allow-Origin': CORS_ORIGIN, 'Access-Control-Allow-Headers': 'Content-Type, If-None-Match', ...SECURITY_HEADERS }); return response.end(); } return json(response, 200, result, result.etag ? { 'ETag': result.etag } : {}); }
    if (url.pathname === '/manifest.webmanifest') return file(response, path.join(__dirname, 'manifest.webmanifest'), 'application/manifest+json; charset=utf-8', 'no-cache');
    if (url.pathname === '/sw.js') return file(response, path.join(__dirname, 'sw.js'), 'application/javascript; charset=utf-8', 'no-cache');
    if (url.pathname === '/icons/icon-192.png') return file(response, path.join(__dirname, 'icons/icon-192.png'), 'image/png', 'public, max-age=31536000, immutable');
    if (url.pathname === '/icons/icon-512.png') return file(response, path.join(__dirname, 'icons/icon-512.png'), 'image/png', 'public, max-age=31536000, immutable');
    if (url.pathname === '/' || url.pathname === '/ela-nov-paketleme-dynamic.html') return file(response, path.join(__dirname, 'ela-nov-paketleme-dynamic.html'));
    return json(response, 404, { error: 'Not found' });
  } catch (error) {
    if (error.statusCode && error.statusCode < 500) console.warn('Request rejected:', error.message);
    else console.error(error);
    return json(response, error.statusCode || 500, { error: error.message, ...(error.code?{code:error.code}:{}), ...(error.limit?{limit:error.limit,activeCount:error.activeCount}:{}) });
  }
});

server.listen(PORT, () => console.log('Ela plan server: http://localhost:' + PORT));
