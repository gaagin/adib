/* Runs before workspace scripts; private APIs still wait for verified identity. */
(function(root){'use strict';
const original=root.fetch.bind(root),authProgress=root.ADIBLoading?.screen();
const cachedOwner=(()=>{try{return !!root.localStorage.getItem('adib-account-owner')}catch{return false}})();
let identity=null,redirecting=false,enabled=null,ready=null,retryTimer=null;
if(!cachedOwner)root.document.documentElement.style.visibility='hidden';

const go=()=>{if(redirecting)return;redirecting=true;try{root.localStorage.clear()}catch{}root.location.replace('/account.html');};
async function authenticate(){
 const controller=new AbortController(),timeout=setTimeout(()=>controller.abort(),10000);
 try{
  const response=await original('/api/auth/me',{cache:'no-store',signal:controller.signal});
  let data;try{data=await response.json()}catch{data={}}
  if(!response.ok){go();throw Error('Hesabınıza daxil olun');}
  enabled=!!data.enabled;
  if(!enabled){root.document.documentElement.style.visibility='';return null;}
  identity=data.user;
  const owner=identity.id+':'+identity.revision;
  try{
   if(root.localStorage.getItem('adib-account-owner')!==owner){
    root.localStorage.clear();root.localStorage.setItem('adib-account-owner',owner);
    root.location.reload();return new Promise(()=>{});
   }
  }catch{}
  root.ADIBAccount.user=identity;
  root.ADIBAccount.cachedOffline=false;
  root.document.documentElement.style.visibility='';
  if(root.Event)root.dispatchEvent(new root.Event('adib-account-ready'));
  return identity;
 }finally{clearTimeout(timeout);}
}
function scheduleRetry(){
 if(!cachedOwner||redirecting||retryTimer)return;
 retryTimer=setTimeout(()=>{
  retryTimer=null;
  refreshIdentity();
 },15000);
}
function refreshIdentity(){
 ready=authenticate().catch(error=>{
  if(cachedOwner&&!redirecting){
   root.ADIBAccount.cachedOffline=true;
   root.document.documentElement.style.visibility='';
   scheduleRetry();
   return null;
  }
  throw error;
 });
 ready.then(()=>{authProgress?.done();apply();},()=>{
  if(redirecting)return;
  if(cachedOwner){
   root.ADIBAccount.cachedOffline=true;
   root.document.documentElement.style.visibility='';
   authProgress?.done();
   apply();
   scheduleRetry();
  }else authProgress?.fail();
 });
 return ready;
}
refreshIdentity();

root.ADIBAccount={
 get ready(){return ready},
 user:null,
 cachedOwner,
 cachedOffline:false,
 section:s=>enabled===false||(!identity&&cachedOwner)||!!identity&&(identity.role==='admin'||identity.rules.sections.includes(s)),
 action:a=>enabled===false||!!identity&&(identity.role==='admin'||identity.rules.actions.includes(a)),
 open:()=>root.location.href='/account.html'
};
root.fetch=async(input,options)=>{
 const href=typeof input==='string'?input:input.url;let u;
 try{u=new URL(href,root.location.href)}catch{return original(input,options)}
 if(u.origin===root.location.origin&&u.pathname.startsWith('/api/')&&!u.pathname.startsWith('/api/auth/')){
  await ready;
  const response=await original(input,options);
  if(response.status===401)go();
  return response;
 }
 return original(input,options);
};
function apply(){
 if(!identity&&!cachedOwner&&enabled!==false)return;
 if(!root.document.querySelectorAll)return;
 const allowed=root.ADIBAccount.section;
 for(const button of root.document.querySelectorAll('[data-home-nav]')){
  const section=button.dataset.homeNav==='tasks'?'personal':button.dataset.homeNav;
  button.hidden=!allowed(section);button.style.display=allowed(section)?'':'none';
 }
 for(const button of root.document.querySelectorAll('#adibPersistentSide button,.adib-home-tools button')){
  const text=button.textContent.trim();
  const section=text==='Eyzenhauer matrisi'?'matrix':text==='Kanban'||text==='Tapşırıqlarımın təsviri'?'personal':text==='Vidjetlər'?'widgets':text==='Ayarlar'?'settings':null;
  if(section)button.style.display=allowed(section)?'':'none';
 }
 for(const button of root.document.querySelectorAll('#deleteTask,#personalEditorDelete,[data-task-delete]'))button.style.display=root.ADIBAccount.action('delete')?'':'none';
 for(const button of root.document.querySelectorAll('.adib-home-check'))button.disabled=!root.ADIBAccount.action('status');
 for(const button of root.document.querySelectorAll('.adib-home-add'))button.style.display=root.ADIBAccount.action('create')?'':'none';
 const profile=root.document.getElementById('currentUser');
 if(profile){profile.disabled=true;if(identity)profile.title=identity.name;}
 if(identity&&!root.document.getElementById('adibAccountButton')&&root.document.body){
  const button=root.document.createElement('button');button.id='adibAccountButton';button.textContent=identity.name+' · Profil';
  button.style.cssText='position:fixed;bottom:12px;left:12px;z-index:2000;max-width:210px;padding:8px;border-radius:8px;border:1px solid #bccbea;background:var(--surface,#fff);color:inherit';
  button.onclick=root.ADIBAccount.open;root.document.body.append(button);
 }
 if(identity&&typeof currentUser==='object'&&currentUser.name!==identity.name)currentUser={id:identity.id,name:identity.name};
}
let scheduled=false;
const observer=new MutationObserver(()=>{if(scheduled)return;scheduled=true;setTimeout(()=>{scheduled=false;apply()},80)});
const init=()=>{observer.observe(root.document.body,{childList:true,subtree:true});apply();};
if(root.document.readyState==='loading')root.document.addEventListener('DOMContentLoaded',init);else init();
// Recheck periodically to revoke stale views; retry transient cold-start failures for cached users.
async function revalidate(){
 if(root.ADIBIdle?.isIdle?.())return;
 if(!identity){
  if(cachedOwner&&!retryTimer)scheduleRetry();
  return;
 }
 try{
  const response=await original('/api/auth/me',{cache:'no-store'});
  if(!response.ok){go();return;}
  const data=await response.json();
  if(data.user.revision!==identity.revision)go();
  else root.document.documentElement.style.visibility='';
 }catch(error){console.warn('ADIB session check deferred after a temporary connection error:',error);}
}
setInterval(revalidate,30000);
root.addEventListener('adib-network-idle',event=>{if(!event.detail?.idle)revalidate()});
})(window);