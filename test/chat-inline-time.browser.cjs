// Run with Playwright installed: node test/chat-inline-time.browser.cjs
const {chromium}=require(process.env.PLAYWRIGHT_MODULE||'playwright');
const fs=require('node:fs'),path=require('node:path'),assert=require('node:assert/strict');
(async()=>{
 const browser=await chromium.launch({headless:true,...(process.env.CHROMIUM_PATH?{executablePath:process.env.CHROMIUM_PATH}:{})});
 try{
  const page=await browser.newPage();
  await page.setContent('<html><head><style>.adib-chat-messages{display:flex;flex-direction:column;width:100%;box-sizing:border-box}</style></head><body class="adib-chat-open adib-discussions-fullscreen"><div id="adibChatOverlay"><div class="adib-chat-messages"></div></div></body></html>');
  const root=path.resolve(__dirname,'..');
  for(const file of ['discussions-ui.css','whatsapp-discussions.css'])await page.addStyleTag({content:fs.readFileSync(path.join(root,file),'utf8')});
  await page.evaluate(()=>{
   const list=document.querySelector('.adib-chat-messages');
   for(const [text,mine] of [['Salam',true],['Qısa cavab',false],['Long message '.repeat(80),true],['Line one\nLine two 🙂',false]]){
    const bubble=document.createElement('article');bubble.className='adib-chat-bubble'+(mine?' mine':'');
    const body=document.createElement('div');body.className='adib-chat-body';body.textContent=text;
    const time=document.createElement('time');time.textContent='14:03';bubble.append(body,time);list.append(bubble);
   }
   const media=document.createElement('article');media.className='adib-chat-bubble';media.innerHTML='<div class="adib-image-thumbs"><img alt="test" width="80" height="50" src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw=="></div><time>13:44</time>';list.append(media);
  });
  for(const width of [360,390,1280])for(const dark of [false,true]){
   await page.setViewportSize({width,height:844});await page.evaluate(d=>document.documentElement.classList.toggle('dark',d),dark);
   const result=await page.locator('.adib-chat-bubble').evaluateAll(nodes=>nodes.map(n=>{
    const b=n.querySelector('.adib-chat-body')?.getBoundingClientRect(),t=n.querySelector('time').getBoundingClientRect();
    return{display:getComputedStyle(n).display,height:n.getBoundingClientRect().height,body:b&&{right:b.right,top:b.top,bottom:b.bottom},time:{x:t.x,top:t.top,bottom:t.bottom}};
   }));
   for(const row of result.slice(0,4)){
    assert.equal(row.display,'grid');assert(row.time.x>=row.body.right+3);assert(row.time.top<row.body.bottom);assert(Math.abs(row.time.bottom-row.body.bottom)<5);
   }
   assert(result[0].height<34);assert.notEqual(result[4].display,'grid','image layout must remain unchanged');
  }
  console.log('PASS: inline times, short/long/multiline text, image layout, mobile/desktop, light/dark');
 }finally{await browser.close()}
})().catch(error=>{console.error(error);process.exitCode=1});
