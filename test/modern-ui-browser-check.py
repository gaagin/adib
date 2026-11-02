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
  for dark in (False, True):
   p.evaluate('(v)=>setTheme(v)',dark)
   p.evaluate('()=>{ADIBHomeBridge.closeViews();ADIBCalendar.open();}')
   date=p.locator('#adibCalendar .adib-calendar-cell:not(.outside) .calendar-day-plan-trigger').first
   assert date.is_visible(), f'date invisible at {width}, dark={dark}'
   date.click();p.locator('.calendar-day-plan-layer[role=dialog]').wait_for(state='visible')
   assert p.locator('.calendar-day-plan-layer').is_visible()
   p.keyboard.press('Escape');p.wait_for_timeout(150)
   p.evaluate('()=>{ADIBHome.open();}')
   if width <= 700:
    toggle=p.locator('.adib-home-top .adib-global-menu').first;toggle.click();p.wait_for_function("!document.body.classList.contains('adib-side-collapsed')")
    p.keyboard.press('Escape');p.wait_for_function("document.body.classList.contains('adib-side-collapsed')")
   p.evaluate('()=>{ADIBHome.open();ADIBHomeBridge.closeViews();}')
   p.locator('.adib-home-intro-add').click();assert p.locator('dialog.adib-home-add-menu').is_visible();p.keyboard.press('Escape')
   p.locator('#adibHome [data-home-open="cached-t1"]:visible').first.click()
   p.locator('#taskModal.open').wait_for(state='visible')
   assert p.locator('#taskModal').get_by_text('Saxlanmış tapşırıq').count() or p.locator('#taskModal input').count()
   p.evaluate('()=>{ADIBHomeBridge.closeViews();ADIBHome.open();ADIBHomeBridge.day()}')
   p.locator('.tm-layer').wait_for(state='visible')
   if width > 700:
    assert p.locator('[data-home-nav=day]').evaluate('(e)=>getComputedStyle(e).fontWeight') in ('600','650','700')
   p.evaluate('()=>{ADIBHomeBridge.closeViews();ADIBHome.open();ADIBHomeBridge.kanban()}')
   p.locator('.personal-kanban-modal').wait_for(state='visible')
   p.evaluate('()=>{ADIBHomeBridge.closeViews();ADIBHome.open();ADIBHomeBridge.matrix()}')
   p.locator('.personal-eisenhower-modal').wait_for(state='visible')
   p.evaluate('()=>{ADIBHomeBridge.closeViews();ADIBHome.open();document.querySelector("[data-home-nav=team]").click()}')
   p.locator('.adib-team-view').wait_for(state='visible')
   if width <= 700:
    search=p.locator('.team-search input')
    p.locator('.team-search').click();assert search.evaluate('(e)=>document.activeElement===e'), 'team search not focusable'
    search.fill('test');assert search.input_value()=='test'
   p.evaluate('()=>{document.querySelector(".team-close,.team-back")?.click();ADIBHomeBridge.closeViews();ADIBHome.open()}')
   p.evaluate('()=>{[...document.querySelectorAll("#adibPersistentSide .adib-home-nav")].find(e=>e.textContent.includes("Ayarlar"))?.click()}')
   p.locator('#adibSettingsMenu').wait_for(state='visible')
   p.locator('[data-settings-close]').click()
   p.evaluate('''()=>{window.__applyRealtimeEquipment({plans:[{id:"22222222-2222-4222-8222-000000000002",name:"İstehsalat",parentId:"",tasks:[]}],equipment:[{id:"22222222-2222-4222-8222-000000000001",name:"Konveyer",planId:"22222222-2222-4222-8222-000000000002",tasks:[]}],positions:{},connections:[],sync:{partial:false}});kanbanViewMode="list";openTasks("22222222-2222-4222-8222-000000000001")}''')
   p.locator('#taskModal.open').wait_for(state='visible')
   assert p.get_by_text('Konveyer').count() > 0
   p.evaluate('()=>ADIBHomeBridge.closeViews()')
   assert not errors,errors
  print('PASS task editor, day, kanban, matrix, team search, equipment task list, settings, calendar, drawer, themes:',width);c.close()
 b.close()
