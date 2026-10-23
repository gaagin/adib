'use strict';
const test=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const vm=require('node:vm');

function makeWorker(fetchImpl){
 const listeners={};
 const entries=new Map();
 const cache={
  async match(request,{ignoreSearch=false}={}){
   const url=new URL(request.url);
   for(const [key,response] of entries){
    const saved=new URL(key);
    if(saved.origin===url.origin&&saved.pathname===url.pathname&&(ignoreSearch||saved.search===url.search))return response.clone();
   }
   return undefined;
  },
  async put(request,response){entries.set(request.url,response.clone())},
  async keys(){return [...entries.keys()].map(url=>({url}))},
  async delete(key){return entries.delete(typeof key==='string'?key:key.url)}
 };
 const caches={open:async()=>cache,keys:async()=>['adib-online-ui-shell-v1'],delete:async()=>true};
 const self={location:new URL('https://app.example/'),addEventListener:(type,fn)=>{listeners[type]=fn},skipWaiting:async()=>{},clients:{claim:async()=>{}}};
 const context={self,caches,fetch:fetchImpl,URL,Set,Promise,Response,console};
 vm.runInNewContext(fs.readFileSync(require.resolve('../sw.js'),'utf8'),context);
 return {listeners,cache,entries};
}
function navigation(url){return {url,method:'GET',mode:'navigate',headers:new Headers({'accept':'text/html'})}}
function dispatch(worker,request){
 const waits=[];let response;
 worker.listeners.fetch({request,respondWith:value=>{response=Promise.resolve(value)},waitUntil:value=>waits.push(Promise.resolve(value))});
 return {response,waits};
}
const shell='<html><body><div id="adibBootStatus">ADIB</div></body></html>';

test('cached app shell is served while the network refresh happens in the background',async()=>{
 let release;let fetchCalls=0;
 const worker=makeWorker(()=>{fetchCalls++;return new Promise(resolve=>{release=()=>resolve(new Response(shell.replace('ADIB','Updated'),{headers:{'Content-Type':'text/html'}}))})});
 await worker.cache.put(navigation('https://app.example/?source=pwa'),new Response(shell,{headers:{'Content-Type':'text/html'}}));
 const request=navigation('https://app.example/?source=pwa');
 const result=dispatch(worker,request);
 const response=await result.response;
 assert.match(await response.text(),/>ADIB</);
 assert.equal(fetchCalls,1);
 release();
 await Promise.all(result.waits);
 const refreshed=await worker.cache.match(navigation('https://app.example/'),{ignoreSearch:true});
 assert.match(await refreshed.text(),/>Updated</);
});

test('sign-in pages are returned but never replace the cached application shell',async()=>{
 const worker=makeWorker(async()=>new Response('<html><body>Sign in</body></html>',{headers:{'Content-Type':'text/html'}}));
 const result=dispatch(worker,navigation('https://app.example/'));
 const response=await result.response;
 assert.match(await response.text(),/Sign in/);
 await Promise.all(result.waits);
 assert.equal((await worker.cache.keys()).length,0);
});

test('API requests are not intercepted by the application-shell cache',()=>{
 const worker=makeWorker(async()=>{throw Error('should not fetch')});
 const result=dispatch(worker,{url:'https://app.example/api/personal-snapshot',method:'GET',mode:'cors'});
 assert.equal(result.response,undefined);
 assert.equal(result.waits.length,0);
});