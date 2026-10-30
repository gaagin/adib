// Trusted touch input is required: synthetic PointerEvents cannot reproduce the
// browser taking over a pan-x gesture and cancelling the application's pointer.
const fs=require('node:fs'),path=require('node:path'),assert=require('node:assert/strict');
const {chromium}=require(process.env.PLAYWRIGHT_MODULE||'playwright');
(async()=>{
 const browser=await chromium.launch({...(process.env.CHROMIUM_PATH?{executablePath:process.env.CHROMIUM_PATH}:{})});
 const page=await browser.newPage({viewport:{width:390,height:844},hasTouch:true,isMobile:true});
 const base=path.join(__dirname,'..');
 await page.setContent(`<meta name="viewport" content="width=device-width,initial-scale=1"><style>
 body{margin:0}.canvas-wrap{width:390px;height:650px}#plan{width:390px;height:650px;touch-action:none}
 /* The conflicting rules are retained deliberately to test actual CSS priority. */
 .layout.mobile-canvas-mode .canvas-wrap{overflow-x:auto!important;overflow-y:hidden!important;touch-action:pan-x!important}
 .layout.mobile-canvas-mode .canvas-wrap #plan{touch-action:pan-x!important}
 .canvas-wrap{overflow:hidden!important;touch-action:none!important}.canvas-wrap #plan{touch-action:none!important}
 </style><section id="layout" class="layout mobile-canvas-mode"><div class="canvas-wrap"><svg id="plan" viewBox="0 0 2400 1400"><g id="viewport"><rect x="100" y="100" width="2200" height="1200" fill="#dce3f0"/></g></svg></div></section>`);
 await page.addScriptTag({content:`const state={scale:1,ox:0,oy:0,plans:[],equipment:[],drag:null,last:null,snapGuides:{}};const svg=document.getElementById('plan'),viewport=document.getElementById('viewport'),CANVAS_WIDTH=2400,CANVAS_HEIGHT=1400;function visibleObjects(){return []}function renderCanvas(){}function renderInspector(){}function select(){}function isLocked(){return true}window.cancels=0;svg.addEventListener('pointercancel',()=>cancels++);`});
 const runtime=fs.readFileSync(path.join(base,'realtime-runtime.js'),'utf8');await page.addScriptTag({content:runtime.slice(runtime.indexOf('function point(x,y)'),runtime.indexOf('function saveLocalPosition(a)'))});
 const cdp=await page.context().newCDPSession(page);
 async function swipe(dx,dy){
  await cdp.send('Input.dispatchTouchEvent',{type:'touchStart',touchPoints:[{x:100,y:320,id:1}]});
  for(let i=1;i<=8;i++){await cdp.send('Input.dispatchTouchEvent',{type:'touchMove',touchPoints:[{x:100+dx*i/8,y:320+dy*i/8,id:1}]});await page.waitForTimeout(18);}
  const value=await page.evaluate(()=>{const m=viewport.getScreenCTM();return{ox:state.ox,oy:state.oy,cancels,screenX:m.e,screenY:m.f}});
  await cdp.send('Input.dispatchTouchEvent',{type:'touchEnd',touchPoints:[]});return value;
 }
 assert.equal(await page.locator('#plan').evaluate(n=>getComputedStyle(n).touchAction),'pan-x');
 const legacy=await swipe(100,0);assert(legacy.cancels>0,'legacy pan-x must reproduce browser cancellation');
 await page.addScriptTag({content:'/* Smooth equipment-camera updates.'+fs.readFileSync(path.join(base,'focused-views.js'),'utf8').split('/* Smooth equipment-camera updates.')[1]});
 await page.emulateMedia({reducedMotion:'reduce'});
 assert.equal(await page.locator('#plan').evaluate(n=>getComputedStyle(n).touchAction),'none');
 assert.equal(await page.locator('.canvas-wrap').evaluate(n=>getComputedStyle(n).touchAction),'none');
 for(const [dx,dy]of [[100,0],[-60,0],[0,80],[70,50]]){
  await page.evaluate(()=>{__adibCancelCanvasGesture();state.ox=0;state.oy=0;apply();window.initial=viewport.getScreenCTM();cancels=0});
  const initial=await page.evaluate(()=>({x:initial.e,y:initial.f})),moved=await swipe(dx,dy);
  assert.equal(moved.cancels,0,'browser must not cancel horizontal, vertical or diagonal gestures');
  assert(Math.abs(moved.screenX-initial.x-dx)<1,`horizontal movement must follow touch: ${dx}`);
  assert(Math.abs(moved.screenY-initial.y-dy)<1,`vertical movement must follow touch: ${dy}`);
 }
 await browser.close();console.log('PASS: reproduced legacy horizontal pointercancel; trusted horizontal/vertical/diagonal swipes now stay 1:1 without browser takeover');
})().catch(error=>{console.error(error);process.exit(1)});
