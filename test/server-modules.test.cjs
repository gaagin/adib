'use strict';
const test=require('node:test'),assert=require('node:assert/strict'),fs=require('node:fs'),path=require('node:path'),os=require('node:os'),{spawn}=require('node:child_process');
const root=path.resolve(__dirname,'..');
const modules=['notion','models','snapshots','equipment','personal','content','task-writes','pomodoro','access'];
test('server domains initialize without reading dependencies or starting side effects',()=>{
 const context=new Proxy({},{get(_,name){throw Error('eager dependency '+String(name));}});
 for(const name of modules){const file=path.join(root,'server-'+name+'.js');assert(fs.statSync(file).size<60000);const api=require(file)(context);assert(Object.keys(api).length);assert(Object.values(api).every(f=>typeof f==='function'));}
 assert(fs.statSync(path.join(root,'server.js')).size<60000);
});
test('personal cache invalidation updates live shared bindings',()=>{
 let cache={stale:true},generation=4;
 const context={get personalTasksCache(){return cache},set personalTasksCache(value){cache=value},get personalTasksGeneration(){return generation},set personalTasksGeneration(value){generation=value}};
 const api=require('../server-personal')(context);api.invalidatePersonalTasks();assert.equal(cache,null);assert.equal(generation,5);
});
test('modular server starts, responds, serves public UI and keeps backend modules private',async()=>{
 const dir=fs.mkdtempSync(path.join(os.tmpdir(),'adib-modules-'));
 const child=spawn(process.execPath,['server.js'],{cwd:root,env:{...process.env,PORT:'0',NOTION_TOKEN:'',ADIB_ACCOUNTS_ENABLED:'0',TASK_MANAGEMENT_FILE:path.join(dir,'tasks.json'),POMODORO_STATE_FILE:path.join(dir,'pomodoro.json'),COMPLETION_HISTORY_FILE:path.join(dir,'history.json')},stdio:['ignore','pipe','pipe']});
 let logs='';child.stderr.on('data',b=>logs+=b);
 try{
 const base=await new Promise((resolve,reject)=>{const timeout=setTimeout(()=>reject(Error('startup timeout '+logs)),10000);child.once('exit',code=>{clearTimeout(timeout);reject(Error('exit '+code+' '+logs));});child.stdout.on('data',b=>{logs+=b;const m=logs.match(/http:\/\/localhost:(\d+)/);if(m){clearTimeout(timeout);resolve('http://127.0.0.1:'+m[1]);}});});
 assert.equal((await fetch(base+'/api/health')).status,200);
 assert.equal((await fetch(base+'/account.html')).status,200);
 assert.equal((await fetch(base+'/team-view.js')).status,200);
 for(const name of modules)assert.equal((await fetch(base+'/server-'+name+'.js')).status,404);
 assert.equal((await fetch(base+'/api/missing')).status,404);
 }finally{child.kill();await new Promise(r=>child.once('exit',r));fs.rmSync(dir,{recursive:true,force:true});}
});
