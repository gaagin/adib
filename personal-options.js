(function(root){'use strict';
let cached={};try{cached=JSON.parse(localStorage.getItem('adib-personal-field-options')||'{}')}catch{}let flight;
const unique=rows=>[...new Set(rows.filter(v=>typeof v==='string'&&v.trim()))];
function values(key,tasks=[],selected=[]){return unique([...(cached[key]?.options||[]),...tasks.flatMap(t=>Array.isArray(t[key])?t[key]:[]),...selected]);}
function roots(task){return !String(task?.parentId||'').trim();}
function bind(list,{tasks=[],request,escapeHtml}){
 const fields=[['personalEditTags','tags'],['personalEditAssignees','assignees']];
 function selected(picker){return [...picker.querySelectorAll('input:checked')].map(i=>i.value);}
 function draw(picker,key){const current=selected(picker);const options=picker.querySelector('.personal-property-picker-options');options.innerHTML=values(key,tasks,current).map(v=>'<label class="personal-property-option"><input type="checkbox" value="'+escapeHtml(v)+'"'+(current.includes(v)?' checked':'')+'><span>'+escapeHtml(v)+'</span></label>').join('');if(!options.children.length)options.textContent='Вариантов пока нет';picker.querySelector('summary').textContent=current.join(', ')||'Не выбрано';}
 async function load(force=false){if(!flight)flight=(async()=>{const data=await request('/api/task-options?source=personal'+(force?'&refresh=1':''));if(!data.personal)throw Error('Notion не вернул варианты');cached={...cached,...data.personal};try{localStorage.setItem('adib-personal-field-options',JSON.stringify(cached))}catch{}return data;})().finally(()=>flight=null);return flight;}
 for(const [id,key]of fields){const picker=list.querySelector('#'+id);if(!picker)continue;const status=document.createElement('small');status.className='muted';status.setAttribute('role','status');const button=document.createElement('button');button.type='button';button.textContent='Обновить варианты';button.className='adib-task-link';picker.append(button,status);let busy=false;
 const refresh=async(force)=>{if(busy)return;busy=true;button.disabled=true;status.textContent='Загружаю варианты…';try{await load(force);if(picker.isConnected){draw(picker,key);status.textContent='Варианты обновлены';}}catch(e){if(picker.isConnected)status.textContent='Не удалось загрузить. Сохранённые варианты доступны. '+e.message;}finally{busy=false;button.disabled=false;}};
 picker.addEventListener('change',()=>{picker.querySelector('summary').textContent=selected(picker).join(', ')||'Не выбрано'});picker.addEventListener('toggle',()=>{if(picker.open){draw(picker,key);if(!cached[key])refresh(false)}});button.onclick=()=>refresh(true);
 }
}
root.ADIBPersonalOptions={values,bind,isRoot:roots};
})(window);
