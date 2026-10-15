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
  p.evaluate('()=>ADIBHomeBridge.kanban()');board=p.locator('.personal-kanban-modal').last;board.wait_for(state='visible')
  trigger=board.locator('.personal-kanban-actions > .adib-section-tick-trigger');trigger.wait_for(state='visible')
  assert trigger.count()==1
  assert not board.locator('.personal-kanban-actions > .adib-view-menu').is_visible()
  menu=p.locator('#adibSectionTickMenu')
  def show():
   trigger.click();menu.wait_for(state='visible');assert menu.get_attribute('aria-label')=='Kanban menyusu'
   rect=menu.bounding_box();assert rect['x']>=0 and rect['x']+rect['width']<=width+1,rect
  show();assert menu.locator('select,input').count()==0
  assert menu.get_by_role('menuitem',name='Yeni tapşırıq',exact=True).is_visible()
  menu.get_by_role('menuitem',name='Görünüş',exact=True).click();menu.get_by_role('menuitem',name='Siyahı',exact=True).click()
  board.locator('.personal-kanban-list-mode').wait_for(state='visible')
  show();menu.get_by_role('menuitem',name='Görünüş',exact=True).click();menu.get_by_role('menuitem',name='Kanban',exact=True).click()
  assert board.locator('.personal-kanban-list-mode').count()==0
  show();menu.get_by_role('menuitem',name='Qruplaşdırma və sıralama',exact=True).click();menu.get_by_role('menuitem',name='Qruplaşdırma',exact=True).click();menu.get_by_role('menuitem',name='Kateqoriya',exact=True).click()
  assert board.locator('#personalKanbanGroupBy').input_value()=='category'
  show();menu.get_by_role('menuitem',name='Qruplaşdırma və sıralama',exact=True).click();menu.get_by_role('menuitem',name='Sıralama',exact=True).click()
  option=board.locator('#personalKanbanSortBy option').nth(1);label=option.text_content();value=option.get_attribute('value');menu.get_by_role('menuitem',name=label,exact=True).click();assert board.locator('#personalKanbanSortBy').input_value()==value
  show();menu.get_by_role('menuitem',name='Qruplaşdırma və sıralama',exact=True).click();menu.get_by_role('menuitem',name='Sıralama istiqamətini dəyiş',exact=True).click();assert p.evaluate("localStorage.getItem('adib-task-sort-desc')")=='true'
  show();menu.get_by_role('menuitem',name='Axtarış',exact=True).click();dialog=p.locator('.adib-tick-search-dialog');dialog.wait_for(state='visible');dialog.get_by_role('searchbox').fill('Saxlanmış');dialog.get_by_role('button',name='Tətbiq et',exact=True).click();assert board.locator('#personalKanbanSearch').input_value()=='Saxlanmış'
  show();menu.get_by_role('menuitem',name='Filtrlər və görünüş parametrləri',exact=True).click();filters=p.locator('[data-filter-view]');filters.wait_for(state='visible');filters.get_by_role('button',name='Ləğv et',exact=True).click()
  show();menu.get_by_role('menuitemcheckbox',name='Detalları gizlət',exact=True).click();assert 'adib-kanban-hide-details' in board.get_attribute('class')
  show();p.keyboard.press('Escape');menu.wait_for(state='hidden');assert board.is_visible()
  show();p.locator('.personal-kanban-board').click(position={'x':8,'y':70});menu.wait_for(state='hidden');assert board.is_visible()
  assert not errors,errors
  print(f'PASS {width}px: one standard Kanban menu, compact geometry, list/board switching, real grouping/sort/direction/search/filter handlers, details, Escape and outside close.')
  c.close()
 b.close()
