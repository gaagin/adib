/* Browser-only floating Pomodoro. Reuses local timer state/actions; no fetch/poll loop. */
(function(root){'use strict';
const STYLE=`:root{color-scheme:dark;font-family:system-ui,-apple-system,'Segoe UI',sans-serif;background:#1c2431;color:#eef2fa}*{box-sizing:border-box}body{margin:0;padding:16px;min-width:220px}header{display:flex;align-items:center;gap:8px}button{font:inherit;font-size:14px;border:1px solid #536580;border-radius:8px;background:#303e50;color:#eef2fa;min-height:44px;padding:8px 12px;cursor:pointer}button:focus-visible{outline:3px solid #a6bcff;outline-offset:2px}button:disabled{opacity:.55;cursor:default}#task{flex:1;min-width:0;background:transparent;border:0;padding:0;text-align:left;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;font-weight:500}#compact{flex:none;width:44px;padding:8px}.clock{font-size:56px;font-weight:400;font-variant-numeric:tabular-nums;line-height:1.1;margin:12px 0}.status,.stats,.hint{font-size:14px;line-height:1.5;color:#b9c5d6;margin:8px 0}.actions{display:flex;gap:8px;margin-top:12px}.actions button{flex:1}.primary{background:#a6bcff;color:#172335;border-color:#a6bcff;font-weight:600}.error{font-size:14px;line-height:1.4;color:#ffb5b5;overflow-wrap:anywhere;margin:12px 0 0}.error:empty{display:none}.hint{margin:12px 0 0}.compact{padding:8px;display:grid;grid-template-columns:minmax(0,1fr) 96px;gap:8px;align-items:center}.compact header{grid-column:1/-1}.compact .clock{font-size:40px;margin:0;line-height:44px}.compact .status,.compact .stats,.compact .hint{display:none}.compact .actions{margin:0;display:block}.compact .actions button{width:100%}.compact #return{display:none}.compact .error{grid-column:1/-1;margin:0}.primary.is-finishing{background:#35425a;border-color:#8094b0;color:#eef2fa}`;
const MARKUP=`<header><button type="button" id="task" title="ADIB · tapşırığı aç"></button><button type="button" id="compact" aria-label="Görünüşü dəyiş" title="Görünüşü dəyiş">↗</button></header><p class="status" id="mode"></p><div class="clock" id="clock" role="timer" aria-label="Qalan vaxt">25:00</div><p class="stats" id="stats"></p><div class="actions"><button type="button" class="primary" id="toggle">Başlat</button><button type="button" id="return">Seanslar</button></div><p class="error" id="error" role="status"></p><p class="hint" id="hint">ADIB səhifəsini açıq saxlayın.</p>`;
function time(seconds){const n=Math.max(0,Math.ceil(Number(seconds)||0));return String(Math.floor(n/60)).padStart(2,'0')+':'+String(n%60).padStart(2,'0')}
function getState(id){return root.ADIBBrowserPomodoro?.state(id)||null}
class Controller{
 constructor(){this.win=null;this.id='';this.timer=null;this.busy=false;this.opening=false;this.compact=true;}
 async open(id){
  if(root.ADIBDesktop?.nativePomodoro)throw Error('Windows tətbiqində yerli taymerdən istifadə edin.');
  if(!getState(id))throw Error('Pomodoro tapşırığını seçin.');
  this.id=String(id);if(this.win&&!this.win.closed){this.draw();this.win.focus();return;}
  if(this.opening)return;this.opening=true;let win,kind;
  try{
   if(root.isSecureContext&&root.documentPictureInPicture?.requestWindow){win=await root.documentPictureInPicture.requestWindow({width:240,height:184});kind='pip';}
   else{win=root.open('about:blank','ADIB-Pomodoro','popup=yes,width=240,height=184');kind='popup';if(!win)throw Error('Açılan pəncərə bloklandı. Bu sayt üçün pop-up icazəsi verin.');}
   this.win=win;this.kind=kind;this.mount();
  }finally{this.opening=false;}
 }
 mount(){const win=this.win,doc=win.document;doc.title='ADIB · Pomodoro';doc.documentElement.lang='az';doc.body.replaceChildren();const style=doc.createElement('style');style.textContent=STYLE;doc.head.append(style);doc.body.innerHTML=MARKUP;
  doc.getElementById('toggle').onclick=()=>this.toggle();
  this.compact=true;doc.body.classList.add('compact');doc.getElementById('task').onclick=()=>{root.focus();root.ADIBBrowserPomodoro?.openTask(this.id);};
  doc.getElementById('return').onclick=()=>{root.focus();root.ADIBBrowserPomodoro?.history(this.id);};
  doc.getElementById('compact').onclick=()=>{this.compact=!this.compact;doc.body.classList.toggle('compact',this.compact);doc.getElementById('compact').textContent=this.compact?'↗':'↙';try{win.resizeTo(this.compact?240:340,this.compact?184:440)}catch{}this.draw();};
  doc.getElementById('hint').textContent=this.kind==='pip'?'ADIB səhifəsini açıq saxlayın.':'Adi pəncərədir — həmişə üstdə qalması zəmanətli deyil.';
  win.addEventListener('pagehide',()=>this.cleanup(win),{once:true});
  this.timer=win.setInterval(()=>{if(win.closed){this.cleanup(win);return;}root.ADIBBrowserPomodoro?.tick();this.draw();},1000);this.draw();
 }
 cleanup(win){if(this.win!==win)return;win.clearInterval(this.timer);this.timer=null;this.win=null;this.busy=false;}
 draw(){const win=this.win;if(!win||win.closed)return;const doc=win.document,s=getState(this.id),b=doc.getElementById('toggle');if(!s){doc.getElementById('task').textContent='Tapşırıq mövcud deyil';doc.getElementById('clock').textContent='—';b.disabled=true;return;}
  if(doc.getElementById('task').textContent!==s.title)doc.getElementById('task').textContent=s.title;doc.getElementById('task').title=s.title+' · ADIB';doc.getElementById('clock').textContent=time(s.remaining);
  doc.getElementById('mode').textContent=(s.isBreak?'Fasilə':'İş')+' · '+(s.running?'Davam edir':s.status==='completed'?'Tamamlandı':s.status==='paused'?'Dayandırılıb':'Hazırdır');
  doc.getElementById('stats').textContent=(s.sessions||[]).filter(x=>x.status!=='running').length+' seans · '+s.count+' tam pomodoro · '+Math.round(s.minutes*100)/100+' dəq';b.textContent=s.running?'Bitir':s.isBreak?'Fasilə':'Başlat';b.classList.toggle('is-finishing',!!s.running);doc.getElementById('mode').textContent+=(s.syncPending?' · Notion gözləyir':'');b.disabled=this.busy||!s.trusted||s.finishing||!!s.syncPending&&!s.running;if(s.syncPending&&!s.running)b.textContent='Gözləyir';
 }
 async toggle(){if(this.busy)return;const s=getState(this.id);if(!s?.trusted)return;this.busy=true;const doc=this.win?.document;if(doc)doc.getElementById('error').textContent='';this.draw();try{await root.ADIBBrowserPomodoro.action(this.id,s.running?'finish':'start')}catch(e){if(this.win&&!this.win.closed)this.win.document.getElementById('error').textContent=e.message||'Sinxronlaşdırmaq alınmadı.';if(this.compact)try{this.win.resizeTo(240,240)}catch{}}finally{this.busy=false;this.draw();}}
 close(){const win=this.win;if(win){win.close();this.cleanup(win)}}
}
const controller=new Controller();root.ADIBPomodoroWindow={open:id=>controller.open(id),close:()=>controller.close(),get isOpen(){return !!controller.win&&!controller.win.closed}};
function enhance(){if(root.ADIBDesktop?.nativePomodoro||/Android|iPhone|iPad|iPod/i.test(root.navigator?.userAgent||''))return;for(const host of root.document.querySelectorAll('.personal-pomodoro-head,.personal-pomodoro-overlay')){
 if(host.querySelector('[data-browser-pomodoro]'))continue;const modal=host.closest('.personal-pomodoro-modal');const id=modal?.dataset.taskId||host.dataset.taskId||root.ADIBBrowserPomodoro?.activeId();if(!id)continue;
 const b=root.document.createElement('button');b.type='button';b.dataset.browserPomodoro='1';b.textContent='Ayrı pəncərə';b.title='Pomodoro ayrı pəncərədə';b.setAttribute('aria-label','Pomodoro ayrı pəncərədə');b.style.cssText='flex:none;min-height:44px;padding:8px 12px;font-size:14px;border-radius:10px';b.onclick=e=>{e.preventDefault();e.stopPropagation();controller.open(id).catch(error=>root.alert(error.message))};host.append(b);if(modal&&!modal.querySelector('[data-session-history]')){const h=root.document.createElement('button');h.type='button';h.dataset.sessionHistory='1';h.textContent='Seanslar';h.onclick=()=>root.ADIBBrowserPomodoro?.history(id);modal.querySelector('.personal-pomodoro-actions')?.append(h);}
 }}
if(root.document){let scheduled=false;const schedule=()=>{if(scheduled)return;scheduled=true;root.requestAnimationFrame(()=>{scheduled=false;enhance()})};new root.MutationObserver(schedule).observe(root.document.body,{childList:true,subtree:true});enhance();root.addEventListener('pagehide',()=>controller.close());}
if(typeof module==='object'&&module.exports)module.exports={time,Controller,STYLE,MARKUP};
})(typeof window==='object'?window:globalThis);
