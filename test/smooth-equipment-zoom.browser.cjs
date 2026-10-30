// Run with Playwright installed: node test/smooth-equipment-zoom.browser.cjs
const {chromium}=require(process.env.PLAYWRIGHT_MODULE||'playwright'),fs=require('fs'),assert=require('assert');
(async()=>{const b=await chromium.launch({...(process.env.CHROMIUM_PATH?{executablePath:process.env.CHROMIUM_PATH}:{})});const page=await b.newPage({viewport:{width:390,height:844},hasTouch:true});
await page.setContent('<svg id="plan" viewBox="0 0 2400 1400" style="width:390px;height:700px;touch-action:none"><g id="viewport"><rect width="400" height="400"/></g></svg>');
await page.addScriptTag({content:`const state={scale:1,ox:0,oy:0,plans:[],equipment:[],drag:null,last:null,snapGuides:{}};const svg=document.getElementById('plan'),viewport=document.getElementById('viewport'),CANVAS_WIDTH=2400,CANVAS_HEIGHT=1400;function visibleObjects(){return []}function renderCanvas(){}function renderInspector(){}function select(){}function isLocked(){return true}`});
const runtime=fs.readFileSync(require('node:path').join(__dirname,'../realtime-runtime.js'),'utf8');await page.addScriptTag({content:runtime.slice(runtime.indexOf('function point(x,y)'),runtime.indexOf('function saveLocalPosition(a)'))});
await page.addScriptTag({content:'/* Smooth equipment-camera updates.'+fs.readFileSync(require('node:path').join(__dirname,'../focused-views.js'),'utf8').split('/* Smooth equipment-camera updates.')[1]});
await page.evaluate(()=>{window.emit=(type,id,x,y)=>svg.dispatchEvent(new PointerEvent(type,{pointerId:id,pointerType:'touch',clientX:x,clientY:y,bubbles:true,cancelable:true}));emit('pointerdown',1,100,300);emit('pointerdown',2,200,300);for(let i=0;i<10;i++){emit('pointermove',1,100-i*2,300);emit('pointermove',2,200+i*2,300)}});
await page.waitForTimeout(35);
let camera=await page.evaluate(()=>({...state}));assert(Math.abs(camera.scale-1.36)<.0001,'pinch must match fingers on the next frame, not ease towards them');
await page.evaluate(()=>emit('pointerup',1,82,300));camera=await page.evaluate(()=>({...state}));assert(Math.abs(camera.scale-1.36)<.0001);assert.equal(camera.drag.mode,'pan');
await page.evaluate(()=>emit('pointermove',2,228,305));await page.waitForTimeout(35);const pan=await page.evaluate(()=>({...state}));assert.notEqual(pan.ox,camera.ox);await page.evaluate(()=>emit('pointerup',2,228,305));assert.equal(await page.evaluate(()=>state.drag),null);
const old=pan.scale;await page.locator('#plan').dispatchEvent('wheel',{deltaY:-3,clientX:180,clientY:300});await page.waitForTimeout(220);camera=await page.evaluate(()=>({...state}));assert(camera.scale>old&&camera.scale<old*1.02,'small wheel delta must not jump ten percent');
await page.evaluate(()=>{zoomAt(1.2,150,300);__adibCancelCanvasGesture()});const after=await page.evaluate(()=>({...state}));await page.waitForTimeout(100);assert.equal(await page.evaluate(()=>state.scale),after.scale);

// Multiple input events must paint at most once per display frame, without smoothing pan.
await page.evaluate(()=>{emit('pointerdown',8,120,320);window.panStart={...state};window.startPoint=point(120,320);window.matrixReads=0;const getMatrix=svg.getScreenCTM.bind(svg);svg.getScreenCTM=()=>{matrixReads++;return getMatrix()};window.writes=0;const original=viewport.setAttribute.bind(viewport);viewport.setAttribute=(name,value)=>{if(name==='transform')window.writes++;return original(name,value)};for(let i=1;i<=60;i++)emit('pointermove',8,120+i,320+i/2);window.immediateWrites=window.writes;window.gestureMatrixReads=matrixReads;});
assert.equal(await page.evaluate(()=>window.immediateWrites),0,'pan rendered between input events');
await page.waitForTimeout(40);
const moved=await page.evaluate(()=>{const end=point(180,350);return{writes,dx:state.ox-panStart.ox,dy:state.oy-panStart.oy,expectedX:end.x-startPoint.x,expectedY:end.y-startPoint.y}});
assert.equal(await page.evaluate(()=>gestureMatrixReads),1,'screen matrix must be read once, not for every input event');assert.equal(moved.writes,0,'touch pan must not rewrite SVG transform every frame');assert(await page.evaluate(()=>viewport.style.transform.includes('translate(')));assert(Math.abs(moved.dx-moved.expectedX)<.001);assert(Math.abs(moved.dy-moved.expectedY)<.001);
await page.evaluate(()=>emit('pointerup',8,185,355));
const released=await page.evaluate(()=>({dx:state.ox-panStart.ox,expected:point(185,355).x-startPoint.x,drag:state.drag}));assert(Math.abs(released.dx-released.expected)<.001);assert.equal(released.drag,null);
await page.evaluate(()=>{emit('pointerdown',9,150,320);emit('pointermove',9,200,320);emit('pointercancel',9,200,320)});const cancelled=await page.evaluate(()=>state.ox);await page.waitForTimeout(50);assert.equal(await page.evaluate(()=>state.ox),cancelled);assert.equal(await page.evaluate(()=>viewport.style.transform),'','cancel must commit and remove the CSS override');

// A touch fling coasts after release; a new gesture stops it immediately.
await page.evaluate(()=>{
 window.timed=(type,x,t)=>{const e=new PointerEvent(type,{pointerId:20,pointerType:'touch',clientX:x,clientY:350,bubbles:true,cancelable:true});Object.defineProperty(e,'timeStamp',{value:t});svg.dispatchEvent(e);};
 timed('pointerdown',100,1000);timed('pointermove',110,1020);timed('pointermove',125,1040);timed('pointermove',145,1060);timed('pointerup',150,1070);window.releaseX=state.ox;
});
await page.waitForTimeout(65);assert((await page.evaluate(()=>state.ox))>await page.evaluate(()=>releaseX),'fling should coast');
await page.evaluate(()=>emit('pointerdown',21,150,350));const interrupted=await page.evaluate(()=>state.ox);await page.waitForTimeout(80);assert.equal(await page.evaluate(()=>state.ox),interrupted,'touch must stop inertia');await page.evaluate(()=>emit('pointercancel',21,150,350));
await page.emulateMedia({reducedMotion:'reduce'});
await page.evaluate(()=>{timed('pointerdown',100,2000);timed('pointermove',110,2020);timed('pointermove',150,2040);timed('pointerup',170,2060);window.releaseX=state.ox;});
await page.waitForTimeout(70);assert.equal(await page.evaluate(()=>state.ox),await page.evaluate(()=>releaseX),'reduced motion must disable coast');
// Camera sensitivity is measured in screen pixels, independent of zoom.
for(const scale of [.35,1,3]){
 for(const [pointerType,gain]of [['touch',1],['mouse',1]]){
  const result=await page.evaluate(({scale,pointerType})=>{
   state.scale=scale;state.ox=0;state.oy=0;apply();const before=viewport.getScreenCTM();
   const send=(type,x,y)=>svg.dispatchEvent(new PointerEvent(type,{pointerId:31,pointerType,clientX:x,clientY:y,bubbles:true,cancelable:true}));
   send('pointerdown',100,320);send('pointermove',160,350);send('pointerup',160,350);
   const after=viewport.getScreenCTM();return{dx:after.e-before.e,dy:after.f-before.f};
  },{scale,pointerType});
  assert(Math.abs(result.dx-60*gain)<.001,`${pointerType} x sensitivity at zoom ${scale}`);assert(Math.abs(result.dy-30*gain)<.001);
 }
}
// A stale coalesced sample must not override the newest dispatched position.
const coalesced=await page.evaluate(()=>{
 state.scale=1;state.ox=0;state.oy=0;apply();const before=viewport.getScreenCTM();
 emit('pointerdown',32,100,320);const event=new PointerEvent('pointermove',{pointerId:32,pointerType:'touch',clientX:160,clientY:350,bubbles:true,cancelable:true});
 event.getCoalescedEvents=()=>[new PointerEvent('pointermove',{clientX:110,clientY:325})];svg.dispatchEvent(event);emit('pointerup',32,160,350);
 const after=viewport.getScreenCTM();return after.e-before.e;
});assert(Math.abs(coalesced-60)<.001);
// Check the *rendered* layer on successive frames, not just stored coordinates.
for(const zoom of [.35,1,3]){
 await page.evaluate(zoom=>{state.scale=zoom;state.ox=0;state.oy=0;apply();window.originMatrix=viewport.getScreenCTM();emit('pointerdown',40,100,320);},zoom);
 for(let i=1;i<=8;i++){
  const x=100+i*3.25,y=320+i*1.5;await page.evaluate(({x,y})=>emit('pointermove',40,x,y),{x,y});
  await page.evaluate(()=>new Promise(resolve=>requestAnimationFrame(()=>requestAnimationFrame(resolve))));
  const rendered=await page.evaluate(()=>{const m=viewport.getScreenCTM();return{x:m.e-originMatrix.e,y:m.f-originMatrix.f};});
  assert(Math.abs(rendered.x-i*3.25)<.01,'rendered frame must follow touch without amplification');assert(Math.abs(rendered.y-i*1.5)<.01);
 }
 const beforeRelease=await page.evaluate(()=>{const m=viewport.getScreenCTM();return{x:m.e,y:m.f}});
 await page.evaluate(()=>emit('pointerup',40,126,332));
 const afterRelease=await page.evaluate(()=>{const m=viewport.getScreenCTM();return{x:m.e,y:m.f,style:viewport.style.transform}});
 assert(Math.abs(afterRelease.x-beforeRelease.x)<.01);assert(Math.abs(afterRelease.y-beforeRelease.y)<.01);assert.equal(afterRelease.style,'');
}
// Adding a second finger commits the temporary layer without moving its contents.
await page.evaluate(()=>{emit('pointerdown',50,100,320);emit('pointermove',50,120,330)});await page.waitForTimeout(35);
const handoffBefore=await page.evaluate(()=>{const m=viewport.getScreenCTM();return{x:m.e,y:m.f}});
await page.evaluate(()=>emit('pointerdown',51,200,330));
const handoffAfter=await page.evaluate(()=>{const m=viewport.getScreenCTM();return{x:m.e,y:m.f,style:viewport.style.transform}});
assert(Math.abs(handoffAfter.x-handoffBefore.x)<.01);assert(Math.abs(handoffAfter.y-handoffBefore.y)<.01);assert.equal(handoffAfter.style,'');await page.evaluate(()=>__adibCancelCanvasGesture());
console.log('PASS: continuous 1:1 layer rendering, no per-frame SVG attribute writes, no release/pinch handoff jump, mouse, inertia, cancel');await b.close();})().catch(error=>{console.error(error);process.exit(1)});
