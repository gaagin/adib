const fs=require('node:fs'),path=require('node:path'),assert=require('node:assert/strict');
const {chromium}=require(process.env.PLAYWRIGHT_MODULE||'playwright');
(async()=>{
 const browser=await chromium.launch({...(process.env.CHROMIUM_PATH?{executablePath:process.env.CHROMIUM_PATH}:{})});
 const page=await browser.newPage({viewport:{width:390,height:844},hasTouch:true});
 await page.route('http://adib.test/**',route=>route.fulfill({contentType:'text/html',body:'<html><body><div id="adibChatOverlay"></div></body></html>'}));await page.goto('http://adib.test/');
 await page.addStyleTag({content:fs.readFileSync(path.join(__dirname,'../discussions-ui.css'),'utf8')});
 await page.addScriptTag({content:`window.ADIBAccount={user:{id:'u1'},action:()=>false};window.dismissals=0;window.active='task-1';window.render=()=>{const overlay=document.getElementById('adibChatOverlay');overlay.innerHTML='<div class="adib-chat-conversation-head"><button data-chat-close>×</button></div><div class="adib-chat-messages" data-task-id="task-1"></div><div class="adib-chat-error"></div>';ADIBDiscussions.decorate(overlay)};`});
 await page.addScriptTag({content:fs.readFileSync(path.join(__dirname,'../discussions-ui.js'),'utf8')});
 await page.evaluate(()=>{ADIBDiscussions.bind({active:()=>active,get:()=>[],dismiss:()=>{dismissals++;active=''},render});render()});
 const stored=()=>page.evaluate(()=>JSON.parse(localStorage.getItem('adib-hidden-discussions-v1:u1')||'[]'));
 await page.locator('[data-discussion-hide]').click();assert.equal(await page.locator('dialog[open]').count(),1);assert.deepEqual(await stored(),[]);assert.equal(await page.evaluate(()=>dismissals),0);
 assert.equal(await page.locator('[data-archive-cancel]').evaluate(n=>n===document.activeElement),true);
 await page.locator('[data-archive-cancel]').click();await page.locator('dialog').waitFor({state:'detached'});assert.deepEqual(await stored(),[]);assert.equal(await page.locator('dialog').count(),0);
 await page.locator('[data-discussion-hide]').click();await page.keyboard.press('Escape');await page.locator('dialog').waitFor({state:'detached'});assert.deepEqual(await stored(),[]);assert.equal(await page.locator('dialog').count(),0);
 await page.locator('[data-discussion-hide]').click();assert(await page.locator('dialog p').innerText().then(s=>s.includes('Mesajlar silinməyəcək')));await page.locator('[data-archive-confirm]').click();await page.locator('dialog').waitFor({state:'detached'});assert.deepEqual(await stored(),['task-1']);assert.equal(await page.evaluate(()=>dismissals),1);
 // Restoring a discussion is immediate and does not show a destructive warning.
 await page.locator('[data-discussion-hide]').click();assert.deepEqual(await stored(),[]);assert.equal(await page.locator('dialog').count(),0);
 // The dialog is the top layer and fits narrow layouts in both themes.
 for(const width of [320,390,1280]){
  await page.setViewportSize({width,height:844});
  for(const dark of [false,true]){await page.evaluate(d=>document.documentElement.classList.toggle('dark',d),dark);await page.locator('[data-discussion-hide]').click();const box=await page.locator('dialog').boundingBox();assert(box.x>=0&&box.x+box.width<=width);await page.locator('[data-archive-cancel]').click();await page.locator('dialog').waitFor({state:'detached'});}
 }
 // Do not archive for a different account if identity changes while confirming.
 await page.locator('[data-discussion-hide]').click();await page.evaluate(()=>ADIBAccount.user.id='u2');await page.locator('[data-archive-confirm]').click();await page.locator('dialog').waitFor({state:'detached'});assert.deepEqual(await stored(),[]);
 await browser.close();console.log('PASS: explicit archive confirmation, cancel, Escape, restore, account switch, light/dark and narrow layout');
})().catch(error=>{console.error(error);process.exit(1)});
