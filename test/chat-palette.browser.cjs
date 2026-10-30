// Run with PLAYWRIGHT_MODULE and CHROMIUM_PATH when using a custom installation.
const fs=require('node:fs'),path=require('node:path'),assert=require('node:assert/strict');
const {chromium}=require(process.env.PLAYWRIGHT_MODULE||'playwright');
const base=path.join(__dirname,'..');
(async()=>{
 const browser=await chromium.launch({...(process.env.CHROMIUM_PATH?{executablePath:process.env.CHROMIUM_PATH}:{})});
 const context=await browser.newContext({viewport:{width:390,height:844}});
 const html=`<html><head><style>${fs.readFileSync(path.join(base,'discussions-ui.css'),'utf8')}\n${fs.readFileSync(path.join(base,'whatsapp-discussions.css'),'utf8')}</style></head><body class="adib-chat-open adib-discussions-fullscreen"><div id="adibSettingsMenu"><div id="adibSettingsAdditionalItems"></div></div><div id="adibChatOverlay"><div class="adib-chat-messages"><div class="adib-chat-bubble">Salam!</div><div class="adib-chat-bubble mine">Salam!</div></div></div><script>${fs.readFileSync(path.join(base,'filter-memory.js'),'utf8')}</script><script>${fs.readFileSync(path.join(base,'ui-theme.js'),'utf8')}</script></body></html>`;
 let saved=null;
 await context.route('http://adib.test/**',route=>{if(route.request().url().includes('/api/')){if(route.request().method()==='PUT')saved=route.request().postDataJSON();return route.fulfill({contentType:'application/json',body:JSON.stringify({enabled:false,settings:saved||{},updatedAt:Date.now()})});}return route.fulfill({contentType:'text/html',body:html});});
 const page=await context.newPage();await page.goto('http://adib.test/');
 assert.equal(await page.locator('#adibChatPaletteSelect option').count(),5);
 const colors={lavender:['rgb(241, 242, 250)','rgb(226, 230, 255)'],mint:['rgb(239, 245, 242)','rgb(216, 238, 227)'],ice:['rgb(237, 243, 248)','rgb(216, 233, 250)'],sand:['rgb(246, 242, 235)','rgb(238, 224, 202)']};
 const inspect=()=>page.evaluate(()=>({canvas:getComputedStyle(document.querySelector('.adib-chat-messages')).backgroundColor,outgoing:getComputedStyle(document.querySelector('.mine')).backgroundColor,incoming:getComputedStyle(document.querySelector('.adib-chat-bubble:not(.mine)')).backgroundColor,pattern:getComputedStyle(document.querySelector('.adib-chat-messages')).backgroundImage}));
 for(const [name,[canvas,outgoing]]of Object.entries(colors)){
  await page.selectOption('#adibChatPaletteSelect',name);let style=await inspect();assert.equal(style.canvas,canvas);assert.equal(style.outgoing,outgoing);assert.equal(style.incoming,'rgb(255, 255, 255)');assert(style.pattern.includes('data:image/svg+xml'));
  await page.evaluate(()=>document.documentElement.classList.add('dark'));style=await inspect();assert.notEqual(style.canvas,canvas);assert.notEqual(style.outgoing,outgoing);await page.evaluate(()=>document.documentElement.classList.remove('dark'));
 }
 await page.selectOption('#adibChatPaletteSelect','mint');await page.reload();assert.equal(await page.inputValue('#adibChatPaletteSelect'),'mint');
 assert.equal(await page.evaluate(()=>JSON.parse(localStorage.getItem('adib-user-preferences-v1')).values['adib-chat-palette-v1']),'mint');
 const second=await context.newPage();await second.goto('http://adib.test/');await second.selectOption('#adibChatPaletteSelect','ice');await page.waitForTimeout(60);assert.equal(await page.inputValue('#adibChatPaletteSelect'),'ice','palette should update across tabs');
 await page.selectOption('#adibChatPaletteSelect','default');assert.equal(await page.getAttribute('html','data-adib-chat-palette'),null);
 assert(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth),'settings must fit narrow screen');
 await context.close();await browser.close();console.log('PASS: four palettes, instant application, pattern preserved, light/dark, persisted selection, shared tabs, reset');
})().catch(error=>{console.error(error);process.exit(1)});
