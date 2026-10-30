/* Layout only: existing actions and refresh policy are unchanged. */
(function(root){'use strict';if(root.ADIBDesktop)return;
const make=(tag,cls,text)=>{const n=document.createElement(tag);n.className=cls;if(text!==undefined)n.textContent=text;return n},move=(n,to)=>{if(n&&n.parentElement!==to)to.append(n)};
function menu(host,label='Görünüş və parametrlər'){let d=host.querySelector(':scope > .adib-view-menu');if(d)return d;d=make('details','adib-view-menu');const s=make('summary','','⋮');s.innerHTML='<svg viewBox="0 0 24 24" aria-hidden="true"><circle cx="12" cy="5" r="1.8"/><circle cx="12" cy="12" r="1.8"/><circle cx="12" cy="19" r="1.8"/></svg>';s.setAttribute('aria-label',label);s.setAttribute('aria-expanded','false');d.append(s,make('div','adib-view-menu-panel'));d.addEventListener('toggle',()=>s.setAttribute('aria-expanded',String(d.open)));host.append(d);return d;}
function filterMenu(layer,pop){if(pop.querySelector('[data-view-filter]'))return;const b=make('button','','Axtarış və filtrlər');b.type='button';b.dataset.viewFilter='true';b.onclick=()=>layer.__openFilters?.();pop.append(b);}
function calendar(){const host=document.getElementById('adibCalendar'),bar=host?.querySelector('.adib-calendar-bar');if(!bar)return;if(host.classList.contains('adib-tick-calendar')){const status=host.querySelector('.adib-calendar-status');if(status){const important=status.classList.contains('error')||/(gözləy|yoxlanılır|yüklən|uğursuz|alınmadı)/i.test(status.textContent);if(status.classList.contains('adib-quiet-status')===important)status.classList.toggle('adib-quiet-status',!important);}return;}let actions=bar.querySelector('.adib-standard-actions');if(!actions){actions=make('div','adib-standard-actions');const heading=bar.querySelector('h2');for(const n of [...bar.children])if(n!==heading)actions.append(n);bar.append(actions);}const d=menu(actions,'Təqvim parametrləri'),pop=d.lastElementChild;for(const n of [...actions.children]){if(n===d||n.matches('.adib-section-tick-trigger'))continue;if(n.id==='calendarViewMode'||n.tagName==='BUTTON'&&['‹','›','Bu gün','×'].includes(n.textContent.trim())){if(!n.classList.contains('adib-calendar-primary-control'))n.classList.add('adib-calendar-primary-control');}else move(n,pop);}
let b=pop.querySelector('[data-undated-toggle]');if(!b){b=make('button','','Tarixsiz tapşırıqlar');b.type='button';b.dataset.undatedToggle='true';b.onclick=()=>{const open=root.ADIBCalendar?.toggleUndated?root.ADIBCalendar.toggleUndated():host.classList.toggle('adib-show-undated');b.setAttribute('aria-pressed',String(open));};pop.append(b);}const text='Tarixsiz tapşırıqlar · '+host.querySelectorAll('.adib-calendar-undated .adib-calendar-task').length;if(b.textContent!==text)b.textContent=text;const status=host.querySelector('.adib-calendar-status');if(status){const important=status.classList.contains('error')||/(gözləy|yoxlanılır|yüklən|uğursuz|alınmadı)/i.test(status.textContent);if(status.classList.contains('adib-quiet-status')===important)if(status.classList.contains('adib-quiet-status')===important)status.classList.toggle('adib-quiet-status',!important);}}
function boards(){for(const layer of document.querySelectorAll('.personal-kanban-modal,.personal-eisenhower-modal')){layer.setAttribute('role','region');layer.removeAttribute('aria-modal');const matrix=layer.classList.contains('personal-eisenhower-modal'),head=layer.querySelector(matrix?'.personal-eisenhower-head':'.personal-kanban-head'),actions=head?.querySelector(matrix?'.personal-eisenhower-head-actions':'.personal-kanban-actions');if(!actions)continue;const d=menu(actions),pop=d.lastElementChild;filterMenu(layer,pop);if(matrix){for(const b of actions.querySelectorAll('.personal-eisenhower-add,.personal-eisenhower-close'))b.hidden=true;if(layer.id!=='adibFocusedMatrix')layer.id='adibFocusedMatrix';if(!pop.querySelector('[data-matrix-details]')){const b=make('button','','Tapşırıq detalları');b.type='button';b.dataset.matrixDetails='true';b.setAttribute('aria-pressed','false');b.onclick=()=>b.setAttribute('aria-pressed',String(layer.classList.toggle('adib-matrix-details')));pop.append(b);}if(!pop.querySelector('[data-matrix-close]')){const close=make('button','','Matrisi bağla');close.type='button';close.dataset.matrixClose='true';close.onclick=()=>layer.querySelector('.personal-eisenhower-close')?.click();pop.append(close);}}if(!matrix){for(const [selector,icon,label]of [['.personal-kanban-new-task','＋','Yeni tapşırıq'],['#personalKanbanViewModeButton','☷','Siyahı / Kanban']]){const b=layer.querySelector(selector);if(b){b.setAttribute('aria-label',label);if(!b.querySelector('svg'))b.innerHTML='<svg viewBox="0 0 24 24" aria-hidden="true"><path d="'+(icon==='＋'?'M12 4v16M4 12h16':'M4 5h16M4 12h16M4 19h16')+'"/></svg>';}}move(layer.querySelector('.personal-kanban-viewbar'),pop);move(layer.querySelector('.personal-subtask-add'),pop);for(const n of [...actions.children])if(n!==d&&!n.matches('.personal-kanban-close,.personal-kanban-new-task,#personalKanbanViewModeButton,.adib-section-tick-trigger'))move(n,pop);}}}

let equipmentMenuState={};
function equipment(){const modal=document.querySelector('#taskModal.open.kanban-modal'),phone=matchMedia('(max-width:700px)').matches;const active=!!modal&&phone;if(document.body.classList.contains('adib-equipment-board-open')!==active)document.body.classList.toggle('adib-equipment-board-open',active);if(!active){const head=modal?.querySelector('.adib-equipment-head'),list=modal?.querySelector('#taskList');if(head&&list){const controls=head.querySelector('.kanban-controls'),columns=head.querySelector('#kanbanColumnsPanel');if(columns)list.prepend(columns);if(controls)list.prepend(controls);head.remove();equipmentMenuState={};}return;}if(!modal.classList.contains('adib-phone-equipment'))modal.classList.add('adib-phone-equipment');const list=modal.querySelector('#taskList'),controls=list?.querySelector('.kanban-controls');if(!controls)return;const key=modal.dataset.machineId||modal.dataset.planBoardId||'';if(equipmentMenuState.key!==key)equipmentMenuState={key,open:false};let head=list.querySelector('.adib-equipment-head');if(!head){head=make('header','adib-equipment-head');const back=make('button','adib-equipment-back','');back.type='button';back.setAttribute('aria-label','Avadanlığa qayıt');back.innerHTML='<svg viewBox="0 0 24 24"><path d="m15 4-8 8 8 8"/></svg>';back.onclick=()=>{equipmentMenuState={};document.getElementById('closeModal')?.click();};const title=make('h1','','');const search=make('button','adib-equipment-search','');search.type='button';search.setAttribute('aria-label','Tapşırıqları axtarın');search.innerHTML='<svg viewBox="0 0 24 24"><circle cx="10" cy="10" r="7"/><path d="m15 15 6 6"/></svg>';head.append(back,title,search);list.prepend(head);const d=menu(head,'Görünüş və filtrlər');d.dataset.equipmentMenu='true';d.addEventListener('toggle',()=>{if(d.isConnected)equipmentMenuState.open=d.open;});const keep=e=>{equipmentMenuState.open=true;if(e.target.id==='kanbanSearch'){equipmentMenuState.focusId=e.target.id;equipmentMenuState.selection=e.target.selectionStart;}else equipmentMenuState.focusId='';};for(const type of ['input','change','click'])controls.addEventListener(type,keep,true);search.onclick=()=>{d.open=true;equipmentMenuState.open=true;boundedMenus();document.getElementById('kanbanSearch')?.focus({preventScroll:true});};d.open=!!equipmentMenuState.open;}
const d=head.querySelector('.adib-view-menu'),pop=d.lastElementChild;move(controls,pop);move(list.querySelector('#kanbanColumnsPanel'),pop);for(const [id,text]of [['kanbanViewModeButton',root.__adibKanbanViewMode==='kanban'?'Siyahı görünüşü':'Kanban görünüşü'],['kanbanColumnsButton','Sütunlar']]){const b=controls.querySelector('#'+id);if(b&&b.textContent!==text)b.textContent=text;}const direction=controls.querySelector('#kanbanSortDirection');if(direction&&!direction.textContent.includes('Sıralama'))direction.textContent+=' · Sıralama istiqaməti';const name=modal.__kanbanMachine?.name||'Avadanlıq',title=head.querySelector('h1'),label=(root.__adibKanbanViewMode==='kanban'?'Kanban: ':'')+name;if(title.textContent!==label)title.textContent=label;const input=document.getElementById(equipmentMenuState.focusId||'');if(input&&d.open&&document.activeElement!==input){input.focus({preventScroll:true});input.setSelectionRange(equipmentMenuState.selection??input.value.length,equipmentMenuState.selection??input.value.length);}}
function closePhoneMenus(){equipmentMenuState={};for(const record of boundedMenuRecords.values())closeBoundedMenu(record);for(const d of document.querySelectorAll('.adib-view-menu[open],.adib-design-overflow[open]'))d.open=false;}
function home(){const top=document.querySelector('.adib-home-top'),actions=top?.querySelector('.adib-home-top-actions');if(!actions)return;const existing=matchMedia('(max-width:700px)').matches?actions.querySelector('.adib-design-overflow'):null,old=actions.querySelector('.adib-view-menu');if(existing&&old){for(const n of [...old.lastElementChild.children])move(n,existing.lastElementChild);old.remove();}const d=existing||menu(actions);for(const n of top.querySelectorAll('.adib-home-refresh,.adib-home-sort,.adib-home-filter'))move(n,d.lastElementChild);}
function navigation(){const nav=document.querySelector('.adib-design-nav');if(!nav)return;let b=nav.querySelector('[data-design-nav="chat"]');if(!b&&(!root.ADIBAccount||root.ADIBAccount.section('chat'))){b=make('button','','');b.type='button';b.dataset.designNav='chat';b.dataset.designPermission='chat';b.setAttribute('aria-label','Müzakirələr');b.innerHTML='<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M4 4h16v12H9l-5 4V4zM8 8h8M8 12h5"/></svg><span>Müzakirələr</span>';b.onclick=()=>{if(root.ADIBHome?.canLeave()===false)return;root.ADIBHomeBridge?.closeViews?.();root.openCommentChat?.();};nav.append(b);}const chat=document.getElementById('adibChatOverlay');if(chat&&!chat.hidden)for(const n of nav.querySelectorAll('button')){if(n===b)n.setAttribute('aria-current','page');else n.removeAttribute('aria-current');}else b?.removeAttribute('aria-current');}
function taskFab(){const icon='<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 4v16M4 12h16"/></svg>';const homeAdd=document.querySelector('.adib-home-add');if(homeAdd&&!homeAdd.querySelector('svg'))homeAdd.innerHTML=icon;let fab=document.getElementById('adibTaskFab');if(!fab){fab=make('button','adib-task-fab','');fab.id='adibTaskFab';fab.type='button';fab.innerHTML=icon;fab.setAttribute('aria-label','Yeni tapşırıq');document.body.append(fab);fab.onclick=()=>{const equipment=document.querySelector('#taskModal.open.kanban-modal #kanbanNewTask');if(equipment){equipment.click();return;}if(document.querySelector('.tm-layer')){root.ADIBHomeBridge.newTask({});return;}const calendar=document.getElementById('adibCalendar');if(calendar){const date=calendar.querySelector('[data-calendar-time-day]')?.dataset.calendarTimeDay||root.ADIBClock.date().toISOString().slice(0,10),user=root.ADIBAccount?.user;if(user&&user.role!=='admin'){if(root.ADIBCalendar?.addTask)root.ADIBCalendar.addTask(date);else root.ADIBEquipmentCalendar?.newTask({date});return;}root.ADIBHomeBridge.newTask({calendar:true,date});return;}const layer=document.querySelector('.personal-kanban-modal,.personal-eisenhower-modal');const add=layer?.querySelector('.personal-kanban-new-task,.personal-eisenhower-head-actions button:not(.personal-eisenhower-close)');if(add){add.click();return;}const original=document.querySelector('#adibWorkspaceHeader .adib-header-new-task,#newCanvasTaskButton');original?.click();};}const chatOpen=!document.getElementById('adibChatOverlay')?.hidden&&!!document.getElementById('adibChatOverlay');const editorOpen=!!document.querySelector('#taskModal.open:not(.kanban-modal),.kanban-task-editor-layer,.personal-kanban-editor-layer');const specialized=!!document.querySelector('#adibCalendar,#taskModal.open.kanban-modal,.personal-kanban-modal,.personal-eisenhower-modal,.tm-layer');const home=document.body.classList.contains('adib-home-open')&&!specialized;fab.hidden=chatOpen||editorOpen||home;}
function chat(){const overlay=document.getElementById('adibChatOverlay');if(!overlay)return;overlay.setAttribute('role','region');overlay.removeAttribute('aria-modal');overlay.setAttribute('aria-label','Müzakirələr');}

// Existing installed PWAs may retain overlay mode until the manifest refreshes.
function titlebar(){const overlay=root.navigator.windowControlsOverlay;const update=()=>{const active=!!overlay?.visible||root.matchMedia('(display-mode: window-controls-overlay)').matches;let height=active?Math.max(32,overlay?.getTitlebarAreaRect?.().height||0):0;document.documentElement.style.setProperty('--adib-window-inset',height+'px');document.body.classList.toggle('adib-window-overlay',active);};update();overlay?.addEventListener('geometrychange',update);root.matchMedia('(display-mode: window-controls-overlay)').addEventListener('change',update);root.addEventListener('resize',update);}
function settings(){const panel=document.getElementById('adibSettingsMenu'),original=document.getElementById('adibSettingsButton');if(!panel)return;document.body.append(panel);panel.classList.add('adib-settings-portal');let anchor=original;
 const close=()=>{panel.hidden=true;original?.setAttribute('aria-expanded','false');anchor?.setAttribute('aria-expanded','false');};
 const open=button=>{anchor=button||original;const inset=parseFloat(getComputedStyle(document.documentElement).getPropertyValue('--adib-window-inset'))||0,rect=anchor?.getBoundingClientRect(),width=Math.min(340,innerWidth-24);panel.style.setProperty('left',Math.max(12,Math.min(innerWidth-width-12,rect?.left||12))+'px','important');panel.style.setProperty('top',Math.max(inset+12,Math.min(innerHeight-200,(rect?.bottom||inset)+8))+'px','important');panel.hidden=false;const panelHeight=panel.getBoundingClientRect().height;let top=(rect?.bottom||inset)+8;if(top+panelHeight>innerHeight-12)top=Math.max(inset+12,(rect?.top||innerHeight)-panelHeight-8);panel.style.setProperty('top',top+'px','important');panel.style.setProperty('max-height',Math.max(120,innerHeight-top-12)+'px','important');original?.setAttribute('aria-expanded','true');anchor?.setAttribute('aria-expanded','true');panel.querySelector('button,input,select')?.focus({preventScroll:true});};
 if(!panel.querySelector('[data-settings-close]')){const closeButton=make('button','','×');closeButton.type='button';closeButton.dataset.settingsClose='true';closeButton.setAttribute('aria-label','Ayarları bağlayın');closeButton.onclick=()=>{close();anchor?.focus({preventScroll:true});};panel.firstElementChild?.append(closeButton);}
 if(root.ADIBAccount&&!panel.querySelector('[data-settings-account]')){const account=make('button','','Hesab və profil');account.type='button';account.dataset.settingsAccount='true';account.onclick=()=>root.ADIBAccount.open();panel.append(account);}
 original?.addEventListener('click',e=>{e.stopImmediatePropagation();if(panel.hidden)open(original);else close();},true);
 document.addEventListener('keydown',e=>{if(e.key==='Escape'&&!panel.hidden){close();anchor?.focus({preventScroll:true});}});document.addEventListener('click',e=>{if(!panel.hidden&&!panel.contains(e.target)&&!anchor?.contains(e.target)&&!original?.contains(e.target))close();},true);root.addEventListener('resize',close);root.ADIBSettings={open,close};}

// Phone popups use the browser top layer, not a clipped editor/scroll container.
const boundedMenuRecords=new Map(),boundedMenuSelector='.adib-personal-actions-menu>div,.adib-photo-menu>div,.adib-view-menu>div,.adib-design-overflow>div,#canvasActionsPanel,.task-machine-results,#globalContextMenu,.adib-card-menu';
function menuLimits(){const v=root.visualViewport,left=v?.offsetLeft||0,top=Math.max(v?.offsetTop||0,parseFloat(getComputedStyle(document.documentElement).getPropertyValue('--adib-window-inset'))||0),right=left+(v?.width||innerWidth);let bottom=(v?.offsetTop||0)+(v?.height||innerHeight);const nav=document.querySelector('.adib-design-nav')?.getBoundingClientRect();if(nav&&nav.height&&nav.top>top&&nav.top<bottom)bottom=nav.top;return {left:left+8,top:top+8,right:right-8,bottom:bottom-8};}
function menuAnchor(panel){const d=panel.parentElement?.matches('details')?panel.parentElement:null;return {owner:d,anchor:d?.querySelector(':scope>summary')||(panel.id==='canvasActionsPanel'?document.getElementById('canvasActionsButton'):panel.classList.contains('adib-card-menu')?document.querySelector('[data-card-menu="'+panel.id+'"]'):panel.classList.contains('task-machine-results')?panel.closest('.task-machine-field')?.querySelector('input'):null)};}
function placeBoundedMenu(record){const {panel,anchor}=record;if(!panel.isConnected||!panel.matches(':popover-open'))return;const b=menuLimits(),r=anchor?.getBoundingClientRect()||record.virtual;if(!r||r.bottom<b.top||r.top>b.bottom){closeBoundedMenu(record);return;}const available=Math.max(80,b.right-b.left),width=Math.min(available,panel.classList.contains('adib-card-menu')?280:panel.classList.contains('adib-photo-menu-pop')?190:panel.matches('.adib-view-menu-panel,.adib-design-overflow>div')?340:Math.max(240,Math.min(340,r.width||0)));for(const [name,value]of Object.entries({position:'fixed',inset:'auto',margin:'0',transform:'none','box-sizing':'border-box',width:width+'px','min-width':'0','max-width':available+'px','max-height':Math.max(44,b.bottom-b.top)+'px','overflow-y':'auto','overflow-x':'hidden'}))panel.style.setProperty(name,value,'important');const height=panel.getBoundingClientRect().height,below=b.bottom-r.bottom-6,above=r.top-b.top-6,preferAbove=panel.classList.contains('adib-personal-actions-pop');let top=preferAbove&&above>=height||below<height&&above>below?r.top-height-6:r.bottom+6;top=Math.max(b.top,Math.min(b.bottom-height,top));panel.style.setProperty('left',Math.max(b.left,Math.min(b.right-width,r.right-width))+'px','important');panel.style.setProperty('top',top+'px','important');}
function closeBoundedMenu(record){const {panel,owner}=record;if(owner?.open)owner.open=false;if(record.hiddenPanel){panel.hidden=true;record.anchor?.setAttribute('aria-expanded','false');}if(panel.matches(':popover-open'))panel.hidePopover();}
function syncBoundedMenu(record){const {panel,owner}=record;const want=owner?owner.open:record.hiddenPanel?!panel.hidden:panel.matches(':popover-open');record.anchor?.setAttribute('aria-expanded',String(want));if(want){for(const item of panel.querySelectorAll('button,a'))if(item.style.getPropertyValue('min-height')!=='44px')item.style.setProperty('min-height','44px','important');if(panel.id==='globalContextMenu'&&!panel.matches(':popover-open')){const x=parseFloat(panel.style.left)||8,y=parseFloat(panel.style.top)||8;record.virtual={left:x,right:x,top:y,bottom:y};}panel.style.setProperty('display',record.display,'important');if(!panel.matches(':popover-open')){try{panel.showPopover({source:record.anchor})}catch{panel.showPopover()}}placeBoundedMenu(record);}else{if(panel.matches(':popover-open'))panel.hidePopover();panel.style.setProperty('display','none','important');}}
function boundedMenus(){const phone=matchMedia('(max-width:700px)').matches;for(const [panel,record]of boundedMenuRecords){if(!panel.isConnected){boundedMenuRecords.delete(panel);continue;}if(!phone){closeBoundedMenu(record);panel.classList.remove('adib-bounded-menu');if(record.style===null)panel.removeAttribute('style');else panel.setAttribute('style',record.style);if(record.popover===null)panel.removeAttribute('popover');else panel.setAttribute('popover',record.popover);boundedMenuRecords.delete(panel);}}if(!phone)return;for(const panel of document.querySelectorAll(boundedMenuSelector)){let record=boundedMenuRecords.get(panel);if(!record){const {owner,anchor}=menuAnchor(panel);if(!anchor&&panel.id!=='globalContextMenu')continue;record={panel,owner,anchor,hiddenPanel:panel.id==='canvasActionsPanel'||panel.id==='globalContextMenu'||panel.classList.contains('task-machine-results'),style:panel.getAttribute('style'),popover:panel.getAttribute('popover'),display:panel.matches('.adib-view-menu-panel,.adib-design-overflow>div')?'flex':'block'};boundedMenuRecords.set(panel,record);panel.classList.add('adib-bounded-menu');panel.setAttribute('popover','auto');}syncBoundedMenu(record);}}
root.addEventListener('click',event=>{const summary=event.target.closest?.('summary');if(!summary)return;const record=[...boundedMenuRecords.values()].find(r=>r.owner===summary.parentElement);if(!record)return;event.preventDefault();record.owner.open=!record.owner.open;syncBoundedMenu(record);},true);
root.addEventListener('pointerdown',event=>{for(const record of boundedMenuRecords.values())if(record.panel.matches(':popover-open')&&!record.panel.contains(event.target)&&!record.anchor?.contains(event.target))closeBoundedMenu(record);},true);
document.addEventListener('click',event=>{const action=event.target.closest?.('.adib-personal-actions-pop button,.adib-personal-actions-pop a,.adib-photo-menu-pop button,.adib-photo-menu-pop a');const record=action&&boundedMenuRecords.get(action.closest('.adib-personal-actions-pop,.adib-photo-menu-pop'));if(record)closeBoundedMenu(record);});
root.addEventListener('keydown',event=>{if(event.key!=='Escape')return;const open=[...boundedMenuRecords.values()].filter(r=>r.panel.matches(':popover-open'));if(!open.length)return;event.preventDefault();event.stopImmediatePropagation();const record=open[open.length-1];closeBoundedMenu(record);record.anchor?.focus({preventScroll:true});},true);
document.addEventListener('toggle',event=>{if(root.ADIBDesktop)return;const record=boundedMenuRecords.get(event.target);if(record&&event.newState==='closed'){record.panel.style.setProperty('display','none','important');if(record.owner?.isConnected)record.owner.open=false;if(record.hiddenPanel){record.panel.hidden=true;record.anchor?.setAttribute('aria-expanded','false');}}if(event.target.matches?.('details')||record)schedule();},true);
root.addEventListener('resize',schedule);root.visualViewport?.addEventListener('resize',schedule);root.visualViewport?.addEventListener('scroll',()=>{for(const record of boundedMenuRecords.values())placeBoundedMenu(record);});document.addEventListener('scroll',event=>{for(const record of boundedMenuRecords.values())if(!record.panel.contains(event.target))placeBoundedMenu(record);},true);

let frame=0;function update(){frame=0;if(root.ADIBDesktop){document.body.classList.remove('adib-focused-views');return;}if(!document.body.classList.contains('adib-focused-views'))document.body.classList.add('adib-focused-views');calendar();boards();equipment();home();chat();navigation();taskFab();boundedMenus();}function schedule(){if(!frame)frame=requestAnimationFrame(update)}
function start(){document.body.classList.add('adib-focused-views');titlebar();settings();new MutationObserver(schedule).observe(document.body,{childList:true,subtree:true,attributes:true,attributeFilter:['hidden','class']});update();}
document.addEventListener('click',e=>{const tab=e.target.closest?.('.adib-design-nav button');if(tab){closePhoneMenus();if(tab.dataset.designNav!=='chat')root.closeCommentChat?.();}const b=e.target.closest?.('.adib-view-menu-panel button');if(b&&!b.matches('[data-undated-toggle]')&&!b.closest('[data-equipment-menu]'))b.closest('details').open=false;for(const d of document.querySelectorAll('.adib-view-menu[open]'))if(!d.contains(e.target)&&!(d.dataset.equipmentMenu&&e.target.closest?.('.adib-equipment-search')))d.open=false;});document.addEventListener('keydown',e=>{if(e.key==='Escape')for(const d of document.querySelectorAll('.adib-view-menu[open]')){d.open=false;d.firstElementChild.focus();}});root.addEventListener('adib-home-data',schedule);root.ADIBFocusedViews={refresh:update};if(document.readyState==='loading')document.addEventListener('DOMContentLoaded',start);else start();
})(window);

/* Smooth equipment-camera updates. No object positions or persisted layouts change. */
(function smoothEquipmentCamera(root){
 'use strict';
 function createCameraAnimator({read,write,request,cancel,now,reduced=()=>false}){
  let frame=0,target=null,last=0;
  const clamp=value=>Math.max(.35,Math.min(3,value));
  function valueAt(scale){return{scale,ox:target.point.x-target.world.x*scale,oy:target.point.y-target.world.y*scale};}
  function tick(time){
   frame=0;if(!target)return;
   const current=read(),dt=Math.max(1,Math.min(64,time-last));last=time;
   const error=Math.log(target.scale/current.scale);
   if(reduced()||Math.abs(error)<.0002){write(valueAt(target.scale));target=null;return;}
   // Time-based smoothing is consistent on 60/90/120 Hz displays.
   const scale=current.scale*Math.exp(error*(1-Math.exp(-dt/38)));
   write(valueAt(scale));frame=request(tick);
  }
  function aim(scale,point,world){
   if(!Number.isFinite(scale)||scale<=0)return;
   target={scale:clamp(scale),point:{...point},world:{...world}};
   if(!frame){last=now();frame=request(tick);}
  }
  function stop(flush=false){
   if(frame)cancel(frame);frame=0;
   if(flush&&target)write(valueAt(target.scale));
   target=null;
  }
  return{aim,stop,targetScale:()=>target?.scale||read().scale};
 }
 root.ADIBSmoothEquipmentZoom={create:createCameraAnimator};
 function install(){
  if(typeof state==='undefined'||typeof svg==='undefined'||typeof point!=='function'
    ||typeof updatePinch!=='function'||typeof beginPinch!=='function')return;
  if(svg.dataset.smoothEquipmentZoom==='1')return;
  svg.dataset.smoothEquipmentZoom='1';
  const animator=createCameraAnimator({
   read:()=>({scale:state.scale,ox:state.ox,oy:state.oy}),
   write:camera=>{state.scale=camera.scale;state.ox=camera.ox;state.oy=camera.oy;apply();},
   request:callback=>root.requestAnimationFrame(callback),cancel:id=>root.cancelAnimationFrame(id),
   now:()=>performance.now(),reduced:()=>root.matchMedia('(prefers-reduced-motion: reduce)').matches
  });
  let panFrame=0,pan=null,pinchFrame=0,pinchCamera=null,inertiaFrame=0;
  let panLayer=null;
  const layerProperties=['transform','transform-origin','transform-box','will-change'];
  function drawPan(touch){
   if(!touch){apply();return;}
   if(!panLayer){
    panLayer=layerProperties.map(name=>[name,viewport.style.getPropertyValue(name),viewport.style.getPropertyPriority(name)]);
    viewport.style.setProperty('transform-box','view-box','important');
    viewport.style.setProperty('transform-origin','0px 0px','important');
    viewport.style.setProperty('will-change','transform');
   }
   // Translate the existing SVG layer; do not rewrite its SVG transform on each
   // touch frame. Fractional coordinates remain intact at every zoom level.
   viewport.style.setProperty('transform',`translate(${state.ox}px,${state.oy}px) scale(${state.scale})`,'important');
  }
  function commitPanLayer(){
   if(!panLayer)return;
   apply();
   for(const [name,value,priority]of panLayer){if(value)viewport.style.setProperty(name,value,priority);else viewport.style.removeProperty(name);}
   panLayer=null;
  }
  // Freeze the screen-to-SVG conversion for the gesture: reading getScreenCTM
  // after every transform forces a synchronous SVG layout on Android WebView.
  function coordinateReader(){
   const m=svg.getScreenCTM()?.inverse();
   return m?(x,y)=>({x:m.a*x+m.c*y+m.e,y:m.b*x+m.d*y+m.f}):(x,y)=>point(x,y);
  }
  function stopInertia(){if(inertiaFrame)root.cancelAnimationFrame(inertiaFrame);inertiaFrame=0;}
  function paintCamera(camera){state.scale=camera.scale;state.ox=camera.ox;state.oy=camera.oy;apply();}
  function flushPinch(){
   if(pinchFrame)root.cancelAnimationFrame(pinchFrame);pinchFrame=0;
   if(pinchCamera){paintCamera(pinchCamera);pinchCamera=null;}
  }
  function stopPinch(flush=false){if(flush)flushPinch();else{if(pinchFrame)root.cancelAnimationFrame(pinchFrame);pinchFrame=0;pinchCamera=null;}}
  function applyPan(){
   panFrame=0;if(!pan||state.drag!==pan.drag)return;
   state.ox=pan.ox+(pan.point.x-pan.start.x);
   state.oy=pan.oy+(pan.point.y-pan.start.y);
   state.last={...pan.point};drawPan(pan.touch);
  }
  function stopPan(flush=false){
   if(panFrame)root.cancelAnimationFrame(panFrame);panFrame=0;
   if(flush)applyPan();pan=null;
  }
  function trackPan(event){
   pan.point=pan.read(event.clientX,event.clientY);
   const sample={x:pan.point.x,y:pan.point.y,t:event.timeStamp};
   pan.samples.push(sample);
   pan.samples=pan.samples.filter(value=>sample.t-value.t<=90).slice(-12);
  }
  function coast(released,event){
   if(!released||event.pointerType!=='touch'||root.matchMedia('(prefers-reduced-motion: reduce)').matches)return;
   const samples=released.samples,last=samples[samples.length-1],first=samples[0];
   if(!last||!first||last.t-first.t<12||event.timeStamp-last.t>70)return;
   const dt=last.t-first.t;
   let vx=(last.x-first.x)/dt,vy=(last.y-first.y)/dt;
   const screen=svg.getScreenCTM(),factor=screen?Math.hypot(screen.a,screen.b):1;
   const speed=Math.hypot(vx,vy)*factor;
   if(speed<.12)return;
   const cap=Math.min(1,2.5/speed);vx*=cap;vy*=cap;
   let previous=performance.now(),elapsed=0;
   function tick(time){
    inertiaFrame=0;if(state.drag||document.hidden){commitPanLayer();return;}
    const step=Math.min(32,Math.max(0,time-previous));previous=time;elapsed+=step;
    const decay=Math.exp(-step/180),distance=180*(1-decay);
    state.ox+=vx*distance;state.oy+=vy*distance;vx*=decay;vy*=decay;drawPan(released.touch);
    if(elapsed<700&&Math.hypot(vx,vy)*factor>.025)inertiaFrame=root.requestAnimationFrame(tick);else commitPanLayer();
   }
   inertiaFrame=root.requestAnimationFrame(tick);return true;
  }
  // Keep touch movement 1:1: multiplying displacement also multiplies input jitter.
  // No easing while a finger is down. Draw latest input once
  // per frame; only a released touch swipe receives a short, interruptible coast.
  svg.addEventListener('pointermove',event=>{
   const drag=state.drag;
   if(!drag||drag.kind!=='canvas'||drag.mode!=='pan'||activePointers.size>=2
     ||(drag.pointerId!==undefined&&drag.pointerId!==event.pointerId))return;
   if(!pan||pan.drag!==drag){const read=coordinateReader();pan={drag,read,start:{...(state.last||read(event.clientX,event.clientY))},ox:state.ox,oy:state.oy,touch:event.pointerType==='touch',point:null,samples:[]};}
   const samples=event.getCoalescedEvents?.();
   for(const sample of samples||[])trackPan(sample);
   // The dispatched event is the newest position even when WebView exposes older coalesced samples.
   trackPan(event);
   if(activePointers.has(event.pointerId))activePointers.set(event.pointerId,{x:event.clientX,y:event.clientY});
   if(!panFrame)panFrame=root.requestAnimationFrame(applyPan);
   if(event.cancelable)event.preventDefault();event.stopImmediatePropagation();
  },{capture:true,passive:false});
  const originalBegin=root.beginPinch;
  let pinchRead=null;
  root.beginPinch=function(){stopInertia();stopPan(true);stopPinch(true);animator.stop(true);commitPanLayer();pinchRead=coordinateReader();return originalBegin();};
  root.updatePinch=function(){
   const points=pointerList();if(points.length<2||!pinchState)return;
   const middle=pointerMidpoint(points),distance=pointerDistance(points);if(distance<1)return;
   const anchor=(pinchRead||point)(middle.x,middle.y),scale=Math.max(.35,Math.min(3,pinchState.startScale*distance/pinchState.startDistance));
   pinchCamera={scale,ox:anchor.x-pinchState.worldX*scale,oy:anchor.y-pinchState.worldY*scale};
   if(!pinchFrame)pinchFrame=root.requestAnimationFrame(flushPinch);
  };
  root.zoomAt=function(factor,x=svg.getBoundingClientRect().left+svg.clientWidth/2,y=svg.getBoundingClientRect().top+svg.clientHeight/2){
   if(!Number.isFinite(factor)||factor<=0)return;
   const p=point(x,y),world={x:(p.x-state.ox)/state.scale,y:(p.y-state.oy)/state.scale};
   animator.aim(animator.targetScale()*factor,p,world);
  };
  svg.addEventListener('wheel',event=>{
   if(state.drag&&state.drag.kind!=='canvas')return;
   stopInertia();stopPan(true);stopPinch(true);commitPanLayer();
   event.preventDefault();event.stopImmediatePropagation();
   const pixels=event.deltaY*(event.deltaMode===1?16:event.deltaMode===2?svg.clientHeight:1);
   root.zoomAt(Math.exp(-Math.max(-160,Math.min(160,pixels))*.0018),event.clientX,event.clientY);
  },{capture:true,passive:false});
  // Commit the release point before the runtime transfers ownership to one finger.
  svg.addEventListener('pointerup',event=>{
   const released=pan;
   if(pan&&pan.drag.pointerId===event.pointerId)trackPan(event);
   stopPan(true);
   if(pinchState){
    if(activePointers.has(event.pointerId))activePointers.set(event.pointerId,{x:event.clientX,y:event.clientY});
    commitPanLayer();root.updatePinch();stopPinch(true);
   }else if(!released||!coast(released,event))commitPanLayer();
  },true);
  function interrupt(flush=false){stopInertia();stopPan(flush);stopPinch(flush);animator.stop(flush);commitPanLayer();}
  svg.addEventListener('pointercancel',()=>interrupt(false),true);
  document.addEventListener('pointerdown',()=>interrupt(true),true);
  document.addEventListener('wheel',event=>{if(!svg.contains(event.target))interrupt(false);},true);
  document.addEventListener('click',event=>{
   if(event.target.closest?.('#fit,#plus,#minus,#treePanel,[data-mobile-mode],[data-design-nav]'))interrupt(true);
  },true);
  const originalCancel=root.__adibCancelCanvasGesture;
  if(originalCancel)root.__adibCancelCanvasGesture=function(){interrupt(false);return originalCancel();};
  root.addEventListener('blur',()=>interrupt(false));
  root.addEventListener('resize',()=>interrupt(false));
  document.addEventListener('visibilitychange',()=>{if(document.hidden)interrupt(false);});
  root.ADIBSmoothEquipmentZoom.stop=()=>interrupt(false);
 }
 if(document.readyState==='loading')document.addEventListener('DOMContentLoaded',install,{once:true});else install();
})(window);
