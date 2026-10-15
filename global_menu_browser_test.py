"""Full workspace startup using cached tasks and deliberately blocked network reads."""
from pathlib import Path
from urllib.parse import urlparse
from playwright.sync_api import sync_playwright
import json,os,subprocess
B=Path(__file__).parent
rendered=subprocess.check_output(['node','-e',r"const fs=require('fs'),{UiAssets}=require('./ui-assets');const names=JSON.parse(fs.readFileSync('server.js','utf8').match(/const publicAssets=new Set\((\[.*?\])\);/)[1]);process.stdout.write(new UiAssets(process.cwd(),names).renderHtml('ela-nov-paketleme-dynamic.html'));"],cwd=B,text=True)
snapshot={'tasks':[{'id':'cached-t1','title':'Saxlanmış tapşırıq','sourceKey':'personal','completed':False,'status':'Not started','assignees':[]}],'containers':[],'positions':{},'connections':[],'pomodoroTasks':[],'pomodoroData':{'stats':{},'timers':{}}}
with sync_playwright() as pw:
 b=pw.chromium.launch(executable_path=os.environ.get('CHROMIUM_PATH','/usr/local/bin/chromium'),args=['--no-sandbox'])
 for width in [320,390,1440]:
  c=b.new_context(viewport={'width':width,'height':844},service_workers='block');p=c.new_page();errors=[];p.on('pageerror',lambda e:errors.append(str(e)))
  c.add_init_script('''(()=>{localStorage.setItem('adib-account-owner','a:1');localStorage.setItem('ela-personal-snapshot-v1',%s);localStorage.setItem('ela-plan-snapshot-v1',JSON.stringify({plans:[],equipment:[],pomodoroTasks:[]}));const original=window.fetch.bind(window);window.fetch=(input,opts)=>{const u=new URL(typeof input==='string'?input:input.url,location.href);if(u.pathname==='/api/auth/me')return new Promise(r=>window.releaseAuth=()=>r(new Response(JSON.stringify({enabled:true,user:{id:'a',revision:1,name:'Huseyn',role:'admin'}}),{status:200})));if(u.pathname==='/api/time')return new Promise(r=>window.releaseTime=()=>r(new Response(JSON.stringify({trusted:true,now:1792051200000,timeZone:'Asia/Baku'}),{status:200})));if(u.pathname==='/api/personal-snapshot'||u.pathname==='/api/plan-snapshot')return new Promise(()=>{});return original(input,opts);};window.EventSource=class{addEventListener(){}close(){}};})();'''%json.dumps(json.dumps(snapshot,ensure_ascii=False)))
  def route(r):
   name=urlparse(r.request.url).path.lstrip('/')
   if not name or name=='ela-nov-paketleme-dynamic.html':r.fulfill(content_type='text/html',body=rendered);return
   if name.startswith('api/'):
    if name=='api/work-state':r.fulfill(status=503,json={'error':'Vaxt sinxronlaşdırılır'});return
    data={'users':[],'sessions':[],'timers':[],'totals':{},'tasks':[],'threads':[],'comments':[],'enabled':False,'plans':[],'containers':[]}
    r.fulfill(json=data);return
   file=B/name
   if file.is_file():r.fulfill(content_type='text/javascript' if name.endswith('.js') else 'text/css' if name.endswith('.css') else 'application/octet-stream',body=file.read_bytes())
   else:r.fulfill(status=404,body='Not found')
  c.route('https://adib.test/**',route);p.goto('https://adib.test/',wait_until='domcontentloaded')
  p.wait_for_selector('.adib-loading-screen');assert p.locator('.adib-loading-screen').is_visible();assert p.evaluate('document.documentElement.style.visibility')=='hidden'
  p.evaluate('()=>window.releaseAuth()');p.wait_for_selector('#adibHome');p.wait_for_function("()=>window.ADIBHomeBridge.snapshot().ready")
  assert p.locator('#adibHome').get_by_text('Saxlanmış tapşırıq',exact=True).is_visible()
  assert not p.evaluate('ADIBClock.trusted');assert p.locator('#adibTimeWait').count()==0;assert p.locator('.adib-loading-screen').count()==0
  assert p.locator('#adibClockNotice').is_visible()
  assert json.loads(p.evaluate("localStorage.getItem('ela-personal-snapshot-v1')"))['tasks'][0]['id']=='cached-t1'
  # A Pomodoro operation may not start against the unconfirmed clock.
  result=p.evaluate("async()=>{try{await ADIBBrowserPomodoro.action('cached-t1','start');return 'started'}catch(e){return e.message}}")
  assert 'vaxt' in result.lower() or 'Vaxt' in result,result
  p.evaluate('()=>window.releaseTime()');p.wait_for_function('()=>ADIBClock.trusted');p.wait_for_selector('#adibClockNotice[hidden]',state='attached')
  def check_menu(selector,label):
   head=p.locator(selector).first;head.wait_for(state='visible')
   menu=head.locator(':scope > .adib-global-menu')
   if width>700:
    menu.wait_for(state='attached');assert menu.count()==1;assert not menu.is_visible(),label
    toggle=p.locator('#adibPersistentSide .adib-side-toggle');toggle.wait_for(state='visible')
    p.evaluate("document.body.classList.add('adib-side-collapsed')");toggle.click();p.wait_for_function("!document.body.classList.contains('adib-side-collapsed')")
    toggle.click();p.wait_for_function("document.body.classList.contains('adib-side-collapsed')")
    print(f'PASS {width}px {label}: duplicate header menu hidden; left sidebar toggle remains available.')
    return
   menu.wait_for(state='visible');assert menu.count()==1
   p.evaluate("document.body.classList.add('adib-side-collapsed')")
   menu.wait_for(state='visible');p.wait_for_function("document.querySelectorAll('.adib-global-menu[aria-expanded=\"false\"]').length>0")
   rect=menu.bounding_box();assert rect['width']>=40 and rect['height']>=44 and rect['x']>=0 and rect['x']+rect['width']<=width+1,(label,rect)
   menu.click();p.wait_for_function("!document.body.classList.contains('adib-side-collapsed')")
   assert menu.get_attribute('aria-controls')=='adibPersistentSide'
   assert p.evaluate("()=>document.elementFromPoint(24,160)?.closest('#adibPersistentSide')!==null"),label
   p.keyboard.press('Escape');p.wait_for_function("document.body.classList.contains('adib-side-collapsed')")
   menu.click();p.wait_for_function("!document.body.classList.contains('adib-side-collapsed')")
   p.locator('.adib-drawer-backdrop').click(position={'x':width-5,'y':300});p.wait_for_function("document.body.classList.contains('adib-side-collapsed')")
   print(f'PASS {width}px {label}: mobile navigation drawer remains available.')
  check_menu('.adib-home-top','tasks')
  p.evaluate('()=>{ADIBHomeBridge.matrix();}')
  check_menu('.personal-eisenhower-head','matrix')
  p.evaluate('()=>{ADIBHomeBridge.closeViews();ADIBCalendar.open();}')
  check_menu('.adib-calendar-bar','calendar')
  p.evaluate('()=>{ADIBHome.leave(()=>ADIBHomeBridge.canvas());}')
  check_menu('#adibWorkspaceHeader','equipment')
  p.evaluate('()=>{openCommentChat();}')
  check_menu('.adib-chat-head','discussions')
  if width<=700:
   p.evaluate("()=>{openCommentChat({id:'cached-t1',title:'Saxlanmış tapşırıq'});}")
   check_menu('.adib-chat-conversation-head','conversation')
  assert not errors,errors
  c.close()
 b.close()
