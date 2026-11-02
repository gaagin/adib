"""Full workspace startup using cached tasks and deliberately blocked network reads."""
from pathlib import Path
from urllib.parse import urlparse
from playwright.sync_api import sync_playwright
import json,os,subprocess
B=Path(__file__).resolve().parent.parent
rendered=subprocess.check_output(['node','-e',r"const fs=require('fs'),{UiAssets}=require('./ui-assets');const names=JSON.parse(fs.readFileSync('server.js','utf8').match(/const publicAssets=new Set\((\[.*?\])\);/)[1]);process.stdout.write(new UiAssets(process.cwd(),names).renderHtml('ela-nov-paketleme-dynamic.html'));"],cwd=B,text=True)
snapshot={'tasks':[{'id':'cached-t1','title':'Saxlanmış tapşırıq','sourceKey':'personal','completed':False,'status':'Not started','assignees':[]}],'containers':[],'positions':{},'connections':[],'pomodoroTasks':[],'pomodoroData':{'stats':{},'timers':{}}}
with sync_playwright() as pw:
 b=pw.chromium.launch(executable_path=os.environ.get('CHROMIUM_PATH','/usr/local/bin/chromium'),args=['--no-sandbox'])
 for width in [320,390,1440]:
  c=b.new_context(viewport={'width':width,'height':844},service_workers='block');p=c.new_page();errors=[];p.on('pageerror',lambda e:errors.append(str(e)))
  c.add_init_script('''(()=>{localStorage.setItem('adib-account-owner','a:1');localStorage.setItem('ela-personal-snapshot-v1',%s);localStorage.setItem('ela-plan-snapshot-v1',JSON.stringify({plans:[],equipment:[],pomodoroTasks:[]}));const original=window.fetch.bind(window);window.fetch=(input,opts)=>{const u=new URL(typeof input==='string'?input:input.url,location.href);if(u.pathname==='/api/auth/me')return Promise.resolve(new Response(JSON.stringify({enabled:true,user:{id:'a',revision:1,name:'Huseyn',role:'admin'}}),{status:200}));if(u.pathname==='/api/time')return Promise.resolve(new Response(JSON.stringify({trusted:true,now:1792051200000,timeZone:'Asia/Baku'}),{status:200}));if(u.pathname==='/api/personal-snapshot'||u.pathname==='/api/plan-snapshot')return new Promise(()=>{});return original(input,opts);};window.EventSource=class{addEventListener(){}close(){}};})();'''%json.dumps(json.dumps(snapshot,ensure_ascii=False)))
  def route(r):
   name=urlparse(r.request.url).path.lstrip('/')
   if not name or name=='ela-nov-paketleme-dynamic.html':r.fulfill(content_type='text/html',body=rendered);return
   if name.startswith('api/'):
    if name=='api/task-management':r.fulfill(json={'version':1,'revision':0,'settings':{'dailyTaskLimit':4,'wipLimit':2,'budgetMinutes':120,'staleDays':14},'days':{},'tasks':{}});return
    if name=='api/work-state':r.fulfill(status=503,json={'error':'Vaxt sinxronlaşdırılır'});return
    data={'users':[],'sessions':[],'timers':[],'totals':{},'tasks':[],'threads':[],'comments':[],'enabled':False,'plans':[],'containers':[]}
    r.fulfill(json=data);return
   file=B/name
   if file.is_file():r.fulfill(content_type='text/javascript' if name.endswith('.js') else 'text/css' if name.endswith('.css') else 'application/octet-stream',body=file.read_bytes())
   else:r.fulfill(status=404,body='Not found')
  c.route('https://adib.test/**',route);p.goto('https://adib.test/',wait_until='domcontentloaded')
  p.wait_for_selector('#adibHome',timeout=20000);p.wait_for_function("()=>window.ADIBHomeBridge.snapshot().ready")
  p.evaluate('()=>{[...document.querySelectorAll("#adibPersistentSide .adib-home-nav")].find(e=>e.textContent.includes("Ayarlar"))?.click()}')
  p.locator('#adibSettingsMenu').wait_for(state='visible')
  select=p.locator('#adibInterfaceAccentSelect'); assert select.count()==1
  assert select.locator('option').count()==6
  for dark in (False,True):
   p.evaluate('(v)=>setTheme(v)',dark)
   for choice in ['teal','blue','green','violet','orange','graphite']:
    select.select_option(choice)
    p.wait_for_timeout(300)
    style=p.evaluate("""()=>({brand:getComputedStyle(document.documentElement).getPropertyValue('--adib-brand').trim(),swatch:getComputedStyle(document.querySelector('.adib-accent-swatch')).backgroundColor,button:getComputedStyle(document.querySelector('.adib-home-intro-add')).backgroundColor,accent:document.documentElement.dataset.adibAccent||'teal',chat:document.documentElement.dataset.adibChatPalette||'default',saved:JSON.parse(localStorage.getItem('adib-user-preferences-v1')).values['adib-interface-accent-v1']})""")
    assert style['accent']==choice and style['saved']==choice,style
    assert style['swatch']==style['button'],style
    assert style['chat']=='default',style
   select.select_option('violet')
   if width in (390,1440) and not dark:p.screenshot(path=f'/data/adib-accent-settings-{width}.png')
  assert p.evaluate('document.documentElement.scrollWidth <= innerWidth'), 'horizontal overflow'
  p.reload(wait_until='domcontentloaded');p.wait_for_selector('#adibHome',timeout=20000);p.wait_for_function("()=>window.ADIBHomeBridge.snapshot().ready");assert p.locator('#adibInterfaceAccentSelect').input_value()=='violet'
  if width==390:
   second=c.new_page();second.goto('https://adib.test/',wait_until='domcontentloaded');second.wait_for_selector('#adibHome',timeout=20000)
   second.wait_for_function('()=>window.ADIBHomeBridge.snapshot().ready')
   second.evaluate('()=>{[...document.querySelectorAll("#adibPersistentSide .adib-home-nav")].find(e=>e.textContent.includes("Ayarlar"))?.click()}')
   second.locator('#adibSettingsMenu').wait_for(state='visible');second.locator('#adibInterfaceAccentSelect').select_option('green')
   p.wait_for_function("document.documentElement.dataset.adibAccent === 'green'")
   assert p.locator('#adibInterfaceAccentSelect').input_value()=='green';second.close()
  assert not errors,errors
  print('PASS six accents, dark/light, saved, chat independent, reload, tabs, narrow layout:',width);c.close()
 b.close()
