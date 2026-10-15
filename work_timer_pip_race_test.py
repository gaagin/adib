from pathlib import Path
from playwright.sync_api import sync_playwright
import json,time
base=Path(__file__).parent
with sync_playwright() as pw:
 b=pw.chromium.launch(executable_path='/usr/local/bin/chromium',headless=True,args=['--no-sandbox'])
 c=b.new_context(viewport={'width':1200,'height':800})
 p=c.new_page();now=int(time.time()*1000)
 session={'id':'s1','taskId':'t1','actorId':'a1','title':'Test 5','worker':'Huseyn','status':'running','startedAt':now-65000,'revision':1}
 state={'sessions':[session],'own':[session],'tasks':[],'actor':{'id':'a1'},'totals':{},'serverNow':now,'revision':1}
 posts=[]
 def route(r):
  url=r.request.url
  if '/api/work-state' in url:r.fulfill(json=state)
  elif '/api/work-timer' in url:
   body=r.request.post_data_json;posts.append(body)
   session.update(status='running' if body['action']=='start' else 'pending' if body['action']=='stop' else 'saved',endedAt=None if body['action']=='start' else now,revision=session['revision']+1)
   if body['action']=='save':session.update(startedAt=body['startedAt'],endedAt=body['endedAt'])
   state.update(sessions=[session],own=[] if session['status']=='saved' else [session],revision=state['revision']+1)
   r.fulfill(json={'session':session,'serverNow':now,'revision':state['revision']})
  elif url.endswith('/work-timer-ui.css'):r.fulfill(content_type='text/css',body=(base/'work-timer-ui.css').read_text())
  else:r.fulfill(content_type='text/html',body='<html><head><link rel="stylesheet" href="/work-timer-ui.css"></head><body><button id="open" onclick="ADIBWork.openWindow()">Open</button></body></html>')
 c.route('https://adib.test/**',route);p.goto('https://adib.test/')
 p.evaluate('''()=>{window.ADIBLocalTimer={allowed:()=>true,recover:()=>{},remember:()=>{},claim:()=>{}};window.ADIBZone={parse:v=>new Date(v)};window.documentPictureInPicture={requestWindow:()=>{window.pipCalls=(window.pipCalls||0)+1;return Promise.resolve(window.open('about:blank','test-pip','popup,width=360,height=230'))}};}''')
 p.add_script_tag(content=(base/'work-timer-ui.js').read_text());p.evaluate('()=>ADIBWork.refresh()')
 p.wait_for_selector('.adib-work-floating');assert p.locator('.work-float-pip').count()==1
 with p.expect_popup() as info:p.click('#open')
 pip=info.value;pip.wait_for_selector('.adib-work-floating.work-mini');assert p.locator('.adib-work-floating').count()==0
 pip.locator('.work-float-clock-row').click();pip.wait_for_selector('.adib-work-floating:not(.work-mini)');assert pip.locator('.work-float-stop').inner_text()=='■ Dayandır'
 pip.locator('.work-float-stop').click();pip.wait_for_selector('.work-float-confirm');assert len(posts)==1 and posts[0]['action']=='stop';assert pip.locator('input[type=datetime-local]').count()==2;assert 'Sonra təsdiqlə' not in pip.locator('body').inner_text()
 original=pip.locator('input').first.input_value();pip.locator('input').first.fill('2026-01-01T09:30');assert len(posts)==1
 # Closing PiP preserves pending draft and returns the same editor to the page.
 pip.close();p.wait_for_selector('.work-float-confirm');assert p.locator('input').first.input_value()=='2026-01-01T09:30'
 p.get_by_role('button',name='Vaxtı yadda saxla',exact=True).click();p.wait_for_function('()=>ADIBWork.state.own.length===0');assert posts[-1]['action']=='save';assert posts[-1]['startedAt']!=session['startedAt'] or original!='2026-01-01T09:30'
 print('PASS: PiP adoption, compact/expand, stop, editable confirmation, no implicit save, close/draft preservation, explicit save.')
 # Blocked popup: existing timer and node remain available.
 session.update(status='running');state.update(own=[session],sessions=[session]);p.evaluate('()=>ADIBWork.refresh()');p.wait_for_selector('.adib-work-floating')
 p.evaluate('()=>{window.documentPictureInPicture.requestWindow=()=>Promise.reject(Error("blocked"))}');p.click('#open');p.wait_for_selector('.work-pip-error');assert p.locator('.adib-work-floating').count()==1
 print('PASS: rejected PiP keeps working inline timer.')
 # Mobile does not attempt desktop PiP.
 p.set_viewport_size({'width':390,'height':800});before=p.evaluate('()=>window.pipCalls');p.click('#open');assert p.evaluate('()=>window.pipCalls')==before
 print('PASS: mobile unaffected.')
 p.set_viewport_size({'width':1200,'height':800});session.update(status='saved');state.update(own=[],sessions=[session]);p.evaluate('()=>ADIBWork.refresh()')
 p.evaluate('''()=>{delete window.documentPictureInPicture;const fetchOriginal=window.fetch;window.fetch=async(url,opts)=>{if(String(url).includes('/api/work-timer')&&JSON.parse(opts.body).action==='start')await new Promise(r=>setTimeout(r,1800));return fetchOriginal(url,opts)};window.raceTick=setInterval(()=>ADIBWork.refresh(),100);}''')
 p.evaluate("()=>ADIBWork.start({id:'t1',title:'Test 5',sourceKey:'todo',tapsirildi:['Huseyn']})")
 with c.expect_page() as info:p.get_by_role('button',name='İşə başla',exact=True).click()
 auto=info.value;p.wait_for_timeout(2500);assert not auto.is_closed(), 'PiP closed while slow start was still pending';p.evaluate('()=>clearInterval(window.raceTick)');auto.wait_for_selector('.adib-work-floating.work-mini');assert posts[-1]['action']=='start'
 print('PASS: REAL Document PiP survives delayed start and 100ms empty-state refresh race.')
 auto.close()
 b.close()
