'use strict';

const test=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const path=require('node:path');
const vm=require('node:vm');

const runtime=fs.readFileSync(path.join(__dirname,'..','realtime-runtime.js'),'utf8');
const page=fs.readFileSync(path.join(__dirname,'..','ela-nov-paketleme-dynamic.html'),'utf8');

function evaluateLockHelpers(initial={}){
 const isLocked=runtime.match(/function isLocked\(id\)\{[^}]*\}/)?.[0];
 const setLocked=runtime.match(/function setLocked\(id,value\)\{[^\n]*\}/)?.[0];
 assert.ok(isLocked&&setLocked,'lock helpers are present');
 const storage={value:JSON.stringify(initial),getItem(){return this.value},setItem(_key,value){this.value=value}};
 const context={localStorage:storage,state:{locks:JSON.parse(storage.value)}};
 vm.runInNewContext(`const LOCKS_KEY='ela-element-locks-v1';${isLocked}\n${setLocked}`,context);
 return{context,storage};
}

test('canvas elements are locked by default and unlock state persists',()=>{
 const{context,storage}=evaluateLockHelpers();
 assert.equal(context.isLocked('new-equipment'),true);
 context.setLocked('new-equipment',false);
 assert.equal(context.isLocked('new-equipment'),false);
 assert.deepEqual(JSON.parse(storage.value),{'new-equipment':false});
 const reloaded=evaluateLockHelpers(JSON.parse(storage.value));
 assert.equal(reloaded.context.isLocked('new-equipment'),false);
});

test('lock controls only movement and resizing; element entry remains available',()=>{
 assert.match(runtime,/function startDrag\(e,id,kind\)\{[^\n]*if\(!a\|\|isLocked\(id\)\)return/);
 assert.match(runtime,/function startResize\(e,id,kind\)\{[^\n]*if\(!a\|\|isLocked\(id\)\)return/);
 assert.match(runtime,/if\(state\.selected===o\.id&&!isLocked\(o\.id\)\)/);
 assert.match(runtime,/icon\.addEventListener\('click',e=>\{e\.stopPropagation\(\);o\.kind==='equipment'\?openTasks\(o\.id\):openPlan\(o\.id\)\}\)/);
 assert.match(runtime,/window\.ADIBCanvasElementLock=\{getSelected:selectedCanvasLockTarget,toggleSelected\(\)/);
 assert.match(page,/id='canvasLockToggle'/);
 assert.match(page,/window\.ADIBCanvasElementLock\?\.toggleSelected\(\)/);
 assert.match(runtime,/isLocked\(o\.id\)\?'#65717e':'#8da4ff'/);
});

test('locked canvas elements keep a normal clickable cursor',()=>{
 assert.match(page,/\.locked\{cursor:pointer!important/);
 assert.doesNotMatch(page,/\.locked\{cursor:not-allowed/);
});
