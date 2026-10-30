const fs=require('node:fs'),path=require('node:path'),assert=require('node:assert/strict');
const {chromium}=require(process.env.PLAYWRIGHT_MODULE||'playwright');
(async()=>{
 const browser=await chromium.launch({...(process.env.CHROMIUM_PATH?{executablePath:process.env.CHROMIUM_PATH}:{})});
 const page=await browser.newPage({viewport:{width:390,height:844},hasTouch:true});
 await page.setContent('<body><button data-design-nav="calendar">Calendar</button><div id="adibChatOverlay"></div><div id="taskModal"><div class="modal"><button id="closeModal">Close</button><div id="taskList"></div></div></div></body>');
 await page.addScriptTag({content:`let chatActiveTaskId='task-a',chatMobileConversationOpen=true;const chatTextDrafts=new Map();window.rows=[{id:'task-a',title:'A'}];window.personal=false;window.fail=false;window.renders=0;
 window.ADIBAccount={ready:Promise.resolve(),user:{id:'u1'},section:()=>true};window.ADIBDiscussions={enabled:()=>true};
 window.renderCommentChat=()=>{renders++;const chat=document.getElementById('adibChatOverlay');chat.innerHTML='<div class="adib-chat-title"><strong>Task A</strong></div><button data-chat-open-task>Open</button><div class="adib-chat-messages" data-task-id="'+chatActiveTaskId+'" style="height:120px;overflow:auto"><div style="height:1000px">Messages</div></div><textarea id="adibChatInput"></textarea><div class="adib-chat-error"></div>';document.getElementById('adibChatInput').value=chatTextDrafts.get(chatActiveTaskId)||''};
 window.closeCommentChat=()=>{document.getElementById('adibChatOverlay').hidden=true;document.body.classList.remove('adib-chat-open','adib-discussions-fullscreen')};
 window.renderEditor=()=>{if(fail)throw Error('offline');document.getElementById('taskModal').classList.add('open');document.getElementById('taskList').innerHTML='<div class="'+(personal?'personal-task-editor':'task-editor')+'"><input id="editTitle" value="Task A"><button id="exitTask">Exit</button></div>';document.getElementById('exitTask').onclick=()=>document.getElementById('taskModal').classList.remove('open')};
 window.__openPersonalChatTask=async()=>renderEditor();window.ADIBHomeBridge={snapshot:()=>({tasks:personal?rows:[]})};window.ADIBEquipmentCalendar={tasks:()=>personal?[]:rows,open:async()=>renderEditor()};
 document.getElementById('closeModal').onclick=()=>document.getElementById('taskModal').classList.remove('open');
 window.prepare=kind=>{personal=kind==='personal';chatActiveTaskId='task-a';chatMobileConversationOpen=true;document.getElementById('adibChatOverlay').hidden=false;document.body.classList.add('adib-chat-open');renderCommentChat();document.querySelector('.adib-chat-messages').scrollTop=230;const input=document.getElementById('adibChatInput');input.value='unsent message';input.setSelectionRange(3,6)};
 `});
 const source=fs.readFileSync(path.join(__dirname,'../discussions-ui.js'),'utf8');await page.addScriptTag({content:source.slice(source.indexOf('/* Open the task represented'))});
 for(const kind of ['personal','equipment']){
  for(const closeMode of ['exit','x','back-to-list']){
   await page.evaluate(kind=>prepare(kind),kind);await page.locator('[data-chat-open-task]').click();assert.equal(await page.locator('#adibChatOverlay').evaluate(n=>n.hidden),true);
   // Editing and rerenders while the editor is active must not trigger return.
   await page.locator('#editTitle').fill('Changed');await page.waitForTimeout(40);assert.equal(await page.locator('#adibChatOverlay').evaluate(n=>n.hidden),true);
   if(closeMode==='exit')await page.locator('#exitTask').click();
   else if(closeMode==='x')await page.locator('#closeModal').click();
   else await page.evaluate(()=>document.getElementById('taskList').innerHTML='<div class="kanban-task">Task list</div>');
   await page.waitForFunction(()=>!document.getElementById('adibChatOverlay').hidden);await page.waitForTimeout(35);
   assert.equal(await page.evaluate(()=>chatActiveTaskId),'task-a');assert.equal(await page.evaluate(()=>chatMobileConversationOpen),true);
   assert.equal(await page.inputValue('#adibChatInput'),'unsent message');assert.equal(await page.locator('.adib-chat-messages').evaluate(n=>n.scrollTop),230);assert.equal(await page.locator('#adibChatInput').evaluate(n=>n.selectionStart),3);
   assert.equal(await page.locator('#taskModal').evaluate(n=>n.classList.contains('open')),false);
   // One-time watcher: closing another task directly must not reopen the chat.
   await page.evaluate(()=>{closeCommentChat();renderEditor()});await page.locator('#exitTask').click();await page.waitForTimeout(35);assert.equal(await page.locator('#adibChatOverlay').evaluate(n=>n.hidden),true);
  }
 }
 // Explicit navigation overrides the return destination.
 await page.evaluate(()=>prepare('equipment'));await page.locator('[data-chat-open-task]').click();await page.locator('[data-design-nav]').click();await page.locator('#exitTask').click();await page.waitForTimeout(35);assert.equal(await page.locator('#adibChatOverlay').evaluate(n=>n.hidden),true);
 // Failed opening must not install a later return trap.
 await page.evaluate(()=>{prepare('equipment');fail=true});await page.locator('[data-chat-open-task]').click();await page.waitForFunction(()=>document.querySelector('.adib-chat-error').textContent.includes('offline'));await page.evaluate(()=>{fail=false;closeCommentChat();renderEditor()});await page.locator('#exitTask').click();await page.waitForTimeout(35);assert.equal(await page.locator('#adibChatOverlay').evaluate(n=>n.hidden),true);
 await browser.close();console.log('PASS: personal/equipment tasks return to same discussion on Exit/X/back-to-list, preserve scroll/draft, one-shot, explicit navigation and failure cleanup');
})().catch(error=>{console.error(error);process.exit(1)});
