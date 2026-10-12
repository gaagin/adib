'use strict';
// Cache is process-local and never performs authorization. Call only after existing access checks.
class ReadCache {
 constructor({now=Date.now,maxEntries=1000}={}){this.now=now;this.maxEntries=maxEntries;this.entries=new Map();this.stats={hits:0,loads:0,coalesced:0,failures:0,backoffHits:0};}
 entry(key){let e=this.entries.get(key);if(!e){if(this.entries.size>=this.maxEntries){for(const [k,v] of this.entries)if(!v.flight){this.entries.delete(k);break;}}e={has:false,at:0,value:null,flight:null,failures:0,retryAt:0,error:null,generation:0};this.entries.set(key,e);}return e;}
 async read(key,{ttlMs,load}){
  const e=this.entry(key),now=this.now();
  if(e.flight){this.stats.coalesced++;return e.flight;}
  if(now<e.retryAt){this.stats.backoffHits++;if(e.has)return {value:structuredClone(e.value),stale:true,error:e.error?.message};throw e.error;}
  if(e.has&&now-e.at<ttlMs){this.stats.hits++;return {value:structuredClone(e.value),stale:false};}
  const generation=e.generation;this.stats.loads++;
  e.flight=Promise.resolve().then(load).then(value=>{if(generation!==e.generation)return {value:structuredClone(e.value),stale:false};if(e.pending?.length&&Array.isArray(value)){const rows=new Map(value.map(x=>[x.id,x]));for(const item of e.pending)rows.set(item.id,item);value=[...rows.values()];e.pending=[];}e.has=true;e.at=this.now();e.value=structuredClone(value);e.failures=0;e.retryAt=0;e.error=null;return {value:structuredClone(value),stale:false};},error=>{if(generation!==e.generation&&e.has)return {value:structuredClone(e.value),stale:false};this.stats.failures++;e.failures++;e.error=error;e.retryAt=this.now()+Math.min(1800000,300000*2**Math.min(e.failures-1,5));if(e.has)return {value:structuredClone(e.value),stale:true,error:error.message};throw error;}).finally(()=>{e.flight=null;});return e.flight;
 }
 upsert(key,value){const e=this.entry(key);e.generation++;e.has=true;e.value=structuredClone(value);e.at=this.now();e.failures=0;e.retryAt=0;e.error=null;}
 append(key,item){const e=this.entries.get(key);if(!e?.has){if(e?.flight){e.pending=e.pending||[];e.pending.push(structuredClone(item));}return;}const value=[...e.value.filter(x=>x.id!==item.id),item];e.generation++;e.value=structuredClone(value);e.retryAt=0;e.error=null;e.failures=0;/* Preserve read age: appending one comment does not prove completeness. */}
}
module.exports={ReadCache};
