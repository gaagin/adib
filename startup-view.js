/* Open the current workspace before equipment/Notion requests finish. */
(function(root){'use strict';
 function shouldOpenMyTasks(href,enabled=true){
  if(!enabled)return false;
  try{const url=new URL(href);return !url.hash&&!url.searchParams.has('id')&&!url.searchParams.has('element')&&!url.searchParams.has('mode')&&url.searchParams.get('action')!=='quick-add-task'}catch{return false}
 }
 if(typeof module==='object'&&module.exports){module.exports={shouldOpenMyTasks};return;}
 function finish(){root.document.documentElement.classList.remove('adib-starting');root.document.getElementById('adibBootStatus')?.remove();}
 function failed(error){console.warn('ADIB workspace startup:',error);const box=root.document.getElementById('adibBootStatus');if(box){box.querySelector('h2').textContent='Не удалось открыть рабочее пространство';box.querySelector('p').textContent='Проверьте соединение и повторите загрузку. Данные задач не изменены.';box.querySelector('button').hidden=false;}}
 function openStartupView(){
  if(!shouldOpenMyTasks(root.location.href)){finish();return;}
  try{
   // The shell opens synchronously from the saved snapshot. Its refresh is background work.
   if(!root.ADIBHome?.open||!root.ADIBHomeBridge)throw Error('Workspace assets are unavailable');
   Promise.resolve(root.ADIBHome.open()).then(finish,failed);
  }catch(error){failed(error);}
 }
 if(root.document.readyState==='loading')root.document.addEventListener('DOMContentLoaded',openStartupView,{once:true});else openStartupView();
})(typeof globalThis==='object'?globalThis:this);
