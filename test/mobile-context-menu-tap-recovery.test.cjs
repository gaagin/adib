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

test('opening a long-press menu clears pointer capture state and any in-progress canvas drag',()=>{
 const start=runtime.indexOf('window.__adibCancelCanvasGesture=()=>{');
 const end=runtime.indexOf(';\nlet dragRenderFrame',start)+1;
 assert.ok(start>=0&&end>start,'canvas gesture cleanup helper exists');
 const helper=runtime.slice(start,end);
 const equipment={id:'eq-1',x:40,y:50};let canvasRendered=0,inspectorRendered=0;
 const context={
  window:{},
  state:{drag:{id:'eq-1',kind:'equipment',mode:'move',pointerId:7,startValues:{x:4,y:5}},last:{},snapGuides:{x:10,y:20},equipment:[equipment],plans:[]},
  activePointers:new Map([[7,{x:1,y:2}]]),pinchState:{active:true},
  svg:{classList:{remove(value){this.removed=value}}},mobileTapCandidate:{id:'eq-1'},mobileTapLast:{id:'eq-1'},equipmentGestureSuppressUntil:900,
  renderCanvas(){canvasRendered++},renderInspector(){inspectorRendered++}
 };
 vm.runInNewContext(helper,context);
 context.window.__adibCancelCanvasGesture();
 assert.equal(context.activePointers.size,0);
 assert.equal(context.state.drag,null);
 assert.deepEqual([equipment.x,equipment.y],[4,5]);
 assert.equal(context.pinchState,null);
 assert.equal(context.mobileTapCandidate,null);
 assert.equal(context.mobileTapLast,null);
 assert.equal(context.equipmentGestureSuppressUntil,0);
 assert.equal(context.svg.classList.removed,'panning');
 assert.equal(canvasRendered,1);
 assert.equal(inspectorRendered,1);
});

test('the long-press timer and menu-close path both clear canvas gesture state',()=>{
 assert.match(page,/adibContextSuppressUntil=window\.ADIBClock\.stamp\(\)\+1400;window\.__adibCancelCanvasGesture\?\.\(\);/);
 assert.match(page,/window\.__adibCancelCanvasGesture\?\.\(\);window\.__adibResetCanvasTapState\?\.\(\)/);
});
