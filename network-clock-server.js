'use strict';
const {performance}=require('node:perf_hooks');
const DEFAULT_SOURCES=['https://www.cloudflare.com/','https://www.microsoft.com/'];
class NetworkTime {
 constructor({fetchImpl=globalThis.fetch,mono=()=>performance.now(),sources=DEFAULT_SOURCES,timeZone='Asia/Baku',timeoutMs=4000,maxAgeMs=86400000}={}){
  new Intl.DateTimeFormat('en',{timeZone});Object.assign(this,{fetchImpl,mono,sources,timeZone,timeoutMs,maxAgeMs});this.anchor=null;this.inflight=null;this.error='';
 }
 now(){return this.anchor?this.anchor.epoch+Math.max(0,this.mono()-this.anchor.mono):NaN;}
 snapshot(){const age=this.anchor?Math.max(0,this.mono()-this.anchor.mono):Infinity,trusted=age<this.maxAgeMs;return {trusted,now:trusted?this.now():null,timeZone:this.timeZone,source:this.anchor?.source||null,checkedAt:this.anchor?new Date(this.anchor.epoch).toISOString():null,ageMs:Number.isFinite(age)?age:null,holdover:!!this.anchor&&!!this.error,error:this.error||null,version:'1.1.42',policy:'network-only',maxAgeMs:this.maxAgeMs};}
 async sync(force=false){if(this.inflight)return this.inflight;if(this.anchor&&this.mono()-this.anchor.mono<(force?5000:60000))return this.snapshot();this.inflight=(async()=>{
  const failures=[];
  for(const url of this.sources){const controller=new AbortController(),timer=setTimeout(()=>controller.abort(),this.timeoutMs);try{
   const before=this.mono();const response=await this.fetchImpl(url,{method:'HEAD',cache:'no-store',headers:{'Cache-Control':'no-cache'},signal:controller.signal,redirect:'follow'});const after=this.mono();const epoch=Date.parse(response.headers.get('date')||'');const age=Number(response.headers.get('age')||0);
   if(!response.ok||!Number.isFinite(epoch)||epoch<1577836800000||epoch>7258118400000||age>30||after-before>this.timeoutMs)throw Error('Unconfirmed Date header');
   this.anchor={epoch:epoch+(after-before)/2,mono:after,source:new URL(url).hostname};this.error='';return this.snapshot();
  }catch(e){failures.push(new URL(url).hostname+': '+(e.name==='AbortError'?'timeout':e.message));}finally{clearTimeout(timer);}}
  this.error='Şəbəkə vaxtını təsdiqləmək alınmadı';return this.snapshot();
 })().finally(()=>this.inflight=null);return this.inflight;}
}
module.exports={NetworkTime,DEFAULT_SOURCES};
