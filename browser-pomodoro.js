/* Browser-only floating Pomodoro. Reuses local timer state/actions; no fetch/poll loop. */
(function(root){'use strict';
const STYLE=`:root{color-scheme:dark;font-family:system-ui,-apple-system,'Segoe UI',sans-serif;background:#1c2431;color:#eef2fa}*{box-sizing:border-box}body{margin:0;padding:20px;min-width:240px}header{display:flex;align-items:center;justify-content:space-between;gap:8px;font-size:14px;color:#b9c5d6}header strong{color:#eef2fa;font-weight:600}button{font:inherit;border:1px solid #536580;border-radius:10px;background:#303e50;color:#eef2fa;min-height:44px;padding:8px 12px;cursor:pointer}button:focus-visible{outline:3px solid #a6bcff;outline-offset:3px}button:disabled{opacity:.55;cursor:default}h1{font-size:17px;line-height:1.4;font-weight:500;margin:16px 0 4px;overflow-wrap:anywhere}.clock{font-size:clamp(44px,16vw,64px);font-weight:400;letter-spacing:1px;font-variant-numeric:tabular-nums;line-height:1.15;margin:14px 0}.status,.stats,.hint{font-size:14px;line-height:1.5;color:#b9c5d6;margin:4px 0}.actions{display:flex;gap:8px;margin-top:16px}.actions button{flex:1}.primary{background:#a6bcff;color:#172335;border-color:#a6bcff;font-weight:600}.error{font-size:14px;line-height:1.5;color:#ffb5b5;overflow-wrap:anywhere;margin:12px 0 0}.hint{font-size:14px;margin-top:12px}.compact{padding:12px}.compact h1{font-size:14px;margin:10px 0 0}.compact .clock{font-size:42px;margin:6px 0}.compact .stats,.compact .hint{display:none}.compact .actions{margin-top:8px}`;
const MARKUP=`<header><strong>Pomodoro</strong><button type="button" id="compact" aria-label="Yığcam görünüş" title="Yığcam görünüş">↕</button></header><h1 id="task"></h1><p class="status" id="mode"></p><div class="clock" id="clock" role="timer" aria-label="Qalan vaxt">25:00</div><p class="stats" id="stats"></p><div class="actions"><button type="button" class="primary" id="toggle">Başlat</button><button type="button" id="return">ADIB</button></div><p class="error" id="error" role="status"></p><p class="hint" id="hint">ADIB səhifəsini açıq saxlayın.</p>`;
function time(seconds){const n=Math.max(0,Math.ceil(Number(seconds)||0));return String(Math.floor(n/60)).padStart(2,'0')+':'+String(n%60).padStart(2,'0')}
function getState(id){return root.ADIBBrowserPomodoro?.state(id)||null}
class Controller{
 constructor(){this.win=null;this.id='';this.timer=null;this.busy=false;this.opening=false;}
 async open(id){
  if(root.ADIBDesktop?.nativePomodoro)throw Error('Windows tətbiqində yerli taymerdən istifadə edin.');
  if(!getState(id))throw Error('Pomodoro tapşırığını seçin.');
  this.id=String(id);if(this.win&&!this.win.closed){this.draw();this.win.focus();return;}
  if(this.opening)return;this.opening=true;let win,kind;
  try{
   if(root.isSecureContext&&root.documentPictureInPicture?.requestWindow){win=await root.documentPictureInPicture.requestWindow({width:340,height:370});kind='pip';}
   else{win=root.open('about:blank','ADIB-Pomodoro','popup=yes,width=360,height=400');kind='popup';if(!win)throw Error('Açılan pəncərə bloklandı. Bu sayt üçün pop-up icazəsi verin.');}
   this.win=win;this.kind=kind;this.mount();
  }finally{this.opening=false;}
 }
 mount(){const win=this.win,doc=win.document;doc.title='ADIB · Pomodoro';doc.documentElement.lang='az';doc.body.replaceChildren();const style=doc.createElement('style');style.textContent=STYLE;doc.head.append(style);doc.body.innerHTML=MARKUP;
  doc.getElementById('toggle').onclick=()=>this.toggle();
  doc.getElementById('return').onclick=()=>{root.focus();root.ADIBBrowserPomodoro?.openTask(this.id);};
  doc.getElementById('compact').onclick=()=>{doc.body.classList.toggle('compact');doc.getElementById('compact').setAttribute('aria-pressed',String(doc.body.classList.contains('compact')))};
  doc.getElementById('hint').textContent=this.kind==='pip'?'ADIB səhifəsini açıq saxlayın.':'Adi pəncərədir — həmişə üstdə qalması zəmanətli deyil.';
  win.addEventListener('pagehide',()=>this.cleanup(win),{once:true});
  this.timer=win.setInterval(()=>{if(win.closed){this.cleanup(win);return;}root.ADIBBrowserPomodoro?.tick();this.draw();},1000);this.draw();
 }
 cleanup(win){if(this.win!==win)return;win.clearInterval(this.timer);this.timer=null;this.win=null;this.busy=false;}
 draw(){const win=this.win;if(!win||win.closed)return;const doc=win.document,s=getState(this.id),b=doc.getElementById('toggle');if(!s){doc.getElementById('task').textContent='Tapşırıq mövcud deyil';doc.getElementById('clock').textContent='—';b.disabled=true;return;}
  doc.getElementById('task').textContent=s.title;doc.getElementById('clock').textContent=time(s.remaining);
  doc.getElementById('mode').textContent=(s.isBreak?'Fasilə':'İş')+' · '+(s.running?'Davam edir':s.status==='completed'?'Tamamlandı':s.status==='paused'?'Dayandırılıb':'Hazırdır');
  doc.getElementById('stats').textContent=s.count+' pomodoro · '+Math.round(s.minutes)+' dəq';b.textContent=s.running?'Pauza':s.status==='paused'?'Davam et':s.isBreak?'Fasiləni başlat':'Başlat';b.disabled=this.busy||!s.trusted||s.finishing;
 }
 async toggle(){if(this.busy)return;const s=getState(this.id);if(!s?.trusted)return;this.busy=true;const doc=this.win?.document;if(doc)doc.getElementById('error').textContent='';this.draw();try{await root.ADIBBrowserPomodoro.action(this.id,s.running?'pause':'start')}catch(e){if(this.win&&!this.win.closed)this.win.document.getElementById('error').textContent=e.message||'Sinxronlaşdırmaq alınmadı.';}finally{this.busy=false;this.draw();}}
 close(){const win=this.win;if(win){win.close();this.cleanup(win)}}
}
const controller=new Controller();root.ADIBPomodoroWindow={open:id=>controller.open(id),close:()=>controller.close(),get isOpen(){return !!controller.win&&!controller.win.closed}};
function enhance(){if(root.ADIBDesktop?.nativePomodoro)return;for(const host of root.document.querySelectorAll('.personal-pomodoro-head,.personal-pomodoro-overlay')){
 if(host.querySelector('[data-browser-pomodoro]'))continue;const modal=host.closest('.personal-pomodoro-modal');const id=modal?.dataset.taskId||host.dataset.taskId||root.ADIBBrowserPomodoro?.activeId();if(!id)continue;
 const b=root.document.createElement('button');b.type='button';b.dataset.browserPomodoro='1';b.textContent='Ayrı pəncərə';b.title='Pomodoro ayrı pəncərədə';b.setAttribute('aria-label','Pomodoro ayrı pəncərədə');b.style.cssText='flex:none;min-height:44px;padding:8px 12px;font-size:14px;border-radius:10px';b.onclick=e=>{e.preventDefault();e.stopPropagation();controller.open(id).catch(error=>root.alert(error.message))};host.append(b);
 }}
if(root.document){let scheduled=false;const schedule=()=>{if(scheduled)return;scheduled=true;root.requestAnimationFrame(()=>{scheduled=false;enhance()})};new root.MutationObserver(schedule).observe(root.document.body,{childList:true,subtree:true});enhance();root.addEventListener('pagehide',()=>controller.close());}
if(typeof module==='object'&&module.exports)module.exports={time,Controller,STYLE,MARKUP};
})(typeof window==='object'?window:globalThis);
