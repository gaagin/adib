/* Content-addressed public UI cache, independent of application release numbers. */
const CACHE_NAME='adib-online-ui-content-v1';
const SHELL_CACHE_NAME='adib-online-ui-shell-v2';
const ASSETS=new Set(["loading-ui.js", "loading-ui.css", "discussions-ui.js", "discussions-ui.css", "focused-views.js", "focused-views.css", "local-timer-visibility.js", "network-idle.js", "pomodoro-session-ui.js", "browser-pomodoro.js", "compact-design.css", "compact-design.js", "work-timer-ui.js", "work-timer-ui.css", "az-locale.js", "account-client.js", "autosave.js", "zoned-time.js", "filter-memory.js", "realtime-client.js", "realtime-runtime.js", "filter-dialog.js", "filter-dialog.css", "calendar-time.js", "calendar-filter.js", "calendar-day-plan.js", "calendar-view.css", "calendar-view.js", "comment-state.js", "day-plan-refresh.js", "home-screen.css", "home-screen.js", "hybrid-theme.css", "images.js", "network-time.css", "network-time.js", "personal-options.js", "personal-workspace.js", "pomodoro-rollup.js", "screen-system.css", "screens.js", "startup-view.js", "task-cards.css", "task-cards.js", "task-history.js", "task-tabs.css", "task-tabs.js", "task-concept.css", "task-concept.js", "notion-date-picker.css", "notion-date-picker.js", "elegant-ui.css", "elegant-ui.js", "ui-system.css", "ui-theme.js", "widget-hub.js", "workspace-headers.css", "workspace-headers.js"]);
self.addEventListener('install',event=>event.waitUntil(self.skipWaiting()));
const ACTIVE_CACHES=new Set([CACHE_NAME,SHELL_CACHE_NAME]);
function isAppNavigation(request,url){return request.method==='GET'&&request.mode==='navigate'&&url.origin===self.location.origin&&(url.pathname==='/'||url.pathname==='/ela-nov-paketleme-dynamic.html')}
async function refreshShell(cache,request){
 const response=await fetch(request);
 if(response.ok&&String(response.headers.get('Content-Type')||'').includes('text/html')){
  try{
   // Never cache sign-in pages or user-specific/API responses as the application shell.
   const html=await response.clone().text();
   if(html.includes('id="adibBootStatus"')){
    await cache.put(request,response.clone());
    const keys=await cache.keys();
    for(const key of keys.slice(0,Math.max(0,keys.length-6)))await cache.delete(key);
   }
  }catch(error){console.warn('ADIB shell cache update skipped:',error)}
 }
 return response;
}
self.addEventListener('activate',event=>event.waitUntil(caches.keys().then(keys=>Promise.all(keys.filter(k=>k.startsWith('adib-online-')&&!ACTIVE_CACHES.has(k)).map(k=>caches.delete(k)))).then(()=>self.clients.claim())));
self.addEventListener('fetch',event=>{const u=new URL(event.request.url);if(event.request.method!=='GET'||u.origin!==self.location.origin)return;
 if(isAppNavigation(event.request,u)){
  const shellCache=caches.open(SHELL_CACHE_NAME);
  // Prefer the current app shell whenever online; keep the cached shell as an
  // offline fallback so a stale UI does not remain visible after deployments.
  const update=shellCache.then(cache=>refreshShell(cache,event.request)).catch(()=>null);
  event.waitUntil(update.then(()=>undefined));
  event.respondWith((async()=>{
   const fresh=await update;
   if(fresh?.ok)return fresh;
   const cache=await shellCache;
   const cached=await cache.match(event.request,{ignoreSearch:true});
   if(cached)return cached;
   if(fresh)return fresh;
   return new Response('Application shell is not available offline. Reconnect and retry.',{status:503,headers:{'Content-Type':'text/plain; charset=utf-8'}});
  })());
  return;
 }
 if(!ASSETS.has(u.pathname.slice(1))||!/^([a-f0-9]{20})$/.test(u.searchParams.get('asset')||''))return;
 event.respondWith((async()=>{let cache;try{cache=await caches.open(CACHE_NAME);const hit=await cache.match(event.request);if(hit)return hit;}catch{}const response=await fetch(event.request);if(cache&&response.ok&&response.headers.get('X-ADIB-Asset-Revision')===u.searchParams.get('asset')){const copy=response.clone();event.waitUntil((async()=>{try{await cache.put(event.request,copy);const keys=await cache.keys();for(const key of keys.slice(0,Math.max(0,keys.length-200)))await cache.delete(key);}catch{}})());}return response;})());
});
