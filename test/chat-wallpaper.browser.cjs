// Run with Playwright installed: node test/chat-wallpaper.browser.cjs
const {chromium}=require(process.env.PLAYWRIGHT_MODULE||'playwright');
const fs=require('node:fs'),path=require('node:path'),assert=require('node:assert/strict');
(async()=>{
 const browser=await chromium.launch({headless:true,...(process.env.CHROMIUM_PATH?{executablePath:process.env.CHROMIUM_PATH}:{})});
 try{
  const page=await browser.newPage();
  await page.setContent('<html><body class="adib-chat-open adib-discussions-fullscreen"><div id="adibChatOverlay"><div class="adib-chat-conversation-head">Header</div><div class="adib-chat-messages" style="height:500px"><article class="adib-chat-bubble mine"><div class="adib-chat-body">Salam!</div><time>14:03</time></article></div><form class="adib-chat-compose"><textarea></textarea></form></div></body></html>');
  const root=path.resolve(__dirname,'..');
  for(const file of ['discussions-ui.css','whatsapp-discussions.css'])await page.addStyleTag({content:fs.readFileSync(path.join(root,file),'utf8')});
  for(const width of [360,390,1280])for(const dark of [false,true]){
   await page.setViewportSize({width,height:844});await page.evaluate(d=>document.documentElement.classList.toggle('dark',d),dark);
   const wallpaper=await page.locator('.adib-chat-messages').evaluate(async node=>{
    const style=getComputedStyle(node),url=style.backgroundImage.match(/^url\(["']?(.*?)["']?\)$/)?.[1];
    const image=new Image();image.src=url;await image.decode();
    return{color:style.backgroundColor,size:style.backgroundSize,repeat:style.backgroundRepeat,width:image.naturalWidth,height:image.naturalHeight,url};
   });
   assert.equal(wallpaper.color,dark?'rgb(21, 28, 40)':'rgb(241, 244, 250)');
   assert.equal(wallpaper.size,'170px 170px');assert.equal(wallpaper.repeat,'repeat');
   assert(wallpaper.url.startsWith('data:image/svg+xml;base64,'));
   assert.equal(wallpaper.width,170);assert.equal(wallpaper.height,170);
   for(const selector of ['.adib-chat-conversation-head','.adib-chat-compose']){
    const background=await page.locator(selector).evaluate(n=>getComputedStyle(n).backgroundImage);
    assert(!background.includes('data:image/svg+xml;base64,'),'wallpaper leaked outside message area');
   }
  }
  console.log('PASS: technical wallpaper, light/dark, mobile/desktop, decoded SVG, chat-only scope');
 }finally{await browser.close()}
})().catch(error=>{console.error(error);process.exitCode=1});
