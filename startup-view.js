(function(root){'use strict';
 function shouldOpenMyTasks(href,desktop){
  if(!desktop)return false;
  try{const url=new URL(href),hash=new URLSearchParams(url.hash.slice(1));return !hash.get('id')&&!url.searchParams.has('id')&&!url.searchParams.has('element')&&!url.searchParams.has('mode')&&url.searchParams.get('action')!=='quick-add-task'}catch{return false}
 }
 function openStartupView(){
  if(!shouldOpenMyTasks(root.location.href,root.ADIBDesktop))return;
  // Do not wait for settings, equipment or Notion. The existing entry point restores
  // the local task snapshot synchronously and refreshes it in the background.
  if(typeof root.__adibOpenDefaultMyTasksList==='function')Promise.resolve(root.__adibOpenDefaultMyTasksList()).catch(error=>console.warn('ADIB My Tasks startup:',error));
 }
 if(typeof module==='object'&&module.exports)module.exports={shouldOpenMyTasks};
 else if(root.document.readyState==='loading')root.document.addEventListener('DOMContentLoaded',openStartupView,{once:true});
 else openStartupView();
})(typeof globalThis==='object'?globalThis:this);
