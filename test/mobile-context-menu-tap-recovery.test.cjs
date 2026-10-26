'use strict';

const test=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const path=require('node:path');
const vm=require('node:vm');

const root=path.join(__dirname,'..');
const page=fs.readFileSync(path.join(root,'ela-nov-paketleme-dynamic.html'),'utf8');
const runtime=fs.readFileSync(path.join(root,'realtime-runtime.js'),'utf8');
const closeStart=page.indexOf('function adibContextClose(){');
const closeEnd=page.indexOf('\nfunction adibContextItem',closeStart);
assert.ok(closeStart>=0&&closeEnd>closeStart,'context-menu close function exists');
const closeFunction=page.slice(closeStart,closeEnd);

function closeContextMenu(open=true){
 let resetCalls=0;
 const context={
  adibContextMenu:{hidden:!open,innerHTML:'menu'},adibContextTarget:{id:'element'},adibContextSuppressUntil:Date.now()+1400,
  window:{adibContextSuppressUntil:Date.now()+1400,__adibResetCanvasTapState(){resetCalls++}}
 };
 vm.runInNewContext(closeFunction,context);
 context.adibContextClose();
 return{context,resetCalls};
}

test('closing the long-press menu clears stale click suppression and tap state',()=>{
 const{context,resetCalls}=closeContextMenu(true);
 assert.equal(context.adibContextMenu.hidden,true);
 assert.equal(context.adibContextMenu.innerHTML,'');
 assert.equal(context.adibContextTarget,null);
 assert.equal(context.adibContextSuppressUntil,0);
 assert.equal(context.window.adibContextSuppressUntil,0);
 assert.equal(resetCalls,1);
});

test('closing an already closed menu leaves unrelated tap state alone',()=>{
 const{context,resetCalls}=closeContextMenu(false);
 assert.notEqual(context.adibContextSuppressUntil,0);
 assert.equal(resetCalls,0);
});

test('the Android Back button dismisses an open context menu before navigating',()=>{
 assert.match(page,/function adibHandleAndroidBackAll\(event\)\{\s*if\(adibContextMenu&&!adibContextMenu\.hidden\)\{adibContextClose\(\);return\}/);
});

test('mobile canvas tap detector can be reset after dismissing a menu',()=>{
 assert.match(runtime,/window\.__adibResetCanvasTapState=\(\)=>\{mobileTapCandidate=null;mobileTapLast=null\}/);
 assert.match(page,/window\.__adibResetCanvasTapState\?\.\(\)/);
});
