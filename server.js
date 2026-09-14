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
const CORS_ORIGIN = process.env.CORS_ORIGIN || '*';
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
  const authored = rawText.match(/^\[([^\]]{1,120})\]\s([\s\S]*)$/);
  return {
    id: comment.id,
    text: authored ? authored[2] : rawText,
    createdAt: comment.created_time || '',
    authorId: author.id || '',
    authorName: authored ? authored[1] : (author.name || author.person?.email || 'Пользователь Notion')
  };
}

async function resolveCommentAuthor(comment) {
  const mapped = mapComment(comment);
  if (!mapped.authorId) return mapped;
  try {
    const user = await notion('/users/' + encodeURIComponent(mapped.authorId), { method: 'GET' });
    mapped.authorName = user.name || user.person?.email || mapped.authorName;
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
  return String(body.authorName || 'Пользователь сервиса').trim().slice(0, 120) || 'Пользователь сервиса';
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

function taskConfig(sourceKey) {
  if (sourceKey === 'gorulen') return {
    title: process.env.GORULEN_TITLE_PROPERTY || 'Gorulmeli isler',
    process: process.env.GORULEN_STATUS_PROPERTY || 'Proses',
    priority: process.env.GORULEN_PRIORITY_PROPERTY || 'Prioritet',
    date: process.env.GORULEN_DATE_PROPERTY || 'Tarix',
    assignee: process.env.GORULEN_ASSIGNEE_PROPERTY || 'Kime tapsirilib',
    relation: process.env.GORULEN_MACHINE_RELATION_PROPERTY || 'Makina',
    tapsirildi: process.env.GORULEN_TAPSIRILDI_PROPERTY || 'Tapsirildi',
    doneWork: process.env.GORULEN_DONE_WORK_PROPERTY || 'Gorulen is',
    doneWorkType: process.env.GORULEN_DONE_WORK_TYPE || 'rich_text',
    periodicProperty: process.env.GORULEN_PERIODIC_PROPERTY || 'Is',
    periodicValue: process.env.GORULEN_PERIODIC_VALUE || 'Periodik',
    database: GORULEN_DB,
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
    gtdValue: process.env.TODO_GTD_VALUE || 'Check list',
    relation: process.env.TODO_MACHINE_RELATION_PROPERTY || 'Makina',
    tapsirildi: process.env.TODO_TAPSIRILDI_PROPERTY || 'Tapsirildi',
    doneWork: process.env.TODO_DONE_WORK_PROPERTY || 'Gorulen is',
    doneWorkType: process.env.TODO_DONE_WORK_TYPE || 'rich_text',
    database: TODO_DB,
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
  if (TODO_DB || TODO_DS) sources.push({ key: 'todo', databaseId: TODO_DB, dataSourceId: TODO_DS, source: 'ToDo', relationName: process.env.TODO_MACHINE_RELATION_PROPERTY || 'Makina', titleNames: [todo.title, 'ToDo', 'Name'], statusNames: [todo.process, 'Proses', 'Status'], priorityName: todo.priority, dateName: todo.date, assigneeName: todo.assignee, tapsirildiName: todo.tapsirildi, doneWorkName: todo.doneWork, doneWorkType: todo.doneWorkType, gtdName: todo.gtdProperty, gtdValue: todo.gtdValue, completeName: todo.complete, linkProperty: todo.linkProperty });
  if (GORULEN_DB || GORULEN_DS) sources.push({ key: 'gorulen', databaseId: GORULEN_DB, dataSourceId: GORULEN_DS, source: 'Gorulen isler', relationName: process.env.GORULEN_MACHINE_RELATION_PROPERTY || 'Makina', titleNames: [gorulen.title, 'Gorulen is', 'Name'], statusNames: [gorulen.process, 'Proses', 'Status'], priorityName: gorulen.priority, dateName: gorulen.date, assigneeName: gorulen.assignee, tapsirildiName: gorulen.tapsirildi, doneWorkName: gorulen.doneWork, doneWorkType: gorulen.doneWorkType, periodicName: gorulen.periodicProperty, periodicValue: gorulen.periodicValue, completeName: gorulen.complete, linkProperty: gorulen.linkProperty });
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
      if (machineIds.length && !linkedMachines.some(id => machineIds.includes(id))) continue;
      if (source.key === 'gorulen' && select(page, source.periodicName).trim().toLowerCase() === String(source.periodicValue).trim().toLowerCase()) continue;
      if (source.key === 'todo' && select(page, source.gtdName).trim().toLowerCase() === String(source.gtdValue).trim().toLowerCase()) continue;
      if (taskIsCompleted(page, source)) continue;
      const taskTitle = source.titleNames.map(name => title(page, name)).find(Boolean) || 'Задача';
      const taskStatus = source.statusNames.map(name => select(page, name)).find(Boolean) || 'Открыта';
      const assignee = person(page, source.assigneeName);
      const task = { id: page.id, sourceKey: source.key, title: taskTitle, meta: taskStatus, status: taskStatus, process: taskStatus, priority: select(page, source.priorityName), assigneeId: assignee.id, assigneeName: assignee.name, tapsirildi: multiSelect(page, source.tapsirildiName), doneWork: richText(page, source.doneWorkName), source: source.source, date: dateStart(page, source.dateName), completed: false, url: pageUrl(page), serviceUrl: serviceLink(baseUrl, 'task', page.id, { machine: linkedMachines[0] || '' }) };
      for (const machineId of linkedMachines) {
        if (!result.has(machineId)) result.set(machineId, []);
        result.get(machineId).push(task);
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
  const mappedPlans = mapPlans([...rawCache.plans.values()], baseUrl);
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
  const taskSets = await queryTaskPages(machines.map(page => page.id), '', true);
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

function zeroTaskCounts() { return { gorulen: 0, todo: 0, total: 0 }; }
function countTasks(tasks) { const counts = zeroTaskCounts(); for (const task of tasks || []) { if (task.sourceKey === 'gorulen') counts.gorulen++; else counts.todo++; counts.total++; } return counts; }
function attachTaskCounts(plans, equipment) {
  const own = new Map();
  for (const machine of equipment) { machine.taskCounts = countTasks(machine.tasks); const current = own.get(machine.planId) || zeroTaskCounts(); current.gorulen += machine.taskCounts.gorulen; current.todo += machine.taskCounts.todo; current.total += machine.taskCounts.total; own.set(machine.planId, current); }
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

function json(response, status, body, extraHeaders = {}) {
  response.writeHead(status, {
    'Content-Type': 'application/json; charset=utf-8',
    'Access-Control-Allow-Origin': CORS_ORIGIN,
    'Access-Control-Allow-Headers': 'Content-Type, If-None-Match',
    'Cache-Control': 'no-store',
    ...extraHeaders
  });
  response.end(JSON.stringify(body));
}

function file(response, filename) {
  response.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8', 'Cache-Control': 'no-store' });
  response.end(fs.readFileSync(filename));
}

function readBody(request) {
  return new Promise((resolve, reject) => {
    let body = '';
    request.on('data', chunk => {
      body += chunk;
      if (body.length > 100000) request.destroy(new Error('Request body too large'));
    });
    request.on('end', () => {
      try { resolve(JSON.parse(body || '{}')); }
      catch { reject(new Error('Некорректный JSON в запросе')); }
    });
    request.on('error', reject);
  });
}

function updateLayoutCaches(id, values) {
  const page = rawCache.plans.get(id) || rawCache.machines.get(id);
  if (page) {
    page.properties = page.properties || {};
    for (const [name, value] of Object.entries({ X: values.x, Y: values.y, Eni: values.width, Uzunluğu: values.height })) {
      page.properties[name] = { ...(page.properties[name] || {}), type: 'number', number: value };
    }
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
  if (!id || Object.values(values).some(value => !Number.isFinite(value))) {
    throw new Error('Нужны id, x, y, width и height');
  }
  const properties = {
    X: { number: values.x },
    Y: { number: values.y },
    Eni: { number: values.width },
    Uzunluğu: { number: values.height }
  };
  await notion('/pages/' + encodeURIComponent(id), {
    method: 'PATCH',
    body: JSON.stringify({ properties })
  });
  updateLayoutCaches(id, values);
  console.log('Layout saved:', id, values);
  return { ok: true, id, values, savedAt: new Date().toISOString() };
}

function buildTaskProperties(body, config, includeMachine = false) {
  const properties = {};
  const textBlocks = value => { const content = String(value ?? '').trim().slice(0, 2000); return content ? [{ type: 'text', text: { content } }] : []; };
  if (body.title !== undefined) properties[config.title] = { title: [{ type: 'text', text: { content: String(body.title).trim().slice(0, 2000) || 'Задача' } }] };
  if (body.process !== undefined && String(body.process).trim()) properties[config.process] = { status: { name: String(body.process).trim() } };
  if (body.priority !== undefined && String(body.priority).trim()) properties[config.priority] = { status: { name: String(body.priority).trim() } };
  if (body.date !== undefined) properties[config.date] = { date: body.date ? { start: String(body.date).slice(0, 10) } : null };
  if (body.assigneeId !== undefined) properties[config.assignee] = { people: body.assigneeId ? [{ object: 'user', id: String(body.assigneeId) }] : [] };
  if (body.tapsirildi !== undefined) properties[config.tapsirildi] = { multi_select: (Array.isArray(body.tapsirildi) ? body.tapsirildi : []).filter(Boolean).map(name => ({ name: String(name) })) };
  if (body.doneWork !== undefined) properties[config.doneWork] = config.doneWorkType === 'title' ? { title: textBlocks(body.doneWork) } : { rich_text: textBlocks(body.doneWork) };
  if (body.completed !== undefined) properties[config.complete] = { checkbox: Boolean(body.completed) };
  if (includeMachine && body.machineId) properties[config.relation] = { relation: [{ id: String(body.machineId) }] };
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
  await notion('/pages/' + encodeURIComponent(id), { method: 'PATCH', body: JSON.stringify({ properties: buildTaskProperties(body, config) }) });
  if (body.machineId) taskCache.delete(String(body.machineId));
  snapshotCache = null;
  console.log('Task saved:', id, sourceKey);
  return { ok: true, id, sourceKey, savedAt: new Date().toISOString() };
}

async function createTask(body, baseUrl = '') {
  const sourceKey = String(body.sourceKey || 'todo');
  const machineId = String(body.machineId || '').trim();
  const titleValue = String(body.title || '').trim();
  if (!machineId || !titleValue) throw new Error('Нужны машина и название задачи');
  const config = taskConfig(sourceKey);
  const page = await notion('/pages', { method: 'POST', body: JSON.stringify({ parent: { database_id: config.database }, properties: buildTaskProperties({ ...body, title: titleValue, completed: false }, config, true) }) });
  taskCache.delete(machineId);
  snapshotCache = null;
  return { ok: true, id: page.id, url: page.url || '', serviceUrl: serviceLink(baseUrl, 'task', page.id, { machine: machineId }), sourceKey, savedAt: new Date().toISOString() };
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
      response.writeHead(204, { 'Access-Control-Allow-Origin': CORS_ORIGIN, 'Access-Control-Allow-Methods': 'GET, POST, PATCH, DELETE, OPTIONS', 'Access-Control-Allow-Headers': 'Content-Type' });
      return response.end();
    }
    const url = new URL(request.url, 'http://localhost');
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
    if (request.method === 'PATCH' && url.pathname === '/api/task') {
      const body = await readBody(request);
      return json(response, 200, await saveTask(body));
    }
    if (request.method === 'POST' && url.pathname === '/api/task') {
      const body = await readBody(request);
      return json(response, 201, await createTask(body, appBaseUrl(request)));
    }
    if (request.method === 'DELETE' && url.pathname === '/api/task') {
      return json(response, 200, await deleteTask({ id: url.searchParams.get('id'), machineId: url.searchParams.get('machineId') }));
    }
    if (request.method === 'GET' && url.pathname === '/api/users') return json(response, 200, { users: await notionUsers() });
    if (request.method === 'POST' && url.pathname === '/api/sync-links') {
      return json(response, 200, await syncServiceLinks(appBaseUrl(request), true));
    }
    if (url.pathname === '/api/health') return json(response, 200, { ok: true, time: new Date().toISOString() });
    if (url.pathname === '/api/plan-snapshot') { const full = url.searchParams.get('full') === '1' || url.searchParams.get('force') === '1'; const baseUrl = appBaseUrl(request); const result = await snapshot(full, baseUrl); syncServiceLinks(baseUrl).catch(error => console.warn('Service link sync failed:', error.message)); if (!full && result.etag && request.headers['if-none-match'] === result.etag) { response.writeHead(304, { 'ETag': result.etag, 'Cache-Control': 'no-cache', 'Access-Control-Allow-Origin': CORS_ORIGIN, 'Access-Control-Allow-Headers': 'Content-Type, If-None-Match' }); return response.end(); } return json(response, 200, result, result.etag ? { 'ETag': result.etag } : {}); }
    if (url.pathname === '/' || url.pathname === '/ela-nov-paketleme-dynamic.html') return file(response, path.join(__dirname, 'ela-nov-paketleme-dynamic.html'));
    return json(response, 404, { error: 'Not found' });
  } catch (error) {
    console.error(error);
    return json(response, 500, { error: error.message });
  }
});

server.listen(PORT, () => console.log('Ela plan server: http://localhost:' + PORT));
