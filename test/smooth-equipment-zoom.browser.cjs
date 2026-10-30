// Run with Playwright installed: node test/smooth-equipment-zoom.browser.cjs
const {chromium}=require(process.env.PLAYWRIGHT_MODULE||'playwright'),fs=require('fs'),assert=require('assert');
(async()=>{const b=await chromium.launch({...(process.env.CHROMIUM_PATH?{executablePath:process.env.CHROMIUM_PATH}:{})});const page=await b.newPage({viewport:{width:390,height:844},hasTouch:true});
await page.setContent('<svg id="plan" viewBox="0 0 2400 1400" style="width:390px;height:700px;touch-action:none"><g id="viewport"><rect width="400" height="400"/></g></svg>');
await page.addScriptTag({content:`const state={scale:1,ox:0,oy:0,plans:[],equipment:[],drag:null,last:null,snapGuides:{}};const svg=document.getElementById('plan'),viewport=document.getElementById('viewport'),CANVAS_WIDTH=2400,CANVAS_HEIGHT=1400;function visibleObjects(){return []}function renderCanvas(){}function renderInspector(){}function select(){}function isLocked(){return true}`});
const runtime=fs.readFileSync(require('node:path').join(__dirname,'../realtime-runtime.js'),'utf8');await page.addScriptTag({content:runtime.slice(runtime.indexOf('function point(x,y)'),runtime.indexOf('function saveLocalPosition(a)'))});
await page.addScriptTag({content:'/* Smooth equipment-camera updates.'+fs.readFileSync(require('node:path').join(__dirname,'../focused-views.js'),'utf8').split('/* Smooth equipment-camera updates.')[1]});
await page.evaluate(()=>{window.emit=(type,id,x,y)=>svg.dispatchEvent(new PointerEvent(type,{pointerId:id,pointerType:'touch',clientX:x,clientY:y,bubbles:true,cancelable:true}));emit('pointerdown',1,100,300);emit('pointerdown',2,200,300);for(let i=0;i<10;i++){emit('pointermove',1,100-i*2,300);emit('pointermove',2,200+i*2,300)}});
await page.waitForTimeout(150);
let camera=await page.evaluate(()=>({...state}));assert(camera.scale>1.35&&camera.scale<1.4);
await page.evaluate(()=>emit('pointerup',1,82,300));camera=await page.evaluate(()=>({...state}));assert(Math.abs(camera.scale-1.36)<.0001);assert.equal(camera.drag.mode,'pan');
await page.evaluate(()=>emit('pointermove',2,228,305));const pan=await page.evaluate(()=>({...state}));assert.notEqual(pan.ox,camera.ox);await page.evaluate(()=>emit('pointerup',2,228,305));assert.equal(await page.evaluate(()=>state.drag),null);
const old=pan.scale;await page.locator('#plan').dispatchEvent('wheel',{deltaY:-3,clientX:180,clientY:300});await page.waitForTimeout(220);camera=await page.evaluate(()=>({...state}));assert(camera.scale>old&&camera.scale<old*1.02,'small wheel delta must not jump ten percent');
await page.evaluate(()=>{zoomAt(1.2,150,300);__adibCancelCanvasGesture()});const after=await page.evaluate(()=>({...state}));await page.waitForTimeout(100);assert.equal(await page.evaluate(()=>state.scale),after.scale);
console.log('PASS: actual runtime pointer handlers, pinch release, one-finger continuation, fine wheel, cancel');await b.close();process.exit(0)})().catch(e=>{console.error(e);process.exit(1)});
