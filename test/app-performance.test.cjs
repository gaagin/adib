const test=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const vm=require('node:vm');
const path=require('node:path');

function accountEnv(fetchImpl){
  let authTimer, authDelay, revalidate;
  const document={readyState:'loading',documentElement:{style:{visibility:''}},addEventListener(){}};
  const window={document,location:{href:'https://adib.example/',replace(){}},fetch:fetchImpl,ADIBLoading:{screen:()=>({done(){},fail(){}})},addEventListener(){}};
  class MutationObserver{observe(){}}
  const context=vm.createContext({window,document,location:window.location,localStorage:{getItem:()=> 'user:1',clear(){},setItem(){}},URL,AbortController,MutationObserver,console,
    setTimeout(fn,ms){authTimer=fn;authDelay=ms;return 1;},clearTimeout(){},setInterval(fn){revalidate=fn;return 2;}});
  vm.runInContext(fs.readFileSync(path.join(__dirname,'../account-client.js'),'utf8'),context);
  return {window,document,runAuthTimeout(){authTimer?.();},get authDelay(){return authDelay;},get revalidate(){return revalidate;}};
}

test('transient session-check failure does not hide an already-open app',async()=>{
  let calls=0;
  const env=accountEnv(async()=>{
    calls++;
    if(calls===1)return {ok:true,json:async()=>({enabled:true,user:{id:'user',revision:1,role:'employee',name:'Test',rules:{sections:[],actions:[]}}})};
    throw Error('temporary offline');
  });
  await env.window.ADIBAccount.ready;
  assert.equal(env.document.documentElement.style.visibility,'');
  await env.revalidate();
  assert.equal(env.document.documentElement.style.visibility,'');
});

test('initial sign-in check has a timeout so startup cannot spin forever',async()=>{
  let signal;
  const env=accountEnv((url,options)=>new Promise((resolve,reject)=>{
    signal=options.signal;
    signal.addEventListener('abort',()=>reject(Error('request timed out')),{once:true});
  }));
  assert.equal(env.authDelay,10000);
  env.runAuthTimeout();
  await assert.rejects(env.window.ADIBAccount.ready,/timed out/);
  assert.equal(signal.aborted,true);
});

test('home list no longer serializes and redraws all tasks every second',()=>{
  const source=fs.readFileSync(path.join(__dirname,'../home-screen.js'),'utf8');
  assert.doesNotMatch(source,/setInterval\(\(\)=>\{if\(!host\.hidden\)render\(false\)\},1000\)/);
  assert.match(source,/adib-clock-change/);
});
