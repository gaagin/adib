(function(root){'use strict';
let bridge=null,peers=[],flight=null,filter='all',lastRefresh=0,scope='',available=false;const operations=new Map();
const enabled=()=>!root.ADIBDesktop,isEmployee=id=>String(id||'').startsWith('employee:');
// Per-account, device-local list preferences; messages and tasks are never deleted.
function hiddenKey(){return 'adib-hidden-discussions-v1:'+String(root.ADIBAccount?.user?.id||'owner');}
function hiddenThreads(){try{const value=JSON.parse(localStorage.getItem(hiddenKey())||'[]');return new Set(Array.isArray(value)?value:[]);}catch{return new Set();}}
function isHidden(id){return hiddenThreads().has(String(id));}
function setHidden(id,hide){const rows=hiddenThreads();if(hide)rows.add(String(id));else rows.delete(String(id));try{localStorage.setItem(hiddenKey(),JSON.stringify([...rows]));}catch{const box=document.querySelector('#adibChatOverlay .adib-chat-error');if(box)box.textContent='Siyahı seçimini saxlamaq alınmadı. Yenidən cəhd edin.';return;}if(hide&&bridge.active()===String(id))bridge.dismiss?.();bridge.render();}
function decorateHidden(overlay){for(const row of overlay.querySelectorAll('[data-chat-thread]')){if(!isHidden(row.dataset.chatThread))continue;const label=document.createElement('small');label.className='adib-discussion-hidden-label';label.textContent='Siyahıdan gizlədilib';row.querySelector('.adib-chat-thread-info')?.append(label);}const id=overlay.querySelector('.adib-chat-messages')?.dataset.taskId;if(!id)return;const head=overlay.querySelector('.adib-chat-conversation-head');if(!head)return;const hidden=isHidden(id),button=document.createElement('button');button.type='button';button.className='adib-discussion-hide';button.dataset.discussionHide=id;const label=hidden?'Siyahıya qaytar':'Siyahıdan gizlət';button.title=label;button.setAttribute('aria-label',label);button.innerHTML='<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M4 8h16v12H4zM3 4h18v4H3zM9 12h6"/>'+ (hidden?'<path d="m9 16 3-3 3 3"/>':'')+'</svg>';button.onclick=()=>setHidden(id,!hidden);head.insertBefore(button,head.querySelector('[data-chat-close]'));}
const message=m=>({...m,direct:true,authorName:m.senderName,authorId:m.senderId,createdAt:new Date(m.createdAt).toISOString()});
async function api(path,body){const base=new URL(root.ADIBDiscussionsBase?.()||location.href,location.href);const r=await fetch(base.origin+path,{cache:'no-store',...(body?{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify(body)}:{})});const d=await r.json();if(!r.ok)throw Error(d.error||'HTTP '+r.status);return d;}
function merge(tasks){if(!enabled())return tasks;const direct=bridge?.get().filter(t=>t.isEmployee)||[];return [...tasks.filter(t=>!t.isEmployee),...direct];}
function upsert(t){const rows=bridge.get();bridge.set([...rows.filter(x=>x.taskId!==t.taskId),t]);}
function reset(){peers=[];available=false;operations.clear();bridge?.set(bridge.get().filter(t=>!t.isEmployee));}
async function load(id){if(!enabled()||!isEmployee(id))return;const peerId=id.slice(9),r=await api('/api/employee-messages?peerId='+encodeURIComponent(peerId));upsert({taskId:id,title:r.peer.name,source:'Əməkdaş',isEmployee:true,peerId,loaded:true,unreadCount:0,comments:r.messages.map(message)});bridge.render();}
async function refresh(force=false){if(!enabled()||!bridge||document.getElementById('adibChatOverlay')?.hidden)return;if(flight)return flight;if(!force&&Date.now()-lastRefresh<10000)return;flight=(async()=>{const key=root.ADIBAccount?.user?.id||'no-account';if(scope!==key){reset();scope=key;}const r=await api('/api/employee-chats');if(key!==(root.ADIBAccount?.user?.id||'no-account')){reset();return;}available=r.available;peers=r.employees||[];const old=bridge.get().filter(t=>t.isEmployee),byId=new Map(old.map(t=>[t.peerId,t])),rows=(r.threads||[]).map(t=>{const prev=byId.get(t.peerId),last=t.lastMessage&&message(t.lastMessage),same=prev?.loaded&&prev.comments.at(-1)?.id===last?.id;return {taskId:'employee:'+t.peerId,title:t.peerName,source:'Əməkdaş',isEmployee:true,peerId:t.peerId,unreadCount:t.unreadCount,loaded:!!same,comments:same?prev.comments:(last?[last]:[])};});for(const t of old)if(peers.some(p=>p.id===t.peerId)&&!rows.some(x=>x.peerId===t.peerId))rows.push(t);bridge.set([...bridge.get().filter(t=>!t.isEmployee),...rows]);lastRefresh=Date.now();const active=bridge.active();if(isEmployee(active)&&rows.find(t=>t.taskId===active)&&!rows.find(t=>t.taskId===active).loaded)await load(active);else bridge.render();})().catch(e=>{const box=document.querySelector('.adib-chat-error');if(box)box.textContent=e.message;}).finally(()=>flight=null);return flight;}
async function send(thread,text,attachments=[]){const key=thread.taskId+'|'+text+'|'+attachments.map(item=>item.file_upload_id||'').join(',');if(!operations.has(key))operations.set(key,crypto.randomUUID());const r=await api('/api/employee-messages',{peerId:thread.peerId,text,attachments,operationId:operations.get(key)});operations.delete(key);const rows=thread.comments||[];if(!rows.some(m=>m.id===r.message.id))rows.push(message(r.message));upsert({...thread,comments:rows,loaded:true});}
function acceptRow(row,query){const id=row.dataset.chatThread,employee=isEmployee(id),q=query.trim().toLocaleLowerCase('az-AZ');if(!q&&isHidden(id))return false;const thread=bridge?.get().find(t=>t.taskId===id),text=[row.textContent,...(thread?.comments||[]).map(c=>c.text||'')].join(' ').toLocaleLowerCase('az-AZ');return (filter==='all'||(filter==='employees')===employee)&&text.includes(q);}
// Presentation only: never rewrite stored messages or use this for permissions.
function chatMessageView(comment,user){
 const norm=value=>String(value||'').normalize('NFC').trim().replace(/\s+/g,' ').toLocaleLowerCase('az-AZ');
 const names=[user?.name,user?.rules?.assignee].map(norm).filter(Boolean);
 let name=String(comment.authorName||comment.senderName||''),text=String(comment.text||'');
 const legacy=!comment.direct&&norm(name)==='zavod'&&text.match(/^\[([^\]\r\n]{1,120})\]\s+([\s\S]*)$/);
 if(legacy){name=legacy[1];text=legacy[2];}
 const senderId=String(comment.senderId||comment.authorId||'');
 // Direct-message IDs are ADIB account IDs; Notion integration IDs are not.
 const mine=comment.direct&&senderId&&user?.id
   ?senderId===String(user.id)
   :names.includes(norm(name));
 return {name,text,mine:!!mine};
}
function decorateMessageBubbles(overlay){
 const list=overlay.querySelector('.adib-chat-messages');
 if(!list)return;
 const thread=bridge?.get().find(t=>String(t.taskId)===list.dataset.taskId);
 if(!thread)return;
 const selected=document.getElementById('currentUser');
 const user=root.ADIBAccount?.user||{id:selected?.value,name:selected?.selectedOptions?.[0]?.textContent};
 const date=value=>root.ADIBZone?.parse(value,root.ADIBClock?.timeZone)?.getTime();
 const comments=[...(thread.comments||[])].sort((a,b)=>{
  const x=date(a.createdAt),y=date(b.createdAt);
  return Number.isFinite(x)?(Number.isFinite(y)?x-y:-1):(Number.isFinite(y)?1:0);
 });
 const bubbles=[...list.querySelectorAll('.adib-chat-bubble')];
 if(bubbles.length!==comments.length)return;
 let previous=null;
 bubbles.forEach((bubble,i)=>{
  const comment=comments[i],view=chatMessageView(comment,user);
  const now=date(comment.createdAt),before=previous&&date(previous.comment.createdAt);
  const grouped=previous&&view.name&&view.name===previous.view.name&&view.mine===previous.view.mine
   &&Number.isFinite(now)&&Number.isFinite(before)&&Math.abs(now-before)<=300000
   &&new Date(now).toDateString()===new Date(before).toDateString();
  bubble.classList.toggle('mine',view.mine);
  bubble.classList.toggle('grouped',!!grouped);
  bubble.dataset.direction=view.mine?'outgoing':'incoming';
  bubble.querySelector(':scope > strong')?.remove();
  if(!view.mine&&!grouped){const author=document.createElement('strong');author.textContent=view.name||'İstifadəçi';bubble.prepend(author);}
  const body=bubble.querySelector('.adib-chat-body');if(body)body.textContent=view.text;
  previous={comment,view};
 });
}
root.ADIBChatPresentation={view:chatMessageView,decorate:decorateMessageBubbles};

function decorate(overlay){if(!enabled())return;decorateMessageBubbles(overlay);decorateHidden(overlay);const search=overlay.querySelector('.adib-chat-search'),tabs=document.createElement('div');tabs.className='adib-discussion-tabs';for(const [id,label] of [['all','Bütün'],['tasks','Tapşırıqlar'],['employees','Əməkdaşlar']]){const b=document.createElement('button');b.type='button';b.textContent=label;b.setAttribute('aria-pressed',String(filter===id));b.onclick=()=>{filter=id;bridge.render();};tabs.append(b);}const add=document.createElement('button');add.type='button';add.textContent='+';add.setAttribute('aria-label','Əməkdaşla yeni söhbət');add.onclick=choose;tabs.append(add);search?.after(tabs);const canCreate=!root.ADIBAccount||(root.ADIBAccount.action('create')&&root.ADIBAccount.action('comment'));if(canCreate&&!overlay.querySelector('[data-discussion-task-add]')){const quick=document.createElement('button');quick.type='button';quick.className='adib-discussion-task-add adib-discussion-fab';quick.dataset.discussionTaskAdd='true';quick.setAttribute('aria-label','Yeni tapşırıq və ilk mesaj');quick.title='Tapşırıq və müzakirə yarat';quick.innerHTML='<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 4v16M4 12h16"/></svg>';quick.onclick=()=>quickAddTask(quick);overlay.append(quick);}}
function quickAddTask(trigger){if(document.querySelector('.adib-discussion-quick-add[open]'))return;const d=document.createElement('dialog');d.className='adib-discussion-quick-add';d.setAttribute('aria-labelledby','adibDiscussionCreateTitle');const form=document.createElement('form');form.method='dialog';const head=document.createElement('header'),title=document.createElement('h2');title.id='adibDiscussionCreateTitle';title.textContent='Tapşırıq və müzakirə';const close=document.createElement('button');close.type='button';close.textContent='×';close.setAttribute('aria-label','Bağla');close.onclick=()=>d.close();head.append(title,close);const task=document.createElement('input');task.type='text';task.maxLength=2000;task.required=true;task.placeholder='Tapşırığın adı';task.setAttribute('aria-label','Tapşırığın adı');const comment=document.createElement('textarea');comment.maxLength=1850;comment.required=true;comment.rows=4;comment.placeholder='İlk mesajı yazın…';comment.setAttribute('aria-label','İlk mesaj');const source=document.createElement('select');source.setAttribute('aria-label','Tapşırıq bölməsi');for(const [value,label] of [['personal','Tapşırıqlarım'],['gorulen','Görülən işlər'],['todo','ToDo']]){if(value!=='personal'&&root.ADIBAccount&&!root.ADIBAccount.section('equipment'))continue;source.add(new Option(label,value));}const sourceLabel=document.createElement('label');sourceLabel.append('Tapşırıq bölməsi',source);const equipmentFields=document.createElement('div');equipmentFields.className='adib-discussion-equipment-fields';equipmentFields.hidden=true;const plan=document.createElement('select'),machine=document.createElement('select');plan.setAttribute('aria-label','Plan');machine.setAttribute('aria-label','Avadanlıq');const planLabel=document.createElement('label'),machineLabel=document.createElement('label');planLabel.append('Plan (istəyə görə)');machineLabel.append('Avadanlıq');const searchableSelect=(select,label,placeholder)=>{const wrap=document.createElement('div');wrap.className='adib-discussion-combo';const input=document.createElement('input');input.type='search';input.autocomplete='off';input.placeholder=placeholder;input.setAttribute('aria-label',placeholder.replace(' axtarın…',' axtarın'));input.setAttribute('role','combobox');input.setAttribute('aria-autocomplete','list');input.setAttribute('aria-expanded','false');const list=document.createElement('div');list.className='adib-discussion-combo-list';list.setAttribute('role','listbox');list.hidden=true;select.hidden=true;select.tabIndex=-1;select.setAttribute('aria-hidden','true');const sync=()=>{input.value=select.value?(select.selectedOptions[0]?.textContent||''):''};const close=()=>{list.hidden=true;input.setAttribute('aria-expanded','false')};const choose=option=>{select.value=option.value;select.dispatchEvent(new Event('change',{bubbles:true}));sync();close()};const paint=()=>{list.replaceChildren();const query=input.value.trim().toLocaleLowerCase('az-AZ');const options=[...select.options].filter(option=>option.value&&(!query||option.textContent.toLocaleLowerCase('az-AZ').includes(query)));for(const option of options){const button=document.createElement('button');button.type='button';button.setAttribute('role','option');button.setAttribute('aria-selected',String(option.value===select.value));button.textContent=option.textContent;button.onmousedown=event=>event.preventDefault();button.onclick=()=>choose(option);list.append(button)}if(!options.length){const empty=document.createElement('div');empty.className='adib-discussion-combo-empty';empty.textContent='Nəticə tapılmadı';list.append(empty)}list.hidden=false;input.setAttribute('aria-expanded','true')};input.onfocus=()=>{if(input.value)input.select();paint()};input.oninput=()=>{if(select.value&&input.value!==select.selectedOptions[0]?.textContent){select.value='';if(select===plan)fillMachines()}paint()};input.onkeydown=event=>{if(event.key==='Escape'){close();return}if(event.key==='Enter'&&!list.hidden){const option=[...select.options].find(item=>item.value&&item.textContent.toLocaleLowerCase('az-AZ').includes(input.value.trim().toLocaleLowerCase('az-AZ')));if(option){event.preventDefault();choose(option)}}};select.addEventListener('change',sync);wrap.append(input,list);label.append(wrap,select);return{input,refresh:()=>{if(!list.hidden)paint()},sync,close}};const planSearch=searchableSelect(plan,planLabel,'Plan axtarın…'),machineSearch=searchableSelect(machine,machineLabel,'Avadanlıq axtarın…');equipmentFields.append(machineLabel,planLabel);let equipmentSnapshot=null,loadingEquipment=false;const fillMachines=()=>{const previous=machine.value,plans=new Map((equipmentSnapshot?.plans||[]).map(item=>[String(item.id),item.name||item.title||'Adsız plan']));machine.replaceChildren(new Option('Avadanlıq seçin — istəyə görə',''));for(const item of equipmentSnapshot?.equipment||[]){if(plan.value&&String(item.planId)!==plan.value)continue;const planName=plans.get(String(item.planId)),label=(item.name||item.title||'Adsız avadanlıq')+(planName?' · '+planName:'');machine.add(new Option(label,item.id));}if([...machine.options].some(option=>option.value===previous))machine.value=previous;machineSearch.sync();machineSearch.refresh()};plan.onchange=()=>{planSearch.sync();fillMachines()};machine.onchange=()=>{const selected=(equipmentSnapshot?.equipment||[]).find(item=>String(item.id)===machine.value);if(selected&&[...plan.options].some(option=>option.value===String(selected.planId||''))){plan.value=String(selected.planId||'');plan.dispatchEvent(new Event('change',{bubbles:true}))}machineSearch.sync()};document.addEventListener('pointerdown',event=>{if(!planLabel.contains(event.target))planSearch.close();if(!machineLabel.contains(event.target))machineSearch.close()});const setSource=async()=>{const personal=source.value==='personal';equipmentFields.hidden=personal;plan.disabled=machine.disabled=personal;planSearch.input.disabled=machineSearch.input.disabled=personal;if(personal)return;if(equipmentSnapshot)return;loadingEquipment=true;plan.replaceChildren(new Option('Yüklənir…',''));planSearch.sync();try{equipmentSnapshot=await api('/api/plan-snapshot');plan.replaceChildren(new Option('Plan seçin — istəyə görə',''));for(const item of equipmentSnapshot.plans||[])plan.add(new Option(item.name||item.title||'Adsız plan',item.id));planSearch.sync();planSearch.refresh();fillMachines();if(!(equipmentSnapshot.plans||[]).length&&!(equipmentSnapshot.equipment||[]).length)status.textContent='Əlçatan plan və avadanlıq yoxdur.';}catch(error){plan.replaceChildren(new Option('Planları yükləmək alınmadı',''));status.textContent=error.message;}finally{loadingEquipment=false;plan.disabled=machine.disabled=source.value==='personal';planSearch.input.disabled=machineSearch.input.disabled=source.value==='personal';}};source.onchange=()=>{status.textContent='';setSource();};plan.disabled=machine.disabled=true;const nameLabel=document.createElement('label');nameLabel.append('Tapşırığın adı',task);const messageLabel=document.createElement('label');messageLabel.append('İlk mesaj',comment);const status=document.createElement('p');status.setAttribute('role','alert');status.className='adib-discussion-create-error';const footer=document.createElement('footer'),cancel=document.createElement('button'),submit=document.createElement('button');cancel.type='button';cancel.textContent='Ləğv et';cancel.onclick=()=>d.close();submit.type='submit';submit.className='primary';submit.textContent='Yarat və söhbətə keç';footer.append(cancel,submit);form.append(head,sourceLabel,nameLabel,equipmentFields,messageLabel,status,footer);d.append(form);
let created=null,messageSaved=false,busy=false;form.onsubmit=async event=>{event.preventDefault();const name=task.value.trim(),text=comment.value.trim();if(busy||!name||!text)return;if(!created&&source.value!=='personal'&&(loadingEquipment||(!plan.value&&!machine.value))){status.textContent=loadingEquipment?'Avadanlıq siyahısı yüklənir. Bir az gözləyin.':'Avadanlıq və ya plan seçin.';(machine.value?plan:machine).focus();return;}busy=true;submit.disabled=cancel.disabled=close.disabled=true;source.disabled=plan.disabled=machine.disabled=true;planSearch.input.disabled=machineSearch.input.disabled=true;status.textContent='';form.setAttribute('aria-busy','true');try{if(!created){const snapshot=root.ADIBHomeBridge?.snapshot(),inbox=snapshot?.containers?.find(c=>String(c.name||'').trim().toLowerCase()==='inbox');const personal=source.value==='personal';const result=await api(personal?'/api/personal-task':'/api/task',personal?{title:name,containerId:inbox?.id||''}:{title:name,sourceKey:source.value,planId:plan.value,machineId:machine.value});if(!result?.id)throw Error('Tapşırığın yaradılması təsdiqlənmədi.');created=result;task.readOnly=true;source.disabled=plan.disabled=machine.disabled=true;planSearch.input.disabled=machineSearch.input.disabled=true;}if(!messageSaved){await api('/api/task-comments',{id:created.id,text});messageSaved=true;comment.readOnly=true;}await bridge.open({id:created.id,title:name});d.close();try{Promise.resolve(root.ADIBHomeBridge?.refresh(false)).catch(()=>{});}catch{}setTimeout(()=>{const input=document.querySelector('#adibChatOverlay #adibChatInput');if(input?.dataset.taskId===String(created.id))input.focus();},180);}catch(error){status.textContent=(created?(messageSaved?'Tapşırıq və mesaj saxlanılıb. Söhbəti açmaq alınmadı: ':'Tapşırıq yaradılıb. Mesajı göndərmək üçün yenidən cəhd edin: '):'Tapşırığı yaratmaq alınmadı: ')+error.message;if(messageSaved)submit.textContent='Söhbəti aç';}finally{busy=false;submit.disabled=cancel.disabled=close.disabled=false;if(!created){source.disabled=false;plan.disabled=machine.disabled=source.value==='personal';planSearch.input.disabled=machineSearch.input.disabled=source.value==='personal';}form.removeAttribute('aria-busy');}};
d.addEventListener('keydown',event=>{if(event.key==='Escape')event.stopPropagation();});d.addEventListener('cancel',event=>{if(busy)event.preventDefault();});d.addEventListener('close',()=>{d.remove();const current=trigger?.isConnected?trigger:document.querySelector('#adibChatOverlay [data-discussion-task-add]');current?.focus({preventScroll:true});});document.body.append(d);d.showModal();task.focus();}

async function choose(){await refresh(true);const d=document.createElement('dialog');d.className='adib-employee-picker';const title=document.createElement('h2');title.textContent='Əməkdaşla söhbət';const list=document.createElement('div'),input=document.createElement('input');input.type='search';input.placeholder='Əməkdaşı axtarın';input.setAttribute('aria-label','Əməkdaşı axtarın');const paint=()=>{list.replaceChildren();for(const p of peers.filter(p=>p.name.toLocaleLowerCase('az-AZ').includes(input.value.trim().toLocaleLowerCase('az-AZ')))){const b=document.createElement('button');b.type='button';b.textContent=p.name;b.onclick=()=>{d.close();upsert({taskId:'employee:'+p.id,title:p.name,source:'Əməkdaş',isEmployee:true,peerId:p.id,comments:[],unreadCount:0});bridge.open({id:'employee:'+p.id});};list.append(b);}if(!list.childElementCount){const empty=document.createElement('p');empty.textContent=available?'Əməkdaş tapılmadı. ADIB-ə dəvət olunmuş aktiv istifadəçilər burada görünür.':'Əməkdaşlarla söhbət üçün ADIB hesabına daxil olun.';list.append(empty);}};input.oninput=paint;const close=document.createElement('button');close.type='button';close.textContent='Bağla';close.onclick=()=>d.close();d.append(title,input,list,close);d.addEventListener('close',()=>d.remove());document.body.append(d);paint();d.showModal();input.focus();}
root.ADIBDiscussions={enabled,isEmployee,isHidden,merge,refresh,load,send,acceptRow,decorate,bind:v=>bridge=v};
})(window);

/* Keep mobile chat inside the visible viewport, not the keyboard-covered 100dvh. */
(function chatKeyboardViewport(root){
  'use strict';
  const doc = root.document;
  let overlay = null, overlayObserver = null, frame = 0, settle = 0;
  const mobile = () => !root.ADIBDesktop && (doc.documentElement.classList.contains('adib-native-android')
    || doc.body?.classList.contains('adib-android-wrapper')
    || root.matchMedia('(max-width:700px), (pointer:coarse) and (max-width:900px)').matches);
  function clear() {
    if (!overlay) return;
    overlay.removeAttribute('data-chat-viewport');
    overlay.removeAttribute('data-chat-keyboard');
    overlay.style.removeProperty('--adib-chat-visible-height');
    overlay.style.removeProperty('--adib-chat-visible-top');
  }
  function sync() {
    frame = 0;
    const current = doc.getElementById('adibChatOverlay');
    if (current !== overlay) {
      clear();
      overlayObserver?.disconnect();
      overlay = current;
      if (overlay) {
        overlayObserver = new MutationObserver(schedule);
        overlayObserver.observe(overlay, {attributes:true, attributeFilter:['hidden','class'], childList:true});
      }
    }
    if (!overlay || overlay.hidden || !mobile() || !doc.body.classList.contains('adib-chat-open')) { clear(); return; }
    const viewport = root.visualViewport;
    // Do not reinterpret accessibility pinch-zoom as an on-screen keyboard.
    if (viewport && Math.abs((viewport.scale || 1) - 1) > .05) return;
    const top = Math.max(0, Math.round(viewport?.offsetTop || 0));
    let height = Math.max(1, Math.round(viewport?.height || root.innerHeight));
    const keyboard = root.navigator?.virtualKeyboard?.boundingRect;
    if (keyboard?.height > 80 && keyboard.top > top) height = Math.min(height, Math.round(keyboard.top - top));
    const messages = overlay.querySelector('.adib-chat-messages');
    const scroll = messages?.scrollTop || 0;
    const follow = messages && messages.scrollHeight - scroll - messages.clientHeight < 64;
    const changed = overlay.style.getPropertyValue('--adib-chat-visible-height') !== height + 'px'
      || overlay.style.getPropertyValue('--adib-chat-visible-top') !== top + 'px';
    overlay.style.setProperty('--adib-chat-visible-height', height + 'px');
    overlay.style.setProperty('--adib-chat-visible-top', top + 'px');
    overlay.setAttribute('data-chat-viewport', 'true');
    const editing = overlay.contains(doc.activeElement) && doc.activeElement.matches('input,textarea,[contenteditable=true]');
    overlay.toggleAttribute('data-chat-keyboard', root.innerHeight - height > 100 || keyboard?.height > 80 || (editing && height < 380));
    if (changed && messages) {
      // Resizing must not throw a reader back to the newest message.
      messages.scrollTop = follow ? messages.scrollHeight : scroll;
    }
  }
  function schedule() { if (!frame) frame = root.requestAnimationFrame(sync); }
  function focusChanged() {
    schedule();
    root.clearTimeout(settle);
    settle = root.setTimeout(schedule, 350);
  }
  function init() {
    if (!doc.body) return;
    new MutationObserver(schedule).observe(doc.body, {attributes:true, attributeFilter:['class'], childList:true});
    schedule();
  }
  root.visualViewport?.addEventListener('resize', schedule);
  root.visualViewport?.addEventListener('scroll', schedule);
  root.navigator?.virtualKeyboard?.addEventListener('geometrychange', schedule);
  root.addEventListener('resize', schedule);
  root.addEventListener('orientationchange', focusChanged);
  doc.addEventListener('focusin', focusChanged);
  doc.addEventListener('focusout', focusChanged);
  if (doc.readyState === 'loading') doc.addEventListener('DOMContentLoaded', init, {once:true});
  else init();
})(window);

/* Open the task represented by the visible conversation, not a stale render closure. */
(function reliableChatTaskOpening(root){
 'use strict';
 const normalize=id=>String(id||'').replace(/-/g,'').toLowerCase();
 const same=(a,b)=>normalize(a)===normalize(b);
 let opening=null,press=null,lastTouch=null;
 const overlay=()=>document.getElementById('adibChatOverlay');
 const activeId=()=>overlay()?.querySelector('.adib-chat-messages')?.dataset.taskId||'';
 function showError(message){const box=overlay()?.querySelector('.adib-chat-error');if(box){box.textContent=message;box.setAttribute('role','alert');}}
 function busy(value){for(const button of overlay()?.querySelectorAll('[data-chat-open-task]')||[]){button.setAttribute('aria-busy',String(value));button.disabled=value;}}
 function resolve(id){
  const home=root.ADIBHomeBridge?.snapshot?.();
  const personal=[...(home?.tasks||[]),...(typeof chatPersonalTasks!=='undefined'?chatPersonalTasks:[]),...(root.ADIBPersonalPomodoroTasks||[])].find(task=>same(task.id,id));
  if(personal)return{kind:'personal',task:personal};
  const equipment=root.ADIBEquipmentCalendar?.tasks?.().find(task=>same(task.id,id));
  if(equipment)return{kind:'equipment',task:equipment};
  const info=typeof taskById==='function'?taskById(id):null;
  if(info)return{kind:'equipment',task:info.task,machine:info.machine};
  if(typeof state!=='undefined')for(const plan of state.plans||[]){const task=(plan.tasks||[]).find(task=>same(task.id,id));if(task)return{kind:'equipment',task};}
  return null;
 }
 async function refreshTasks(){
  const jobs=[],account=root.ADIBAccount;
  if(!account||account.section('personal')){if(root.ADIBHomeBridge?.refresh)jobs.push(Promise.resolve().then(()=>root.ADIBHomeBridge.refresh(false)));}
  if(!account||account.section('equipment')){if(typeof refresh==='function')jobs.push(Promise.resolve().then(()=>refresh(true)));}
  const results=await Promise.allSettled(jobs),failure=results.find(result=>result.status==='rejected');
  return failure?.reason;
 }
 async function openResolved(found){
  const id=found.task.id;
  if(root.ADIBAutosave?.isPending?.(id)){root.ADIBAutosave.inspect(id);throw Error('Tapşırıq saxlanılır. Saxlama tamamlandıqdan sonra yenidən cəhd edin.');}
  if(found.kind==='personal'){
   if(root.__openPersonalChatTask)await root.__openPersonalChatTask(id,found.task.containerId||'');
   else if(root.ADIBHomeBridge?.openTask){await root.ADIBHomeBridge.activate?.();await root.ADIBHomeBridge.openTask(id);}
   else throw Error('Tapşırıq redaktoru hazır deyil.');
  }else{
   if(typeof setPersonalMode==='function')await setPersonalMode(false);
   const modal=document.getElementById('taskModal');
   if(modal){modal.classList.remove('kanban-modal');modal.querySelector('.modal')?.classList.remove('kanban-modal');modal.classList.add('open');delete modal.dataset.planBoardId;}
   if(root.ADIBEquipmentCalendar?.open)await root.ADIBEquipmentCalendar.open(id);
   else if(typeof openTaskEditor==='function')await openTaskEditor(found.task,found.machine||null,false);
   else throw Error('Tapşırıq redaktoru hazır deyil.');
  }
  if(!document.querySelector('#taskModal.open .task-editor,#taskModal.open .personal-task-editor,.personal-kanban-editor-layer .personal-task-editor,.kanban-task-editor-layer .task-editor'))throw Error('Tapşırıq redaktoru açılmadı. Yenidən cəhd edin.');
 }
 function open(id=activeId()){
  id=String(id||'');if(!id||id.startsWith('employee:'))return Promise.resolve(false);
  if(opening)return opening;
  showError('');busy(true);
  opening=(async()=>{
   try{
    await root.ADIBAccount?.ready;
    let found=resolve(id);
    if(!found){const failure=await refreshTasks();found=resolve(id);if(!found)throw failure||Error('Tapşırıq tapılmadı və ya ona giriş yoxdur.');}
    await openResolved(found);
    root.closeCommentChat?.();return true;
   }catch(error){
    // Never close the conversation on a cache miss or failed editor transition.
    const chat=overlay();if(chat){chat.hidden=false;document.body.classList.add('adib-chat-open');}
    showError('Tapşırığı açmaq alınmadı: '+(error?.message||String(error)));return false;
   }finally{opening=null;busy(false);}
  })();return opening;
 }
 // Delegation survives polling, sending messages, and replacement of header nodes.
 document.addEventListener('click',event=>{
  const button=event.target.closest?.('[data-chat-open-task]');if(!button||!overlay()?.contains(button))return;
  event.preventDefault();event.stopImmediatePropagation();
  const id=activeId(),compatibilityClick=event.detail>0||event.pointerType==='touch'||event.sourceCapabilities?.firesTouchEvents;
  if(compatibilityClick&&lastTouch&&same(lastTouch.id,id)&&performance.now()-lastTouch.time<700)return;
  void open(id);
 },true);
 document.addEventListener('pointerdown',event=>{
  const button=event.target.closest?.('[data-chat-open-task]');
  if(!button||event.pointerType==='mouse'||button.disabled||!overlay()?.contains(button)){press=null;return;}
  press={pointerId:event.pointerId,id:activeId(),x:event.clientX,y:event.clientY,time:performance.now()};
 },true);
 document.addEventListener('pointermove',event=>{if(press&&press.pointerId===event.pointerId&&Math.hypot(event.clientX-press.x,event.clientY-press.y)>12)press=null;},true);
 document.addEventListener('pointercancel',()=>{press=null;},true);
 document.addEventListener('pointerup',event=>{
  const pending=press;if(!pending||pending.pointerId!==event.pointerId)return;press=null;
  if(!same(pending.id,activeId())||performance.now()-pending.time>800)return;
  const button=overlay()?.querySelector('[data-chat-open-task]'),rect=button?.getBoundingClientRect();
  if(!rect||button.hidden||event.clientX<rect.left||event.clientX>rect.right||event.clientY<rect.top||event.clientY>rect.bottom)return;
  event.preventDefault();event.stopImmediatePropagation();lastTouch={id:pending.id,time:performance.now()};void open(pending.id);
 },true);
 root.addEventListener('blur',()=>{press=null;});
 root.ADIBChatTaskOpening={open};
})(window);
