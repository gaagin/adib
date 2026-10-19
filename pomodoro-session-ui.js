(function(root){'use strict';let state={sessions:[],revision:-1,revisionBasis:''};
function accept(data){if(!Array.isArray(data.sessions))return;const changed=data.revisionBasis!==state.revisionBasis||data.revision!==state.revision;state={sessions:data.sessions,revision:data.revision,revisionBasis:data.revisionBasis};if(changed||root.ADIBCalendar?.visible&&data.sessions.some(s=>s.status==='running'))root.dispatchEvent?.(new Event('adib-pomodoro-sessions'));}
function all(){return [...(root.ADIBWork?.state.sessions||[]).map(s=>({...s,kind:'work'})),...state.sessions].sort((a,b)=>a.startedAt-b.startedAt)}
function rows(id){return all().filter(s=>!id||String(s.taskId)===String(id))}
function matches(s,f){return(!f.workSource||s.sourceKey===f.workSource)&&(!f.workWorker||s.worker===f.workWorker)&&(!f.workTask||s.taskId===f.workTask)&&(!f.workState||(s.status==='sync-pending'?'pending':s.status)===f.workState)&&(!f.sessionType||f.sessionType===s.kind)}
function calendar(filters={}){const tasks=new Map((root.ADIBHomeBridge?.snapshot().tasks||[]).map(t=>[String(t.id),t]));const now=root.ADIBClock?.now()||Date.now();return state.sessions.filter(s=>s.kind==='pomodoro'&&matches(s,filters)).map(s=>({...tasks.get(String(s.taskId)),id:'pomodoro:'+s.id,sessionKind:'pomodoro',workSession:s,sourceKey:'personal',title:(s.completionReason==='cancelled'?'× ':s.status==='running'?'▶ ':s.status==='sync-pending'?'◷ ':'✓ ')+'🍅 '+s.title+(s.worker?' · '+s.worker:''),date:new Date(s.startedAt).toISOString(),dateEnd:new Date(Math.max(s.startedAt+1000,s.endedAt||Math.min(now,s.startedAt+(s.plannedMinutes||25)*60000))).toISOString(),assignees:[s.worker],tapsirildi:[s.worker],completed:false}))}
function duration(seconds){const n=Math.floor(Math.max(0,Number(seconds)||0));return String(Math.floor(n/3600)).padStart(2,'0')+':'+String(Math.floor(n/60)%60).padStart(2,'0')+':'+String(n%60).padStart(2,'0')}
function label(s){return s.completionReason==='cancelled'?'Ləğv edilib':s.status==='running'?'Davam edir':s.status==='sync-pending'?'Serverdə saxlanılıb · Notion gözləyir':s.status==='pending'?'Vaxt təsdiq gözləyir':s.kind==='pomodoro'?(s.fullPomodoro?'Tam Pomodoro':'Erkən bitirilib'):'Tamamlanıb'}
function finishDialog(s,historyDialog){
 const doc=root.document,popup=doc.createElement('dialog');popup.className='adib-session-finish';
 const add=(tag,text,parent=popup)=>{const e=doc.createElement(tag);e.textContent=text;parent.append(e);return e;};
 add('h2','İş seansını bitirək?');
 add('p',s.title+' · '+(s.worker||'İstifadəçi'));
 add('p','Seans dayandırılacaq və qeydə alınmış vaxt tapşırığa yazılacaq.');
 const error=add('p','');error.className='session-finish-error';error.setAttribute('role','alert');
 const footer=add('footer','');
 const cancel=add('button','Bağla',footer);cancel.type='button';cancel.className='session-finish-cancel';cancel.onclick=()=>popup.close();const abandon=add('button','Seansı ləğv et',footer);abandon.type='button';abandon.className='session-finish-cancel';abandon.onclick=async()=>{if(!root.confirm('Bu seansı ləğv edək? Vaxt tapşırığın ümumi vaxtına əlavə olunmayacaq.'))return;abandon.disabled=true;try{await root.ADIBWork.action({action:'cancel',sessionId:s.id,revision:s.revision});popup.close();historyDialog.close()}catch(e){abandon.disabled=false;error.textContent=e.message}};
 const finish=add('button','Seansı bitir',footer);finish.type='button';finish.className='session-finish-primary';
 finish.onclick=async()=>{if(finish.disabled)return;finish.disabled=true;cancel.disabled=true;error.textContent='';try{
  let session=s;
  if(session.status==='running')session=(await root.ADIBWork.action({action:'stop',sessionId:session.id,revision:session.revision})).session;
  if(session.status==='pending')await root.ADIBWork.action({action:'save',sessionId:session.id,revision:session.revision});
  else if(session.status!=='saved')throw Error('Seansın cari vəziyyəti dəyişib. Siyahını yeniləyib təkrar cəhd edin.');
  popup.close();historyDialog.close();
 }catch(e){error.textContent=e.message||'Seansı bitirmək mümkün olmadı';finish.disabled=false;cancel.disabled=false;}};
 historyDialog.append(popup);popup.showModal();finish.focus();
}
function history(id,focusId,kindFilter){
 const doc=root.document,d=doc.createElement('dialog');d.className='adib-session-history';
 const add=(tag,text,parent=d)=>{const e=doc.createElement(tag);e.textContent=text;parent.append(e);return e;};
 const header=add('header','');add('h2',kindFilter==='pomodoro'?'Pomodoro seansları':'İş seansları',header);const close=add('button','×',header);close.type='button';close.setAttribute('aria-label','Bağla');close.onclick=()=>d.close();
 const sessions=rows(id).filter(s=>!kindFilter||s.kind===kindFilter).slice().reverse(),list=add('div','');list.className='adib-session-list';if(!sessions.length)add('p','Hələ seans yoxdur',list);
 const local=n=>new Date(n).toLocaleString('az',{timeZone:root.ADIBClock?.timeZone||'Asia/Baku',day:'2-digit',month:'short',hour:'2-digit',minute:'2-digit',second:'2-digit'});
 for(const s of sessions){
  const item=add('article','',list);item.className='session-row '+(s.status==='saved'?'session-completed':s.status==='running'?'session-active':'session-pending');
  if(s.id===focusId)item.classList.add('session-selected');
  add('strong',(s.kind==='pomodoro'?'🍅 Pomodoro':'◷ İş taymeri')+' · '+s.title,item);
  add('p',local(s.startedAt)+' → '+(s.endedAt?local(s.endedAt):'Davam edir'),item);
  add('p',(s.worker||'İstifadəçi')+' · '+duration(s.status==='running'?(Math.min(root.ADIBClock.now(),s.startedAt+(s.plannedMinutes||100000)*60000)-s.startedAt)/1000:s.seconds)+' · '+label(s),item);
  const canFinish=s.kind==='work'&&['running','pending'].includes(s.status)&&!!root.ADIBWork?.action;
  if(canFinish){
   item.classList.add('session-finishable');item.setAttribute('role','button');item.setAttribute('tabindex','0');item.setAttribute('aria-label','Seansı bitirmək üçün klikləyin: '+s.title);
   const open=event=>{if(event.target?.closest?.('button'))return;event.preventDefault?.();item.classList.add('session-selected');finishDialog(s,d);};
   item.addEventListener('click',open);item.addEventListener('keydown',event=>{if(event.key==='Enter'||event.key===' '){event.preventDefault();open(event);}});
  }
  if(s.kind==='work'&&s.status==='running'&&root.ADIBWork?.stop){const stop=add('button','Dayandır',item);stop.type='button';stop.className='session-stop-button';stop.setAttribute('aria-label','Taymeri dayandır');stop.onclick=async event=>{event.stopPropagation();stop.disabled=true;try{await root.ADIBWork.stop(s);d.close()}catch(error){stop.disabled=false;stop.title=error.message;stop.textContent='Yenidən cəhd edin'}};}
 }
 const footer=add('footer',''),taskButton=add('button','Tapşırığı aç',footer);taskButton.type='button';taskButton.onclick=()=>{d.close();const task=sessions[0];if(task?.sourceKey==='todo'||task?.sourceKey==='gorulen')root.ADIBEquipmentCalendar?.open(id);else root.ADIBHomeBridge?.openTask(id)};
 const done=add('button','Bağla',footer);done.type='button';done.onclick=()=>d.close();d.addEventListener('close',()=>d.remove());doc.body.append(d);d.showModal();d.querySelector('.session-selected')?.scrollIntoView({block:'nearest'});
}
root.ADIBSessions={accept,all,rows,calendar,history,duration,label,matches,get state(){return state}};
if(typeof module==='object'&&module.exports)module.exports=root.ADIBSessions;
})(typeof window==='object'?window:globalThis);
