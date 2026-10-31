// Live shared bindings preserve cache invalidation and startup ordering across modules.
const serverContext = {
  get AI_RATE_WINDOW_MS() { return AI_RATE_WINDOW_MS; },
  get AI_REQUESTS_PER_MINUTE() { return AI_REQUESTS_PER_MINUTE; },
  get CORS_ORIGIN() { return CORS_ORIGIN; },
  get FULL_RECONCILE_MS() { return FULL_RECONCILE_MS; },
  get GEMINI_API_KEY() { return GEMINI_API_KEY; },
  get GEMINI_API_URL() { return GEMINI_API_URL; },
  get GEMINI_MODEL() { return GEMINI_MODEL; },
  get GEMINI_MODEL_FALLBACK() { return GEMINI_MODEL_FALLBACK; },
  get GEMINI_TIMEOUT_MS() { return GEMINI_TIMEOUT_MS; },
  get GORULEN_DB() { return GORULEN_DB; },
  get GORULEN_DS() { return GORULEN_DS; },
  get LAYOUT_COLORS() { return LAYOUT_COLORS; },
  get LINK_PROPERTY_DEFAULT() { return LINK_PROPERTY_DEFAULT; },
  get LINK_SYNC_TTL_MS() { return LINK_SYNC_TTL_MS; },
  get MAKINA_DB() { return MAKINA_DB; },
  get MAKINA_DS() { return MAKINA_DS; },
  get NOTION_VERSION() { return NOTION_VERSION; },
  get PERSONAL_CONTAINERS_DB() { return PERSONAL_CONTAINERS_DB; },
  get PERSONAL_CONTAINERS_DS() { return PERSONAL_CONTAINERS_DS; },
  get PERSONAL_DIRECTORY_DB() { return PERSONAL_DIRECTORY_DB; },
  get PERSONAL_DIRECTORY_DS() { return PERSONAL_DIRECTORY_DS; },
  get PLAN_DB() { return PLAN_DB; },
  get PLAN_DS() { return PLAN_DS; },
  get PORT() { return PORT; },
  get PUBLIC_APP_URL() { return PUBLIC_APP_URL; },
  get SECURITY_HEADERS() { return SECURITY_HEADERS; },
  get SNAPSHOT_CACHE_MS() { return SNAPSHOT_CACHE_MS; },
  get TASKS_DB() { return TASKS_DB; },
  get TASKS_DS() { return TASKS_DS; },
  get TASK_LINK_PROPERTY_DEFAULT() { return TASK_LINK_PROPERTY_DEFAULT; },
  get TODO_DB() { return TODO_DB; },
  get TODO_DS() { return TODO_DS; },
  get TOKEN() { return TOKEN; },
  get URL() { return URL; },
  get accessError() { return accessError; },
  get accountKey() { return accountKey; },
  get accountTask() { return accountTask; }, set accountTask(value) { accountTask = value; },
  get accounts() { return accounts; },
  get aiRequestTimes() { return aiRequestTimes; },
  get appBaseUrl() { return appBaseUrl; }, set appBaseUrl(value) { appBaseUrl = value; },
  get applyPersonalContainerDefaults() { return applyPersonalContainerDefaults; }, set applyPersonalContainerDefaults(value) { applyPersonalContainerDefaults = value; },
  get archiveNotionPage() { return archiveNotionPage; }, set archiveNotionPage(value) { archiveNotionPage = value; },
  get authorReads() { return authorReads; },
  get autosaveCreates() { return autosaveCreates; },
  get backgroundJobs() { return backgroundJobs; },
  get backgroundProgress() { return backgroundProgress; },
  get beginSnapshotProgress() { return beginSnapshotProgress; }, set beginSnapshotProgress(value) { beginSnapshotProgress = value; },
  get browserPomodoroSessions() { return browserPomodoroSessions; },
  get buildSnapshotFromRawCache() { return buildSnapshotFromRawCache; }, set buildSnapshotFromRawCache(value) { buildSnapshotFromRawCache = value; },
  get buildTaskMap() { return buildTaskMap; }, set buildTaskMap(value) { buildTaskMap = value; },
  get buildTeamDashboard() { return buildTeamDashboard; },
  get cacheCall() { return cacheCall; }, set cacheCall(value) { cacheCall = value; },
  get cacheHealth() { return cacheHealth; },
  get cleanId() { return cleanId; }, set cleanId(value) { cleanId = value; },
  get commentReads() { return commentReads; },
  get completionHistory() { return completionHistory; },
  get createText() { return createText; }, set createText(value) { createText = value; },
  get crypto() { return crypto; },
  get databaseParent() { return databaseParent; }, set databaseParent(value) { databaseParent = value; },
  get dateStart() { return dateStart; }, set dateStart(value) { dateStart = value; },
  get enrichCompletion() { return enrichCompletion; }, set enrichCompletion(value) { enrichCompletion = value; },
  get fs() { return fs; },
  get guardedAutosaveCreate() { return guardedAutosaveCreate; }, set guardedAutosaveCreate(value) { guardedAutosaveCreate = value; },
  get invalidatePersonalTasks() { return invalidatePersonalTasks; }, set invalidatePersonalTasks(value) { invalidatePersonalTasks = value; },
  get layoutColorSchemaFlights() { return layoutColorSchemaFlights; },
  get layoutColorSchemaReady() { return layoutColorSchemaReady; },
  get linkSyncState() { return linkSyncState; },
  get listPageBlocks() { return listPageBlocks; }, set listPageBlocks(value) { listPageBlocks = value; },
  get machineRelationProperty() { return machineRelationProperty; }, set machineRelationProperty(value) { machineRelationProperty = value; },
  get mapEquipment() { return mapEquipment; }, set mapEquipment(value) { mapEquipment = value; },
  get mapPersonalContainer() { return mapPersonalContainer; }, set mapPersonalContainer(value) { mapPersonalContainer = value; },
  get mapPersonalTask() { return mapPersonalTask; }, set mapPersonalTask(value) { mapPersonalTask = value; },
  get mapPlans() { return mapPlans; }, set mapPlans(value) { mapPlans = value; },
  get mergePages() { return mergePages; }, set mergePages(value) { mergePages = value; },
  get multiSelect() { return multiSelect; }, set multiSelect(value) { multiSelect = value; },
  get networkTime() { return networkTime; },
  get normalizeBaseUrl() { return normalizeBaseUrl; }, set normalizeBaseUrl(value) { normalizeBaseUrl = value; },
  get notion() { return notion; }, set notion(value) { notion = value; },
  get notionPomodoroSessionsAt() { return notionPomodoroSessionsAt; }, set notionPomodoroSessionsAt(value) { notionPomodoroSessionsAt = value; },
  get notionPomodoroSessionsCache() { return notionPomodoroSessionsCache; }, set notionPomodoroSessionsCache(value) { notionPomodoroSessionsCache = value; },
  get notionPomodoroSessionsPromise() { return notionPomodoroSessionsPromise; }, set notionPomodoroSessionsPromise(value) { notionPomodoroSessionsPromise = value; },
  get notionRate() { return notionRate; },
  get notionUsers() { return notionUsers; }, set notionUsers(value) { notionUsers = value; },
  get number() { return number; }, set number(value) { number = value; },
  get observeWrittenPage() { return observeWrittenPage; }, set observeWrittenPage(value) { observeWrittenPage = value; },
  get pageUrl() { return pageUrl; }, set pageUrl(value) { pageUrl = value; },
  get path() { return path; },
  get persistTaskEstimate() { return persistTaskEstimate; }, set persistTaskEstimate(value) { persistTaskEstimate = value; },
  get person() { return person; }, set person(value) { person = value; },
  get personalCalendarDate() { return personalCalendarDate; }, set personalCalendarDate(value) { personalCalendarDate = value; },
  get personalContainerRepairQueue() { return personalContainerRepairQueue; }, set personalContainerRepairQueue(value) { personalContainerRepairQueue = value; },
  get personalContainerRepairs() { return personalContainerRepairs; },
  get personalDirectory() { return personalDirectory; }, set personalDirectory(value) { personalDirectory = value; },
  get personalDirectoryCache() { return personalDirectoryCache; }, set personalDirectoryCache(value) { personalDirectoryCache = value; },
  get personalPomodoroLocks() { return personalPomodoroLocks; },
  get personalRaw() { return personalRaw; },
  get personalSnapshot() { return personalSnapshot; }, set personalSnapshot(value) { personalSnapshot = value; },
  get personalSnapshotSpecs() { return personalSnapshotSpecs; }, set personalSnapshotSpecs(value) { personalSnapshotSpecs = value; },
  get personalStatusWriteQueue() { return personalStatusWriteQueue; }, set personalStatusWriteQueue(value) { personalStatusWriteQueue = value; },
  get personalTasksCache() { return personalTasksCache; }, set personalTasksCache(value) { personalTasksCache = value; },
  get personalTasksCacheAt() { return personalTasksCacheAt; }, set personalTasksCacheAt(value) { personalTasksCacheAt = value; },
  get personalTasksGeneration() { return personalTasksGeneration; }, set personalTasksGeneration(value) { personalTasksGeneration = value; },
  get personalTasksInFlight() { return personalTasksInFlight; }, set personalTasksInFlight(value) { personalTasksInFlight = value; },
  get personalTasksInFlightGeneration() { return personalTasksInFlightGeneration; }, set personalTasksInFlightGeneration(value) { personalTasksInFlightGeneration = value; },
  get pomodoroModeDuration() { return pomodoroModeDuration; }, set pomodoroModeDuration(value) { pomodoroModeDuration = value; },
  get pomodoroModeName() { return pomodoroModeName; }, set pomodoroModeName(value) { pomodoroModeName = value; },
  get pomodoroRefreshAt() { return pomodoroRefreshAt; }, set pomodoroRefreshAt(value) { pomodoroRefreshAt = value; },
  get pomodoroRefreshPromise() { return pomodoroRefreshPromise; }, set pomodoroRefreshPromise(value) { pomodoroRefreshPromise = value; },
  get prepareNotionUpload() { return prepareNotionUpload; },
  get projectAccount() { return projectAccount; }, set projectAccount(value) { projectAccount = value; },
  get property() { return property; }, set property(value) { property = value; },
  get queryDatabase() { return queryDatabase; }, set queryDatabase(value) { queryDatabase = value; },
  get queryMetrics() { return queryMetrics; },
  get queryPolicy() { return queryPolicy; },
  get rawCache() { return rawCache; },
  get realtime() { return realtime; },
  get realtimeTombstones() { return realtimeTombstones; },
  get recentTask() { return recentTask; }, set recentTask(value) { recentTask = value; },
  get recordCompletion() { return recordCompletion; }, set recordCompletion(value) { recordCompletion = value; },
  get relationIds() { return relationIds; }, set relationIds(value) { relationIds = value; },
  get replacePersonalTaskBlocks() { return replacePersonalTaskBlocks; }, set replacePersonalTaskBlocks(value) { replacePersonalTaskBlocks = value; },
  get replacePersonalTaskContent() { return replacePersonalTaskContent; }, set replacePersonalTaskContent(value) { replacePersonalTaskContent = value; },
  get requestError() { return requestError; }, set requestError(value) { requestError = value; },
  get resolveEquipmentTaskPlan() { return resolveEquipmentTaskPlan; },
  get resolvePersonalTaskContainer() { return resolvePersonalTaskContainer; }, set resolvePersonalTaskContainer(value) { resolvePersonalTaskContainer = value; },
  get richText() { return richText; }, set richText(value) { richText = value; },
  get saveRawSnapshotCache() { return saveRawSnapshotCache; }, set saveRawSnapshotCache(value) { saveRawSnapshotCache = value; },
  get select() { return select; }, set select(value) { select = value; },
  get serviceLink() { return serviceLink; }, set serviceLink(value) { serviceLink = value; },
  get sharedPomodoro() { return sharedPomodoro; },
  get snapshot() { return snapshot; }, set snapshot(value) { snapshot = value; },
  get snapshotCache() { return snapshotCache; }, set snapshotCache(value) { snapshotCache = value; },
  get snapshotCacheAt() { return snapshotCacheAt; }, set snapshotCacheAt(value) { snapshotCacheAt = value; },
  get snapshotCacheBaseUrl() { return snapshotCacheBaseUrl; }, set snapshotCacheBaseUrl(value) { snapshotCacheBaseUrl = value; },
  get snapshotEtag() { return snapshotEtag; }, set snapshotEtag(value) { snapshotEtag = value; },
  get snapshotInFlight() { return snapshotInFlight; }, set snapshotInFlight(value) { snapshotInFlight = value; },
  get snapshotMetadata() { return snapshotMetadata; }, set snapshotMetadata(value) { snapshotMetadata = value; },
  get snapshotProgress() { return snapshotProgress; },
  get snapshotProgressRevision() { return snapshotProgressRevision; }, set snapshotProgressRevision(value) { snapshotProgressRevision = value; },
  get snapshotScope() { return snapshotScope; }, set snapshotScope(value) { snapshotScope = value; },
  get streamSnapshotPart() { return streamSnapshotPart; }, set streamSnapshotPart(value) { streamSnapshotPart = value; },
  get syncTaskSessionTitle() { return syncTaskSessionTitle; }, set syncTaskSessionTitle(value) { syncTaskSessionTitle = value; },
  get taskAppLink() { return taskAppLink; }, set taskAppLink(value) { taskAppLink = value; },
  get taskCache() { return taskCache; },
  get taskConfig() { return taskConfig; }, set taskConfig(value) { taskConfig = value; },
  get taskEstimateModule() { return taskEstimateModule; },
  get taskEstimates() { return taskEstimates; },
  get taskHistory() { return taskHistory; },
  get taskManagement() { return taskManagement; },
  get taskOptionCache() { return taskOptionCache; },
  get taskOptionFlights() { return taskOptionFlights; },
  get taskSources() { return taskSources; }, set taskSources(value) { taskSources = value; },
  get taskStatusOptions() { return taskStatusOptions; },
  get timerFromTask() { return timerFromTask; },
  get timerSessionLog() { return timerSessionLog; },
  get title() { return title; }, set title(value) { title = value; },
  get uiAssets() { return uiAssets; },
  get userCache() { return userCache; },
  get validateImage() { return validateImage; },
  get validateTaskEstimate() { return validateTaskEstimate; }, set validateTaskEstimate(value) { validateTaskEstimate = value; },
  get withTaskEstimates() { return withTaskEstimates; }, set withTaskEstimates(value) { withTaskEstimates = value; },
  get workTimer() { return workTimer; }
};

let { loadDotEnv, cleanId, checkConfig, notion, commentText, mapComment, resolveCommentAuthor, cachedTaskComments, listTaskComments, listEmployeeChatComments, createEmployeeChatComment, requestedCommentAuthor, addTaskComment, imageUploadId, ensureUploadedImage, validatedCommentAttachments, uploadTaskImageFile, mappedTaskImage, listTaskImages, deleteTaskImage, attachTaskImage, listChatThreads, listCommentNotifications, taskSourceOptions, taskFieldOptions, queryEndpoint, queryDatabase } = require('./server-notion')(serverContext);

let { property, title, richText, number, select, personalDirectory, multiSelect, relationIds, dateStart, pomodoroModeDuration, pomodoroModeName, person, pageUrl, normalizeBaseUrl, appBaseUrl, serviceLink, linkPropertyName, taskAppLink, mapPlans, mapEquipment, machineRelationProperty, taskConfig } = require('./server-models')(serverContext);

let { enrichCompletion, recordCompletion, recentTask, taskIsCompleted, relationFilter, taskSources, combineFilters, editedSinceFilter, equipmentTaskWindowFilter, changedCursor, collectionNeedsFull, syncError, queryTaskPages, buildTaskMap, buildSnapshotFromRawCache, mergePages, beginSnapshotProgress, completeSnapshotPart, progressiveSnapshot, equipmentSnapshotSpecs, personalSnapshotSpecs, streamSnapshotPart, syncEquipmentCollections, reconcileSnapshot, fullSync, incrementalSync, snapshot, snapshotUnbounded, zeroTaskCounts, countTasks, attachTaskCounts } = require('./server-snapshots')(serverContext);

let { isLocalBaseUrl, patchServiceLink, syncServiceLinks, json, file, requestError, readBody, enforceAiRateLimit, ensureLayoutColorSchema, updateLayoutCaches, saveLayoutColor, saveLayout, notionDateStart, personalCalendarDate, buildTaskProperties, databaseParent, createText, createSelect, createNumber, planCreateProperties, equipmentCreateProperties, createPlan, createEquipment, validateTaskEstimate, persistTaskEstimate, withTaskEstimates, saveTask, createTask, archiveNotionPage, archiveElement, deleteTask } = require('./server-equipment')(serverContext);

let { invalidatePersonalTasks, snapshotScope, cacheCall, snapshotMetadata, snapshotCollections, saveRawSnapshotCache, restoreRawSnapshotCache, checkbox, mapPersonalTask, mapPersonalContainer, personalNumber, inboxContainerId, personalInboxId, resolvePersonalTaskContainer, applyPersonalContainerDefaults, schedulePersonalContainerRepair, personalSnapshot, personalSnapshotUnbounded, personalSnapshotAfterMutation, personalContainerProperties, createPersonalContainer, savePersonalLayout, deletePersonalContainer } = require('./server-personal')(serverContext);

let { listPageBlocks, blockRichText, blockContentText, getPersonalTaskContent, contentBlocks, replacePersonalTaskContent, listStructuredPageBlocks, loadStructuredBlockTree, decodeHtmlText, htmlToNotionRichText, structuredTableRows, structuredSimpleBlock, getPersonalTaskBlocks, structuredTablePlan, replacePersonalTaskBlocks } = require('./server-content')(serverContext);

let { guardedAutosaveCreate, validatePersonalTaskContext, createPersonalTask, deletePersonalTask, savePersonalTask, savePersonalTaskUnlocked } = require('./server-task-writes')(serverContext);

let { loadNotionPomodoroSessions, sharedPomodoroSnapshot, savePersonalPomodoro, savePersonalPomodoroUnlocked } = require('./server-pomodoro')(serverContext);

let { aiChat, notionUsers, observeWrittenPage, mutationScopes, realtimePersonal, managementSnapshotWithTaskEstimates, accountTasks, allowedAccountIds, projectAccount, accountTask, accountAuthorize, syncTaskSessionTitle, workActor, workClock, workAccountTask, workTasks, teamSnapshot } = require('./server-access')(serverContext);

const {validateImage,prepareNotionUpload}=require('./image-upload');
const http = require('node:http');
const fs = require('node:fs');
const path = require('node:path');
const { URL } = require('node:url');
const crypto = require('node:crypto');
const {UiAssets}=require('./ui-assets');
const publicAssets=new Set(["loading-ui.js", "loading-ui.css", "discussions-ui.js", "discussions-ui.css", "focused-views.js", "focused-views.css", "local-timer-visibility.js", "network-idle.js", "pomodoro-session-ui.js", "browser-pomodoro.js", "compact-design.css", "compact-design.js", "work-timer-ui.js", "work-timer-ui.css", "az-locale.js", "account-client.js", "autosave.js", "zoned-time.js", "filter-memory.js", "realtime-client.js", "realtime-runtime.js", "filter-dialog.js", "filter-dialog.css", "calendar-time.js", "calendar-filter.js", "calendar-day-plan.js", "calendar-view.css", "calendar-view.js", "comment-state.js", "day-plan-refresh.js", "home-screen.css", "home-screen.js", "hybrid-theme.css", "icons/icon-192.png", "icons/icon-512.png", "images.js", "manifest.webmanifest", "network-time.css", "network-time.js", "personal-options.js", "personal-workspace.js", "pomodoro-rollup.js", "screen-system.css", "screens.js", "startup-view.js", "task-cards.css", "task-cards.js", "task-history.js", "task-stats.js", "task-tabs.css", "task-tabs.js", "task-concept.css", "task-concept.js", "notion-date-picker.css", "notion-date-picker.js", "elegant-ui.css", "elegant-ui.js", "ui-system.css", "ui-theme.js", "widget-hub.js", "workspace-headers.css", "workspace-headers.js", "team-view.js", "team-view.css"]);
const uiAssets=new UiAssets(__dirname,publicAssets);
const {RealtimeHub}=require('./realtime-server');
const {NotionRateGate}=require('./notion-rate');
const notionRate=new NotionRateGate({fetchFn:async(url,options)=>{
 queryMetrics.notionApiAttempts++;
 const parsed=new URL(url),method=options.method||'GET';
 if(parsed.pathname.endsWith('/query'))queryMetrics.queryAttempts++;
 else if(method==='GET'&&parsed.pathname==='/v1/comments')queryMetrics.commentReadAttempts++;
 else if(method==='GET')queryMetrics.otherReadAttempts++;
 else queryMetrics.writeAttempts++;
 const result=await fetch(url,options);if(result.status===429)queryMetrics.rateLimitResponses++;return result;
}});

loadDotEnv(path.join(__dirname, '.env'));

const {Accounts,key:accountKey,fail:accessError}=require('./accounts');
const {UserPreferencesStore}=require('./user-preferences-store');
const accounts=new Accounts({file:process.env.ADIB_ACCOUNTS_FILE||path.join(process.env.TASK_MANAGEMENT_FILE?path.dirname(process.env.TASK_MANAGEMENT_FILE):process.env.POMODORO_STATE_FILE?path.dirname(process.env.POMODORO_STATE_FILE):path.join(__dirname,'data'),'accounts.json'),enabled:process.env.NOTION_TOKEN!=='native'&&process.env.ADIB_ACCOUNTS_ENABLED!=='0',adminLogin:process.env.ADIB_ADMIN_LOGIN,adminPassword:process.env.ADIB_ADMIN_PASSWORD,adminName:process.env.ADIB_ADMIN_NAME||'Ilqar Mamedov'});
const {resolveEquipmentTaskPlan}=require('./equipment-task-access');
const {DirectChats}=require('./direct-chats');
const {EmployeeChatsAPI}=require('./employee-chats-api');
const employeeChats=new EmployeeChatsAPI({accounts,chats:new DirectChats({file:path.join(path.dirname(accounts.file),'employee-chats.json')}),comments:{list:listEmployeeChatComments,create:createEmployeeChatComment}});
const {buildTeamDashboard}=require('./team-dashboard');
const PORT = Number(process.env.PORT || 3000);
const {NetworkTime}=require('./network-clock-server');
const networkTime=new NetworkTime({timeZone:process.env.ADIB_TIME_ZONE||'Asia/Baku'});

const TOKEN = process.env.NOTION_TOKEN || '';
const QUERY_FIX_BUILD='1.1.64-cost-control-v3-auto-countdown-v18-undated-history-window-timer-session-log-v4-unified-pomodoro';
const EXTERNAL_SYNC_MS=TOKEN==='native'?60000:Math.max(300000,Number(process.env.ADIB_EXTERNAL_SYNC_MS)||300000);
const {QueryPolicy}=require('./query-policy');
const queryPolicy=new QueryPolicy({backgroundMs:EXTERNAL_SYNC_MS,refreshMs:TOKEN==='native'?5000:60000});
const queryMetrics={notionQueries:0,notionWrites:0,notionApiAttempts:0,queryAttempts:0,commentReadAttempts:0,otherReadAttempts:0,writeAttempts:0,rateLimitResponses:0};
const {ReadCache}=require('./read-cache');
const commentReads=new ReadCache(),authorReads=new ReadCache();
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
const TIMER_SESSIONS_DS = cleanId(process.env.TIMER_SESSIONS_DATA_SOURCE_ID || '32f630e9-0157-41e1-9a67-a7ec2285e28d');
const PERSONAL_CONTAINERS_DB = cleanId(process.env.PERSONAL_CONTAINERS_DATABASE_ID || '73df6f961625407d89c202bc1c3b749c');
const PERSONAL_CONTAINERS_DS = cleanId(process.env.PERSONAL_CONTAINERS_DATA_SOURCE_ID || '78daa90023f0496da65a864f8d63b0c5');
const PERSONAL_DIRECTORY_DB = cleanId(process.env.PERSONAL_DIRECTORY_DATABASE_ID || '23df536b064f42609b5cb4b5ed7983ad');
const PERSONAL_DIRECTORY_DS = cleanId(process.env.PERSONAL_DIRECTORY_DATA_SOURCE_ID || 'ee6a85c11e97477b99dddd204c4013fb');
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
const TASK_LINK_PROPERTY_DEFAULT = 'URL';
const linkSyncState = { baseUrl: '', at: 0, inFlight: null };

const taskPhotos=require('./task-photos').create({notion,sources:()=>[{key:'todo',ds:TODO_DS,db:TODO_DB},{key:'gorulen',ds:GORULEN_DS,db:GORULEN_DB}]});

// Schema-only reads: never scan task pages or alter Notion data.
const taskOptionCache = new Map(), taskOptionFlights = new Map();
const taskStatusOptions=require('./task-status-options').create({notion:(...args)=>notion(...args),config:taskConfig});

let personalDirectoryCache={at:0,rows:null,flight:null};

const userPreferences=new UserPreferencesStore({
 file:path.join(path.dirname(accounts.file),'user-preferences.json'),
 notion:(...args)=>notion(...args),
 listBlocks:listPageBlocks,
 parentPageForUser:async user=>{
  if(user?.personalPageId)return cleanId(user.personalPageId);
  const normalized=String(user?.name||'').trim().toLocaleLowerCase('az');
  if(!normalized)return '';
  const matches=(await personalDirectory()).filter(person=>person.name.trim().toLocaleLowerCase('az')===normalized);
  return matches.length===1?matches[0].id:'';
 },
});

const taskEstimateModule=require('./task-estimate');
const taskEstimates=taskEstimateModule.create({
  notion:(...args)=>notion(...args),
  sources:()=>({
    personal:{dataSourceId:TASKS_DS,databaseId:TASKS_DB},
    todo:{dataSourceId:TODO_DS,databaseId:TODO_DB},
    gorulen:{dataSourceId:GORULEN_DS,databaseId:GORULEN_DB}
  })
});

const taskHistory=require('./task-history');
const completionHistory=new taskHistory.CompletionHistory(process.env.COMPLETION_HISTORY_FILE||path.join(process.env.TASK_MANAGEMENT_FILE?path.dirname(process.env.TASK_MANAGEMENT_FILE):path.join(__dirname,'data'),'completion-history.json'));

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

const realtimeTombstones=new Map();

// Native progressive reads expose completed collections without waiting for the slowest one.
const snapshotProgress={personal:null,equipment:null},backgroundProgress={personal:null,equipment:null};
const backgroundJobs=new Map();
let rawStreamSaveAt=0;
let snapshotProgressRevision=0;

// Low-priority historical reconciliation has its own job; normal delta reads never join it.

const taskCache = new Map();
const userCache = { value: null, at: 0 };

const SECURITY_HEADERS = {
  'X-Content-Type-Options': 'nosniff',
  'X-Frame-Options': 'DENY',
  'Referrer-Policy': 'strict-origin-when-cross-origin',
  'Permissions-Policy': 'camera=(), microphone=(), geolocation=()'
};

const LAYOUT_COLORS = [
  { name: 'Mavi', color: 'blue', hex: '#dcecf8' },
  { name: 'Yaşıl', color: 'green', hex: '#e8f1ec' },
  { name: 'Sarı', color: 'yellow', hex: '#fff1d6' },
  { name: 'Narıncı', color: 'orange', hex: '#fde6cf' },
  { name: 'Qırmızı', color: 'red', hex: '#fce9e7' },
  { name: 'Bənövşəyi', color: 'purple', hex: '#efe7ff' },
  { name: 'Boz', color: 'gray', hex: '#e2e8f0' }
];
const layoutColorSchemaFlights = new Map();
const layoutColorSchemaReady = new Set();

// A calendar range lives in the existing Notion Tarix date property; no separate timer or estimate.

// Deletion is idempotent, but only after Notion confirms this page is archived.
// Never unarchive a page, retry another write, or treat permission errors as success.

let personalTasksCache = null;
let personalTasksCacheAt = 0;
let personalTasksInFlight = null;
let personalTasksGeneration = 0;
let personalTasksInFlightGeneration = -1;
const personalRaw={tasks:new Map(),containers:new Map(),cursors:{}};

const cacheHealth={kind:typeof fs.snapshotBatch==='function'?'sqlite':'json',restored:false,error:''};

restoreRawSnapshotCache();

// Only independent personal tasks require a container. Subtasks may remain containerless.

const personalContainerRepairs=new Set();let personalContainerRepairQueue=Promise.resolve();

const autosaveCreates=new Map();

const {TaskManagementStore}=require('./task-management');
const taskManagement=new TaskManagementStore(process.env.TASK_MANAGEMENT_FILE||path.join(process.env.POMODORO_STATE_FILE?path.dirname(process.env.POMODORO_STATE_FILE):path.join(__dirname,'data'),'task-management.json'));
let personalStatusWriteQueue=Promise.resolve();

const {SharedPomodoroStore,timerFromTask}=require('./pomodoro-shared');
const pomodoroStateDirectory=process.env.RAILWAY_PROJECT_ID?'/data':path.join(__dirname,'data');
const legacyPomodoroStateFile=path.join(__dirname,'data','pomodoro-state.json');
const persistentPomodoroStateFile=process.env.POMODORO_STATE_FILE||path.join(pomodoroStateDirectory,'pomodoro-state.json');
if(!process.env.POMODORO_STATE_FILE&&process.env.RAILWAY_PROJECT_ID&&!fs.existsSync(persistentPomodoroStateFile)&&fs.existsSync(legacyPomodoroStateFile)){
 fs.mkdirSync(path.dirname(persistentPomodoroStateFile),{recursive:true});
 fs.copyFileSync(legacyPomodoroStateFile,persistentPomodoroStateFile);
}
const sharedPomodoro=new SharedPomodoroStore(persistentPomodoroStateFile);
const {PomodoroSessions}=require('./pomodoro-sessions');
const {TimerSessionLog}=require('./timer-session-log');
const timerSessionLog=new TimerSessionLog({notion,queryDatabase,dataSourceId:TIMER_SESSIONS_DS});
let notionPomodoroSessionsCache=[],notionPomodoroSessionsAt=0,notionPomodoroSessionsPromise=null;

const browserPomodoroSessions=new PomodoroSessions({store:sharedPomodoro,loadTask:async id=>mapPersonalTask(await notion('/pages/'+encodeURIComponent(id),{method:'GET'})),patchTask:async(id,properties)=>{await notion('/pages/'+encodeURIComponent(id),{method:'PATCH',body:JSON.stringify({properties})});if(taskEstimateModule.validMinutes(properties[taskEstimateModule.FIELD]?.number)){taskManagement.update({type:'estimate',id,minutes:properties[taskEstimateModule.FIELD].number});snapshotCache=null;taskCache.clear();}invalidatePersonalTasks();},saveSession:async session=>{const result=await timerSessionLog.record(session);notionPomodoroSessionsAt=0;return result;},authorizeOther:async(u,id)=>{if(u&&u.role!=='admin')await accountTask(u,id)},changed:()=>{if(typeof realtime!=='undefined')realtime.invalidate(['pomodoro','personal'])}});
const legacyPomodoroCutoff=Date.now()-7*24*60*60*1000,knownPomodoroSessionIds=new Set(sharedPomodoro.sessions.map(session=>session.id));
let legacyPomodoroSessionsAdded=0;
for(const timer of sharedPomodoro.timers.values()){
 const startedAt=Date.parse(timer.startedAt||''),endedAt=Date.parse(timer.completedAt||'');
 if(timer.status!=='completed'||timer.mode==='break'||!timer.sessionId||knownPomodoroSessionIds.has(timer.sessionId)||!Number.isFinite(startedAt)||!Number.isFinite(endedAt)||endedAt<legacyPomodoroCutoff)continue;
 const plannedMinutes=Math.max(1,Math.round(Number(timer.plannedDuration||timer.duration)||25)),seconds=Math.max(0,Math.min(plannedMinutes*60,(endedAt-startedAt)/1000));
 const session={id:timer.sessionId,taskId:timer.id,title:timer.title||'Pomodoro',sourceKey:'personal',kind:'pomodoro',mode:'work',actorId:timer.actorId||'unidentified',worker:timer.worker||'İstifadəçi',status:'saved',startedAt,endedAt,seconds,plannedMinutes,fullPomodoro:timer.completionReason!=='early'&&seconds>=plannedMinutes*60,completionReason:timer.completionReason||'elapsed',startOperation:timer.startOperation||'',notionLogEligible:true,notionSyncPending:true,legacyBackfill:true};
 sharedPomodoro.commit(null,session,null);knownPomodoroSessionIds.add(timer.sessionId);legacyPomodoroSessionsAdded++;
}
setInterval(()=>void browserPomodoroSessions.retryDue().catch(e=>console.warn('Pomodoro session retry deferred:',e.message)),60000).unref();
if(legacyPomodoroSessionsAdded)void browserPomodoroSessions.retryDue().catch(e=>console.warn('Pomodoro session backfill deferred:',e.message));
let pomodoroRefreshAt=0,pomodoroRefreshPromise=null;

const personalPomodoroLocks = new Map();

const realtime=new RealtimeHub({origin:CORS_ORIGIN,pollMs:EXTERNAL_SYNC_MS,
 load:async scope=>scope==='pomodoro'?await sharedPomodoroSnapshot():scope==='personal'?withTaskEstimates(await personalSnapshot(false,false)):scope==='equipment'?withTaskEstimates(await snapshot(false,normalizeBaseUrl(PUBLIC_APP_URL),false)):{ok:true,...managementSnapshotWithTaskEstimates()},
 local:async scope=>scope==='pomodoro'?sharedPomodoro.snapshot():scope==='personal'?realtimePersonal():scope==='equipment'?withTaskEstimates(buildSnapshotFromRawCache(normalizeBaseUrl(PUBLIC_APP_URL))):{ok:true,...managementSnapshotWithTaskEstimates()}
});

const {WorkTimerStore}=require('./work-timer');
const workTimer=new WorkTimerStore({file:path.join(path.dirname(accounts.file||process.env.ADIB_ACCOUNTS_FILE||process.env.TASK_MANAGEMENT_FILE||path.join(__dirname,'data','accounts.json')),'work-sessions.json'),now:()=>networkTime.snapshot().now??NaN,notion,saveSession:session=>timerSessionLog.record(session),deleteSession:session=>timerSessionLog.remove(session),sources:()=>[{key:'todo',ds:TODO_DS,db:TODO_DB},{key:'gorulen',ds:GORULEN_DS,db:GORULEN_DB}],changed:()=>{try{realtime.send('work-changed',{revision:workTimer.data.revision});}catch{}}});

const workFlush=setInterval(()=>void workTimer.flush().catch(e=>console.warn('Work timer sync:',e.message)),30000);workFlush.unref();

const server = http.createServer(async (request, response) => {
  try {
    if (request.method === 'OPTIONS') {
      response.writeHead(204, { 'Access-Control-Allow-Origin': CORS_ORIGIN, 'Access-Control-Allow-Methods': 'GET, POST, PATCH, DELETE, OPTIONS', 'Access-Control-Allow-Headers': 'Content-Type, Authorization', ...SECURITY_HEADERS });
      return response.end();
    }
    const url = new URL(request.url, 'http://localhost');
    await accounts.ready;
    if(employeeChats.routes(url.pathname))return json(response,200,await employeeChats.handle(request,url,request.method==='GET'?{}:await readBody(request)));
    if(url.pathname.startsWith('/api/auth/')||url.pathname.startsWith('/api/admin/')){
      const verbs={'/api/auth/status':['GET'],'/api/auth/me':['GET'],'/api/auth/login':['POST'],'/api/auth/accept':['POST'],'/api/auth/password':['POST'],'/api/auth/logout':['POST'],'/api/admin/users':['GET','PATCH','DELETE'],'/api/admin/invites':['POST','DELETE'],'/api/admin/personal-directory':['GET']};
      if(!verbs[url.pathname]?.includes(request.method))throw accessError('Metod icazə verilmir',405);
      if(request.headers.origin&&request.headers.origin!=='null'&&!request.headers.authorization){const o=new URL(request.headers.origin);if(o.host!==request.headers.host&&!['adib:'].includes(o.protocol))throw accessError('Yanlış sorğu mənbəyi');}
      const body=request.method==='GET'?{}:await readBody(request);
      if(url.pathname==='/api/admin/personal-directory'){const admin=accounts.user(request);accounts.requireAdmin(admin);return json(response,200,{ok:true,employees:await personalDirectory()});}
      if((url.pathname==='/api/admin/invites'&&request.method==='POST'||url.pathname==='/api/admin/users'&&request.method==='PATCH')&&body.personalPageId){const id=cleanId(String(body.personalPageId));if(!id||!(await personalDirectory()).some(person=>person.id===id))throw accessError('İşçi Personal bazasında tapılmadı',400);const mapped=accounts.state.users.find(item=>item.id!==body.id&&!item.disabled&&cleanId(item.personalPageId)===id),invited=accounts.state.invites.find(item=>!item.used&&item.expires>accounts.now()&&cleanId(item.personalPageId)===id);if(mapped||invited)throw accessError('Bu Personal profili artıq ADIB istifadəçisinə və ya dəvətə bağlanıb',409);body.personalPageId=id;}
      const result=await accounts.route(request,url.pathname,body);
      const secure=process.env.ADIB_COOKIE_SECURE!=='0';
      const cookie=result.token?'adib_session='+result.token+'; Path=/; HttpOnly; SameSite=Strict; Max-Age=2592000'+(secure?'; Secure':''):url.pathname==='/api/auth/logout'?'adib_session=; Path=/; HttpOnly; SameSite=Strict; Max-Age=0'+(secure?'; Secure':''):null;
      return json(response,200,result,cookie?{'Set-Cookie':cookie}:{});
    }
    if(accounts.enabled&&url.pathname.startsWith('/api/')&&!['/api/health','/api/time'].includes(url.pathname)){
      const u=accounts.user(request);
      if(!['GET','HEAD'].includes(request.method)&&request.headers.origin&&!request.headers.authorization){const o=new URL(request.headers.origin);if(o.host!==request.headers.host&&o.protocol!=='adib:')throw accessError('Yanlış sorğu mənbəyi');}
      const b=['GET','HEAD'].includes(request.method)?{}:await readBody(request);request.__accountBody=b;Object.defineProperty(b,'__account',{value:u,enumerable:false});await accountAuthorize(request,response,url,u,b);accounts.user(request);
    }
    if(url.pathname==='/account.html')return file(response,path.join(__dirname,'account.html'),'text/html; charset=utf-8','no-store',request);
    if(accounts.enabled&&(url.pathname==='/'||url.pathname==='/ela-nov-paketleme-dynamic.html')){try{accounts.user(request)}catch{return file(response,path.join(__dirname,'account.html'),'text/html; charset=utf-8','no-store',request);}}
    response.__realtimeScopes=mutationScopes(request.method,url.pathname);
    if(request.method==='GET'&&url.pathname==='/api/events')return realtime.connect(request,response,(url.searchParams.get('scopes')||'personal,equipment,management').split(','))||json(response,400,{error:'Unknown scopes'});
    if(request.method==='GET'&&url.pathname==='/api/realtime/state')return json(response,200,await realtime.read(url.searchParams.get('scope')||'personal',url.searchParams.get('revision'),url.searchParams.get('epoch')));
    if(request.method==='GET'&&url.pathname==='/api/realtime/status')return json(response,200,{enabled:true,transport:'sse',externalPollMs:realtime.pollMs});
    if(url.pathname==='/api/user/preferences'){
      const actor=request.__accountBody?.__account||accounts.user(request);
      if(request.method==='GET')return json(response,200,await userPreferences.get(actor));
      if(request.method==='PUT')return json(response,200,await userPreferences.put(actor,request.__accountBody?.settings));
      throw accessError('Metod icazə verilmir',405);
    }
    if(request.method==='GET'&&url.pathname==='/api/time'){const began=performance.now();await networkTime.sync(url.searchParams.get('force')==='1');const result=networkTime.snapshot();return json(response,result.trusted?200:503,{...result,processingMs:performance.now()-began});}

    // Content-addressed public UI code; private HTML/API responses remain no-store.

    if(['GET','HEAD'].includes(request.method)&&publicAssets.has(url.pathname.slice(1))){
      if(uiAssets.serve(request,response,url,SECURITY_HEADERS))return;
      const types={'.js':'text/javascript; charset=utf-8','.css':'text/css; charset=utf-8','.png':'image/png','.svg':'image/svg+xml','.webmanifest':'application/manifest+json'};
      return file(response,path.join(__dirname,url.pathname.slice(1)),types[path.extname(url.pathname)]||'application/octet-stream','no-store');
    }
    if(request.method==='GET'&&url.pathname==='/version.json')return json(response,200,{version:'1.1.64',calendarVersion:'1.1.64',dateRange:true,queryFixBuild:QUERY_FIX_BUILD});

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
    if (request.method === 'PATCH' && url.pathname === '/api/layout-color') {
      const body = await readBody(request);
      return json(response, 200, await saveLayoutColor(body));
    }
    if (request.method === 'GET' && url.pathname === '/api/task-comments') {
      return json(response, 200, await listTaskComments({ id: url.searchParams.get('id') }));
    }
    if(request.method==='GET'&&url.pathname==='/api/team-snapshot')return json(response,200,await teamSnapshot(request));
    if(request.method==='GET'&&url.pathname==='/api/work-state'){await workClock();const actor=workActor(request);if(url.searchParams.get('revision')===String(workTimer.data.revision))return json(response,200,{ok:true,unchanged:true,revision:workTimer.data.revision,serverNow:networkTime.snapshot().now});if(!rawCache.lastSyncAt)void snapshot(false).catch(e=>console.warn('Work background snapshot:',e.message));let tasks=workTasks(actor);if(actor.role!=='admin')for(const session of workTimer.data.sessions.filter(s=>s.actorId===actor.id&&s.status!=='saved'))if(!tasks.some(t=>accountKey(t.id)===accountKey(session.taskId)))try{tasks.push((await workAccountTask(actor,session.taskId)).task);}catch(e){if(e.statusCode!==403)throw e;}const ids=new Set(tasks.map(t=>accountKey(t.id)));return json(response,200,{...workTimer.snapshot(actor,id=>actor.role==='admin'||ids.has(accountKey(id))),tasks,tasksLoading:!rawCache.lastSyncAt,actor:{id:actor.id,name:actor.name,assignee:actor.assignee,role:actor.role}});}
    if(request.method==='POST'&&url.pathname==='/api/work-schema')return json(response,200,await workTimer.setup(workActor(request)));
    if(request.method==='POST'&&url.pathname==='/api/work-timer'){await workClock();const b=await readBody(request),actor=workActor(request);let task,prepared;if(b.action==='start'||b.action==='continue'){const target=b.action==='start'?b.id:workTimer.data.sessions.find(s=>s.id===b.sessionId)?.taskId;const found=request.__workTarget||await workAccountTask(actor,target);task=found.task;prepared=found.prepared;}const result=await workTimer.action(b,actor,task,prepared);if(b.action==='save'||b.action==='continue'||b.action==='cancel'||b.action==='delete')void workTimer.flush().catch(()=>{});return json(response,200,{...result,serverNow:networkTime.snapshot().now,revision:workTimer.data.revision});}
    if(request.method==='GET'&&url.pathname==='/api/task-photos')return json(response,200,await taskPhotos.load(url.searchParams.get('id'),{force:url.searchParams.get('refresh')==='1'}));
    if(request.method==='POST'&&url.pathname==='/api/task-photo-schema')return json(response,200,await taskPhotos.schema(await readBody(request)));
    if(request.method==='POST'&&url.pathname==='/api/task-photo')return json(response,200,await taskPhotos.change(await readBody(request),ensureUploadedImage));
    if(request.method==='POST'&&url.pathname==='/api/image-upload')return json(response,201,await uploadTaskImageFile(await readBody(request)));
    if(request.method==='GET'&&url.pathname==='/api/task-images')return json(response,200,await listTaskImages(url.searchParams.get('id')));
    if(request.method==='POST'&&url.pathname==='/api/task-image'){const body=await readBody(request);if(body.remove)return json(response,200,await deleteTaskImage(body));return json(response,201,await attachTaskImage(body));}
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
    if(request.method==='GET'&&url.pathname==='/api/calendar-capabilities')return json(response,200,{ok:true,dateRange:true,defaultMinutes:30,stepMinutes:15,version:'1.1.64'});
    if (request.method === 'GET' && url.pathname === '/api/personal-snapshot') {
      const explicit=url.searchParams.get('force')==='1'||url.searchParams.get('refresh')==='1'||url.searchParams.get('retry')==='1';if(!explicit&&realtime.state('personal').loaded)return json(response,200,realtimePersonal());const data=withTaskEstimates(await personalSnapshot(url.searchParams.get('force')==='1',explicit,url.searchParams.get('retry')==='1'));if(!data.sync?.partial)realtime.publish('personal',data);return json(response,200,data);
    }
    if (request.method === 'GET' && url.pathname === '/api/task-management') {
      try{await personalSnapshot(false);}catch(error){console.warn('Personal estimate sync is temporarily unavailable:',error.message);}
      return json(response,200,{ok:true,...managementSnapshotWithTaskEstimates()});
    }
    if (request.method === 'POST' && url.pathname === '/api/task-management') {
      const command=await readBody(request);
      if(command.type==='estimate'){
        validateTaskEstimate({estimateMinutes:command.minutes});
        await taskEstimates.save('personal',command.id,command.minutes);
      }
      const updated=taskManagement.update(command);
      if(command.type==='estimate'){snapshotCache=null;invalidatePersonalTasks();taskCache.clear();}
      return json(response,200,{ok:true,...updated});
    }
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
      if(['start','open'].includes(body.action)&&accountTasks().equipment.some(t=>accountKey(t.id)===accountKey(body.id)))throw Object.assign(new Error('Bu tapşırıqda İş taymerindən istifadə edin; tətbiqi yeniləyin'),{statusCode:409,code:'WORK_TIMER_REQUIRED'});
      return json(response, 200, await savePersonalPomodoro(body));
    }
    if (request.method === 'PATCH' && url.pathname === '/api/task') {
      const body = await readBody(request);
      return json(response, 200, await saveTask(body, appBaseUrl(request)));
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
    if (request.method === 'GET' && url.pathname === '/api/task-options') return json(response, 200, await taskFieldOptions(url.searchParams.get('source')||'',url.searchParams.get('refresh')==='1'));
    if (request.method === 'GET' && url.pathname === '/api/users') return json(response, 200, { users: await notionUsers() });
    if (request.method === 'POST' && url.pathname === '/api/sync-links') {
      return json(response, 200, await syncServiceLinks(appBaseUrl(request), true));
    }
    if (url.pathname === '/api/health') return json(response, 200, {ok:true,time:new Date().toISOString(),queryFixBuild:QUERY_FIX_BUILD,externalSyncMs:EXTERNAL_SYNC_MS,queryMetrics:{...queryMetrics,...queryPolicy.stats},commentCache:{...commentReads.stats},authorCache:{...authorReads.stats}});
    if (url.pathname === '/api/plan-snapshot') { const full = url.searchParams.get('full') === '1' || url.searchParams.get('force') === '1'; const baseUrl = appBaseUrl(request); const explicit=full||url.searchParams.get('refresh')==='1'||url.searchParams.get('retry')==='1';const result=withTaskEstimates(!explicit&&realtime.state('equipment').loaded?buildSnapshotFromRawCache(baseUrl):await snapshot(full,baseUrl,explicit,url.searchParams.get('retry')==='1'));if(!result.sync?.partial)realtime.publish('equipment',result);const layoutRevision=crypto.createHash('sha1').update(JSON.stringify([...(result.plans||[]),...(result.equipment||[])].map(item=>[item.id,item.x,item.y,item.width,item.height,item.parentId,item.planId,item.color]))).digest('hex');result.etag='"'+crypto.createHash('sha1').update(String(result.etag||'')+':'+taskManagement.snapshot().revision+':'+layoutRevision).digest('hex')+'"'; if(process.env.ADIB_AUTO_SYNC_LINKS!=='0')syncServiceLinks(baseUrl).catch(error => console.warn('Service link sync failed:', error.message)); if (!full && result.etag && request.headers['if-none-match'] === result.etag) { response.writeHead(304, { 'ETag': result.etag, 'Cache-Control': 'no-cache', 'Access-Control-Allow-Origin': CORS_ORIGIN, 'Access-Control-Allow-Headers': 'Content-Type, If-None-Match, Authorization', ...SECURITY_HEADERS }); return response.end(); } return json(response, 200, result, result.etag ? { 'ETag': result.etag } : {}); }
    if (url.pathname === '/manifest.webmanifest') return file(response, path.join(__dirname, 'manifest.webmanifest'), 'application/manifest+json; charset=utf-8', 'no-cache');
    if (url.pathname === '/sw.js') return file(response, path.join(__dirname, 'sw.js'), 'application/javascript; charset=utf-8', 'no-cache');
    if (url.pathname === '/icons/icon-192.png') return file(response, path.join(__dirname, 'icons/icon-192.png'), 'image/png', 'public, max-age=31536000, immutable');
    if (url.pathname === '/icons/icon-512.png') return file(response, path.join(__dirname, 'icons/icon-512.png'), 'image/png', 'public, max-age=31536000, immutable');
    if (url.pathname === '/' || url.pathname === '/ela-nov-paketleme-dynamic.html') return file(response, path.join(__dirname, 'ela-nov-paketleme-dynamic.html'),'text/html; charset=utf-8','no-store',request);
    return json(response, 404, { error: 'Not found' });
  } catch (error) {
    if (error.statusCode && error.statusCode < 500) console.warn('Request rejected:', error.message);
    else console.error(error);
    return json(response, error.statusCode || 500, { error: error.message, ...(error.code?{code:error.code}:{}),...(error.confirmationToken?{confirmationToken:error.confirmationToken}:{}), ...(error.createdTaskId?{createdTaskId:error.createdTaskId}:{}), ...(error.limit?{limit:error.limit,activeCount:error.activeCount}:{}) });
  }
});
server.on?.('close',()=>realtime.close());
setInterval(()=>void browserPomodoroSessions.finishExpired().catch(e=>console.warn('Pomodoro expiry check deferred:',e.message)),5000).unref();
server.listen(PORT, () => console.log('ADIB Online 1.1.64: http://localhost:'+server.address().port));
