'use strict';
class QueryPolicy {
 constructor({now=Date.now,backgroundMs=300000,refreshMs=60000}={}){Object.assign(this,{now,backgroundMs,refreshMs});this.states=new Map();this.stats={loads:0,coalesced:0,cooldownHits:0,failures:0};}
 async run(scope,{refresh=false,cached,load}){
  let s=this.states.get(scope);if(!s){s={flight:null,at:null,error:null,retryAt:0,failures:0};this.states.set(scope,s);}
  if(s.flight){this.stats.coalesced++;return s.flight;}
  const cache=cached(),now=this.now();
  if(s.error&&now<s.retryAt){this.stats.cooldownHits++;if(cache)return cache;throw s.error;}
  if(cache&&s.at!==null&&now-s.at<(refresh?this.refreshMs:this.backgroundMs)){this.stats.cooldownHits++;return cache;}
  this.stats.loads++;
  s.flight=Promise.resolve().then(load).then(value=>{s.at=this.now();s.error=null;if(value?.sync?.partial){s.failures++;s.retryAt=s.at+Math.min(1800000,this.backgroundMs*2**Math.min(s.failures-1,5));s.error=Object.assign(Error('Partial snapshot cooldown'),{statusCode:503});}else{s.failures=0;s.retryAt=0;}return value;},error=>{this.stats.failures++;s.failures++;s.error=error;s.retryAt=this.now()+Math.min(1800000,this.backgroundMs*2**Math.min(s.failures-1,5));throw error;}).finally(()=>{s.flight=null;});return s.flight;
 }
}
module.exports={QueryPolicy};
