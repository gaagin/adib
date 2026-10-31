// Server domain module. Dependencies are live bindings supplied by server.js.
'use strict';
module.exports = function serverModels(context) {
function property(page, name) { return page.properties?.[name] || null; }

function title(page, name) { return (property(page, name)?.title || []).map(x => x.plain_text || x.text?.content || '').join('').trim(); }

function richText(page, name) { const value = property(page, name); return (value?.rich_text || value?.title || []).map(x => x.plain_text || x.text?.content || '').join('').trim(); }

function number(page, name) { return property(page, name)?.number ?? null; }

function select(page, name) { const p = property(page, name); return p?.select?.name || p?.status?.name || ''; }

async function personalDirectory(force=false){if(!force&&context.personalDirectoryCache.rows&&Date.now()-context.personalDirectoryCache.at<60000)return context.personalDirectoryCache.rows;if(context.personalDirectoryCache.flight)return context.personalDirectoryCache.flight;context.personalDirectoryCache.flight=(async()=>{const pages=await context.queryDatabase(context.PERSONAL_DIRECTORY_DB,context.PERSONAL_DIRECTORY_DS),rows=pages.filter(p=>!p.archived&&!p.in_trash).map(p=>({id:context.cleanId(p.id),name:title(p,'Name'),department:select(p,'Bolme'),url:p.url||''})).filter(p=>p.id&&p.name).sort((a,b)=>a.name.localeCompare(b.name,'az'));context.personalDirectoryCache={at:Date.now(),rows,flight:null};return rows;})().catch(error=>{context.personalDirectoryCache.flight=null;throw error});return context.personalDirectoryCache.flight;}

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
  const configured = normalizeBaseUrl(context.PUBLIC_APP_URL);
  if (configured) return configured;
  const forwardedProto = String(request?.headers?.['x-forwarded-proto'] || '').split(',')[0].trim();
  const protocol = forwardedProto || (request?.socket?.encrypted ? 'https' : 'http');
  const host = request?.headers?.host || `localhost:${context.PORT}`;
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
  if (sourceKey === 'gorulen') return process.env.GORULEN_APP_URL_PROPERTY || context.TASK_LINK_PROPERTY_DEFAULT;
  if (sourceKey === 'todo') return process.env.TODO_APP_URL_PROPERTY || context.TASK_LINK_PROPERTY_DEFAULT;
  return process.env.MAKINA_LINK_PROPERTY || context.LINK_PROPERTY_DEFAULT;
}

function taskAppLink(baseUrl, id, machineId = '', planId = '') {
  const extra = machineId ? { machine: machineId } : planId ? { plan: planId } : {};
  return serviceLink(baseUrl, 'task', id, extra);
}

function mapPlans(pages, baseUrl = '') {
  return pages.map(page => ({
    id: page.id,
    name: title(page, 'Plan') || 'Adsız',
    parentId: relationIds(page, 'Parent Plan')[0] || null,
    type: select(page, 'Tip'),
    color: select(page, 'Color'),
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
    name: title(page, 'Makina') || 'Adsız',
    planId: relationIds(page, 'Plan')[0] || null,
    type: select(page, 'Tip'),
    status: select(page, 'Status'),
    color: select(page, 'Color'),
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
    database: context.GORULEN_DB,
    dataSourceId: context.GORULEN_DS,
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
    database: context.TODO_DB,
    dataSourceId: context.TODO_DS,
    complete: process.env.TODO_COMPLETE_PROPERTY || 'Status',
    linkProperty: linkPropertyName('todo')
  };
}
return { property, title, richText, number, select, personalDirectory, multiSelect, relationIds, dateStart, pomodoroModeDuration, pomodoroModeName, person, pageUrl, normalizeBaseUrl, appBaseUrl, serviceLink, linkPropertyName, taskAppLink, mapPlans, mapEquipment, machineRelationProperty, taskConfig };
};
