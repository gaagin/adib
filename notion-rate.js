'use strict';
/** One rate gate for all core Notion callers. Never retry ambiguous creates. */
class NotionRateGate{
 constructor({fetchFn=(...args)=>fetch(...args),spacingMs=350,sleep=ms=>new Promise(r=>setTimeout(r,ms)),now=Date.now}={}){Object.assign(this,{fetchFn,spacingMs,sleep,now});this.tail=Promise.resolve();this.next=0;}
 slot(){const job=this.tail.then(async()=>{const wait=Math.max(0,this.next-this.now());if(wait)await this.sleep(wait);this.next=this.now()+this.spacingMs;});this.tail=job.catch(()=>{});return job;}
 async request(url,options){for(let attempt=0;;attempt++){await this.slot();const response=await this.fetchFn(url,options);const read=!(options.method)||options.method==='GET'||(options.method==='POST'&&url.endsWith('/query'));if(attempt>=3||!(response.status===429||(read&&response.status>=500)))return response;const seconds=Number(response.headers.get('retry-after'));const delay=Math.max(this.spacingMs,Number.isFinite(seconds)&&seconds>0?seconds*1000:1000*2**attempt);this.next=Math.max(this.next,this.now()+Math.min(delay,60000));await response.text();}}
}
module.exports={NotionRateGate};
