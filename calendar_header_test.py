from pathlib import Path
from playwright.sync_api import sync_playwright
base=Path(__file__).parent
with sync_playwright() as pw:
 b=pw.chromium.launch(executable_path='/usr/local/bin/chromium',headless=True,args=['--no-sandbox'])
 for width,height,native in [(390,844,False),(320,720,False),(1440,1000,False),(1440,1000,True)]:
  c=b.new_context(viewport={'width':width,'height':height},timezone_id='America/Los_Angeles');p=c.new_page();errors=[];p.on('pageerror',lambda e:errors.append(str(e)))
  p.route('https://adib.test/**',lambda r:r.fulfill(content_type='text/html',body='<html><body></body></html>'));p.goto('https://adib.test/')
  p.add_style_tag(content=':root{--surface:#fff;--soft:#f3f4fa;--text:#253047;--muted:#858994;--line:#e4e7f0;--blue:#4b6bfa;--blue-soft:#d1dbff;--adib-side-width:0px}body{margin:0;font:14px Arial}button,select,input{font:inherit}button{cursor:pointer}')
  for n in ['ui-system.css','elegant-ui.css','calendar-view.css','workspace-headers.css','focused-views.css','compact-design.css']:p.add_style_tag(content=(base/n).read_text())
  p.add_script_tag(content=(base/'zoned-time.js').read_text())
  p.evaluate('''()=>{window.ADIBClock={trusted:true,timeZone:'Asia/Baku',date:()=>ADIBZone.parse('2026-10-15T14:33:00','Asia/Baku'),details:()=>{},refresh:async()=>{}};window.ADIBFilters={read:(_,v)=>({...v,view:'day'}),write:()=>{}};const tasks=[{id:'one',title:'Avadanlığı yoxlamaq',date:'2026-10-16T09:00',dateEnd:'2026-10-16T09:30',sourceKey:'personal',status:'Not started'},{id:'two',title:'Rapor yazmaq',date:'2026-10-14',sourceKey:'personal'},{id:'span',title:'Gecə işi',date:'2026-10-17T23:00',dateEnd:'2026-10-18T01:00',sourceKey:'personal'},{id:'undated',title:'Tarixsiz',sourceKey:'personal'}];window.ADIBHomeBridge={snapshot:()=>({tasks,containers:[{id:'c',name:'Tasks'}]}),calendarCapabilities:async()=>({dateRange:true}),refresh:async()=>{},newTask:()=>{},openTask:()=>{},patch:async()=>{},closeViews:()=>{}};window.ADIBHome={leave:f=>f(),canLeave:()=>true,open:()=>{}};window.ADIBTaskHistory={visible:()=>true,done:t=>!!t.completed};}''')
  if native:p.evaluate('()=>window.ADIBDesktop={}')
  for n in ['calendar-time.js','calendar-filter.js','calendar-view.js','workspace-headers.js','focused-views.js','compact-design.js']:p.add_script_tag(content=(base/n).read_text())
  p.evaluate('()=>ADIBCalendar.open()');p.wait_for_selector('.calendar-header-week');p.wait_for_timeout(300)
  assert p.locator('.adib-calendar-heading h2').inner_text()=='oktyabr'
  assert p.locator('.calendar-month-button').bounding_box()['x']<24
  assert p.locator('.calendar-header-day').count()==7
  assert p.locator('.adib-calendar-bar button:visible').count()==3
  assert p.locator('.adib-calendar-heading h1').count()==0
  assert p.locator('[data-calendar-header-date="2026-10-15"]').get_attribute('aria-current')=='date'
  for key in ['2026-10-14','2026-10-16','2026-10-17','2026-10-18']:assert p.locator(f'[data-calendar-header-date="{key}"] .calendar-header-dot').get_attribute('hidden') is None
  rects=p.locator('.calendar-header-day').evaluate_all('(els)=>els.map(e=>e.getBoundingClientRect().width)');assert max(rects)-min(rects)<1
  p.locator('[data-calendar-header-date="2026-10-16"]').click();assert p.locator('.calendar-time-day').get_attribute('data-calendar-time-day')=='2026-10-16'
  assert 'is-selected' in p.locator('[data-calendar-header-date="2026-10-16"]').get_attribute('class')
  assert p.locator('.calendar-time-event').count()==1
  p.locator('.calendar-header-week').evaluate('''el=>{const touch=(x,y)=>new Touch({identifier:1,target:el,clientX:x,clientY:y});el.dispatchEvent(new TouchEvent('touchstart',{touches:[touch(240,100)],bubbles:true}));el.dispatchEvent(new TouchEvent('touchend',{changedTouches:[touch(80,100)],bubbles:true}));}''')
  assert p.locator('.calendar-time-day').get_attribute('data-calendar-time-day')=='2026-10-23'
  p.locator('.calendar-month-button').click();p.locator('.calendar-header-picker select').select_option('10');p.locator('.calendar-header-picker input').fill('2027');p.get_by_role('button',name='Göstər',exact=True).click();assert p.locator('.adib-calendar-heading h2').inner_text()=='noyabr'
  for label,mode in [('Ay','month'),('Həftə','week'),('Gün','day')]:
   p.locator('.calendar-header-view').click();p.locator('.calendar-header-picker').get_by_role('button',name=label,exact=True).click();assert p.locator('#adibCalendar').get_attribute('data-calendar-view')==mode
  p.locator('.adib-section-tick-trigger').click();p.get_by_role('menuitemcheckbox',name='Tarixsiz tapşırıqları göstər',exact=True).click();assert p.locator('.adib-calendar-undated').get_attribute('aria-hidden')=='false'
  p.locator('.adib-undated-close').click();p.locator('.adib-section-tick-trigger').click();p.get_by_role('menuitem',name='Bu günə qayıt',exact=True).click();assert p.locator('.calendar-time-day').get_attribute('data-calendar-time-day')=='2026-10-15'
  # Preserve native menu commands/filters.
  p.locator('.adib-section-tick-trigger').click();p.get_by_role('menuitem',name='Görünüş parametrləri və filtrlər',exact=True).click();p.wait_for_selector('.calendar-filter-dialog[open]');p.get_by_role('button',name='Ləğv et',exact=True).click()
  p.wait_for_timeout(150);assert not errors,errors
  assert p.evaluate('()=>document.documentElement.scrollWidth<=innerWidth')
  if width==390:
   p.locator('[data-calendar-header-date="2026-10-16"]').click();p.screenshot(path=str(base/'implemented-header.png'))
  print(f'PASS {width}px native={native}: month, week, dots, today, selection, swipe, month/year, modes, menu, drawer, filters, no overflow/errors.')
  c.close()
 b.close()
