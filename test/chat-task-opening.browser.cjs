const fs=require('node:fs'),path=require('node:path'),assert=require('node:assert/strict');
const {chromium}=require(process.env.PLAYWRIGHT_MODULE||'playwright');
(async()=>{
 const browser=await chromium.launch({...(process.env.CHROMIUM_PATH?{executablePath:process.env.CHROMIUM_PATH}:{})});
 const page=await browser.newPage({viewport:{width:390,height:844},hasTouch:true});
 await page.setContent('<body class="adib-chat-open"><div id="adibChatOverlay"><header><button data-chat-open-task style="width:44px;height:44px">↗</button></header><div class="adib-chat-messages" data-task-id="task-1"></div><div class="adib-chat-error"></div></div><div id="taskModal"><div class="modal"><div id="taskList"></div></div></div></body>');
 await page.addScriptTag({content:`let chatPersonalTasks=[],state={plans:[]};window.homeTasks=[];window.equipmentTasks=[];window.opens=0;window.refreshes=0;window.legacyClicks=0;window.failOpen=false;window.serverTask=null;
 function closeCommentChat(){document.getElementById('adibChatOverlay').hidden=true;document.body.classList.remove('adib-chat-open')}
 function setPersonalMode(){}
 function taskById(){return null}
 async function refresh(){refreshes++;if(serverTask)equipmentTasks=[serverTask]}
 window.ADIBAccount={ready:Promise.resolve(),section:()=>true};
 window.ADIBHomeBridge={snapshot:()=>({tasks:homeTasks}),refresh:async()=>{refreshes++}};
 window.renderEditor=kind=>{if(failOpen)throw Error('offline');opens++;document.getElementById('taskModal').classList.add('open');document.getElementById('taskList').innerHTML='<div class="'+(kind==='personal'?'personal-task-editor':'task-editor')+'">Opened</div>'};
 window.__openPersonalChatTask=async()=>renderEditor('personal');
 window.ADIBEquipmentCalendar={tasks:()=>equipmentTasks,open:async()=>{await new Promise(r=>setTimeout(r,20));renderEditor('equipment')}};
 window.reset=()=>{document.getElementById('adibChatOverlay').hidden=false;document.body.classList.add('adib-chat-open');document.getElementById('taskModal').className='';document.getElementById('taskList').innerHTML='';document.querySelector('.adib-chat-error').textContent='';homeTasks=[];chatPersonalTasks=[];equipmentTasks=[];state.plans=[];failOpen=false;serverTask=null;};
 document.querySelector('[data-chat-open-task]').onclick=()=>legacyClicks++;
 `});
 const full=fs.readFileSync(path.join(__dirname,'../discussions-ui.js'),'utf8');await page.addScriptTag({content:full.slice(full.indexOf('/* Open the task represented'))});
 // The live home snapshot may be empty while the chat cache still has this task.
 await page.evaluate(()=>{chatPersonalTasks=[{id:'task-1'}]});await page.locator('[data-chat-open-task]').click();await page.waitForFunction(()=>document.getElementById('adibChatOverlay').hidden);assert.equal(await page.evaluate(()=>opens),1);assert.equal(await page.evaluate(()=>legacyClicks),0);
 // A detached/plan task must make the modal visible; it has no machine association.
 await page.evaluate(()=>{reset();equipmentTasks=[{id:'task-1',sourceKey:'gorulen'}]});await page.locator('[data-chat-open-task]').click();await page.waitForFunction(()=>document.getElementById('adibChatOverlay').hidden);assert(await page.locator('#taskModal').evaluate(n=>n.classList.contains('open')));
 // A cache miss refreshes stores before resolving, without a second user click.
 await page.evaluate(()=>{reset();serverTask={id:'task-1',sourceKey:'todo'}});await page.locator('[data-chat-open-task]').click();await page.waitForFunction(()=>document.getElementById('adibChatOverlay').hidden);assert((await page.evaluate(()=>refreshes))>=1);
 // Errors must remain in the visible conversation, rather than silently closing it.
 await page.evaluate(()=>{reset();equipmentTasks=[{id:'task-1'}];failOpen=true});await page.locator('[data-chat-open-task]').click();await page.waitForFunction(()=>document.querySelector('.adib-chat-error').textContent.includes('offline'));assert.equal(await page.locator('#adibChatOverlay').evaluate(n=>n.hidden),false);
 // A touch still activates if background polling replaces the button mid-press.
 await page.evaluate(()=>{reset();equipmentTasks=[{id:'task-1'}]});
 const box=await page.locator('[data-chat-open-task]').boundingBox(),x=box.x+box.width/2,y=box.y+box.height/2;
 await page.evaluate(({x,y})=>{const button=document.querySelector('[data-chat-open-task]');button.dispatchEvent(new PointerEvent('pointerdown',{pointerId:1,pointerType:'touch',clientX:x,clientY:y,bubbles:true}));button.replaceWith(button.cloneNode(true));},{x,y});
 const before=await page.evaluate(()=>opens);
 await page.evaluate(({x,y})=>document.querySelector('[data-chat-open-task]').dispatchEvent(new PointerEvent('pointerup',{pointerId:1,pointerType:'touch',clientX:x,clientY:y,bubbles:true,cancelable:true})),{x,y});
 await page.waitForFunction(()=>document.getElementById('adibChatOverlay').hidden);assert.equal(await page.evaluate(()=>opens),before+1);
 // Compatibility click after touch must not create another editor.
 await page.locator('[data-chat-open-task]').dispatchEvent('click',{detail:1});await page.waitForTimeout(40);assert.equal(await page.evaluate(()=>opens),before+1);

 // Dragging off the control does not accidentally open a task.
 await page.evaluate(()=>{reset();equipmentTasks=[{id:'task-1'}]});
 await page.evaluate(({x,y})=>{const button=document.querySelector('[data-chat-open-task]');for(const [type,dx]of [['pointerdown',0],['pointermove',30],['pointerup',0]])button.dispatchEvent(new PointerEvent(type,{pointerId:2,pointerType:'touch',clientX:x+dx,clientY:y,bubbles:true,cancelable:true}));},{x,y});await page.waitForTimeout(40);assert.equal(await page.evaluate(()=>opens),before+1);
 // Keyboard activation retains the normal click path, with in-flight deduplication.
 await page.locator('[data-chat-open-task]').focus();await page.keyboard.press('Enter');await page.waitForFunction(()=>document.getElementById('adibChatOverlay').hidden);assert.equal(await page.evaluate(()=>opens),before+2);
 await browser.close();console.log('PASS: empty/stale caches, detached tasks, refresh fallback, errors, touch with replaced header, no duplicate click, drag cancellation, keyboard');
})().catch(error=>{console.error(error);process.exit(1)});
