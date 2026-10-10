'use strict';
// Only read schema. Never add or rename Notion status choices.
function create({notion,config,now=Date.now}) {
 const cache=new Map(),flights=new Map();
 async function schema(key,force=false){
  const c=config(key),identity=[key,c.dataSourceId,c.database].join(':');
  const old=cache.get(identity);if(!force&&old&&now()-old.at<300000)return old.value;
  if(flights.has(identity))return flights.get(identity);
  const job=(async()=>{let value;if(c.dataSourceId){try{value=await notion('/data_sources/'+c.dataSourceId,{method:'GET'});}catch(e){if(![400,404].includes(e.notionStatus)&&!/Notion API (400|404):/.test(e.message||''))throw e;if(!c.database)throw e;}}
   if(!value)value=await notion('/databases/'+c.database,{method:'GET'},'2022-06-28');
   if(!value.properties)throw Object.assign(Error('Notion sahələri yüklənmədi'),{statusCode:400,code:'TASK_SCHEMA_INVALID'});
   cache.set(identity,{at:now(),value});return value;})();
  flights.set(identity,job);try{return await job;}finally{flights.delete(identity);}
 }
 function fields(value,key){const c=config(key),result={};for(const field of ['process','priority']){const p=value.properties[c[field]];result[field]={available:!!p,type:p?.type||'',options:(p?.[p.type]?.options||[]).map(o=>o.name).filter(n=>typeof n==='string'&&n.trim())};}return result;}
 async function properties(body,key,raw,{creating=false}={}){
  if(!creating&&!['process','priority'].some(k=>body[k]!==undefined&&String(body[k]||'').trim()))return raw;
  const c=config(key),choices=fields(await schema(key),key),out={...raw};
  for(const field of ['process','priority']){let selected=String(body[field]||'').trim();const meta=choices[field];if(creating&&key==='gorulen'&&field==='process'&&(!selected||selected==='Not started')&&meta.options.includes('Problem hell olunmayib'))selected='Problem hell olunmayib';if(!selected)continue;
   // Legacy clients fabricate this initial value; absence lets Notion choose its own default.
   if(creating&&field==='process'&&selected==='Not started'&&!meta.options.includes(selected)){delete out[c[field]];continue;}
   if(!['select','status'].includes(meta.type)||!meta.options.includes(selected))throw Object.assign(Error('Notion: '+c[field]+' sahəsində «'+selected+'» seçimi yoxdur. Bazadakı mövcud seçimlərdən istifadə edin.'),{statusCode:400,code:'TASK_STATUS_INVALID'});
   out[c[field]]={[meta.type]:{name:selected}};
  }
  return out;
 }
 return {schema,fields,properties};
}
module.exports={create};
