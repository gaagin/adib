'use strict';
// Per-process, per-scope single flight + cooldown. No page/query response cache.
class SyncReadGuard {
 constructor({now=()=>Date.now(),intervalMs=300000,maxBackoffMs=1800000}={}){this.now=now;this.intervalMs=intervalMs;this.maxBackoffMs=maxBackoffMs;this.states=new Map();}
 async read(key,load,local){
  let s=this.states.get(key);if(!s){s={next:0,flight:null,failures:0,loaded:false,error:null};this.states.set(key,s);}
  if(s.flight)return s.flight;
  if(this.now()<s.next){if(s.loaded)return local();throw s.error;}
  s.flight=Promise.resolve().then(load).then(value=>{
   s.loaded=true;s.error=null;
   if(value?.sync?.partial){s.failures++;s.next=this.now()+Math.min(this.maxBackoffMs,this.intervalMs*2**Math.min(s.failures,5));}
   else{s.failures=0;s.next=this.now()+this.intervalMs;}
   return value;
  },error=>{s.error=error;s.failures++;s.next=this.now()+Math.min(this.maxBackoffMs,this.intervalMs*2**Math.min(s.failures,5));throw error;}).finally(()=>s.flight=null);
  return s.flight;
 }
}
module.exports={SyncReadGuard};
