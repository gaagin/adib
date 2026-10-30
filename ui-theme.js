window.ADIBAz={label:value=>({"Not started":"Başlanmayıb","In progress":"İcra olunur","Waiting":"Gözləyir","Done":"Tamamlanıb","Delegate":"Həvalə edilib","My Day":"Günüm","ToDo":"ToDo","Todo":"ToDo","Gorulen isler":"Görülən işlər","Is goruldu":"İş görülüb","Is gedir":"İş gedir","Sebeb analizi":"Səbəb təhlili","Problem hell olunmayib":"Problem həll olunmayıb","Gozlemede":"Gözləmədə","Planlandi":"Planlaşdırılıb","Sonra":"Sonra","Parca yoxdur":"Hissə yoxdur","open":"Tamamlanmamış","done":"Tamamlanmış","all":"Hamısı","Tapsirildi":"Tapşırılıb","Foto evvel":"İşdən əvvəl foto","Foto sonra":"İşdən sonra foto","admin":"İdarəçi","manager":"Rəhbər","employee":"Əməkdaş","todo":"ToDo","gorulen":"Görülən işlər"}[String(value)]||String(value??''))};
/* Native desktop windows share the main renderer's selected theme through same-origin storage. */
(function(){function apply(){try{typeof window.setTheme==='function'?window.setTheme(localStorage.getItem('ela-theme')==='dark'):document.documentElement.classList.toggle('dark',localStorage.getItem('ela-theme')==='dark')}catch{}}apply();addEventListener('storage',e=>{if(e.key==='ela-theme')apply()});})();


/* Per-user chat palette. This changes presentation only, never message data. */
(function chatPalette(root){
 'use strict';
 const key='adib-chat-palette-v1',choices=[['default','Standart'],['lavender','Lavanda'],['mint','Nanə'],['ice','Buz mavisi'],['sand','İsti qum']];
 const valid=value=>choices.some(([id])=>id===value)?value:'default';
 function read(){try{return valid(root.ADIBFilters?.getValue(key)||localStorage.getItem(key));}catch{return'default';}}
 function apply(value){
  value=valid(value);
  if(value==='default')document.documentElement.removeAttribute('data-adib-chat-palette');
  else document.documentElement.dataset.adibChatPalette=value;
  const select=document.getElementById('adibChatPaletteSelect');if(select)select.value=value;
 }
 function mount(){
  const host=document.getElementById('adibSettingsAdditionalItems')||document.getElementById('adibSettingsMenu');
  if(host&&!document.getElementById('adibChatPaletteSelect')){
   const section=document.createElement('section');section.className='adib-settings-item adib-chat-palette-setting';
   const label=document.createElement('label');label.className='adib-settings-label';label.htmlFor='adibChatPaletteSelect';label.textContent='Söhbət rəngi';
   const select=document.createElement('select');select.id='adibChatPaletteSelect';
   for(const [value,text]of choices){const option=document.createElement('option');option.value=value;option.textContent=text;select.append(option);}
   const preview=document.createElement('div');preview.className='adib-chat-palette-preview';preview.setAttribute('aria-hidden','true');preview.innerHTML='<span>Salam!</span><span>Salam! ✓</span>';
   const hint=document.createElement('small');hint.textContent='Rəng bütün söhbətlərə tətbiq olunur.';
   select.addEventListener('change',()=>{const value=valid(select.value);apply(value);try{if(root.ADIBFilters)root.ADIBFilters.setValue(key,value);else localStorage.setItem(key,value);}catch{} });
   section.append(label,select,preview,hint);host.append(section);
  }
  apply(read());
 }
 function start(){mount();root.ADIBAccount?.ready?.then(mount,()=>{});}
 root.addEventListener('storage',event=>{if(event.key===key||event.key==='adib-user-preferences-v1'||event.key===null)apply(read());});
 if(document.readyState==='loading')document.addEventListener('DOMContentLoaded',start,{once:true});else start();
})(window);
