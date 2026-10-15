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
  c=b.new_context(viewport={'width':width,'height':844},service_workers='block');p=c.new_page();errors=[];p.on('pageerror',lambda e:errors.append(str(e)));creates=[];messages=[];fail_comment=[False]
  c.add_init_script('''(()=>{localStorage.setItem('adib-account-owner','a:1');localStorage.setItem('ela-personal-snapshot-v1',%s);localStorage.setItem('ela-plan-snapshot-v1',JSON.stringify({plans:[],equipment:[],pomodoroTasks:[]}));const original=window.fetch.bind(window);window.fetch=(input,opts)=>{const u=new URL(typeof input==='string'?input:input.url,location.href);if(u.pathname==='/api/auth/me')return new Promise(r=>window.releaseAuth=()=>r(new Response(JSON.stringify({enabled:true,user:{id:'a',revision:1,name:'Huseyn',role:'admin'}}),{status:200})));if(u.pathname==='/api/time')return new Promise(r=>window.releaseTime=()=>r(new Response(JSON.stringify({trusted:true,now:1792051200000,timeZone:'Asia/Baku'}),{status:200})));if(u.pathname==='/api/personal-snapshot')return new Promise(()=>{});if(u.pathname==='/api/plan-snapshot')return Promise.resolve(new Response(JSON.stringify({plans:[{id:'plan-1',name:'İstehsalat'},{id:'plan-2',name:'Anbar'}],equipment:[{id:'machine-1',name:'Nasos',planId:'plan-1'},{id:'machine-2',name:'Ventilyator',planId:'plan-2'}]}),{status:200}));return original(input,opts);};window.EventSource=class{addEventListener(){}close(){}};})();'''%json.dumps(json.dumps(snapshot,ensure_ascii=False)))
  def route(r):
   name=urlparse(r.request.url).path.lstrip('/')
   if not name or name=='ela-nov-paketleme-dynamic.html':r.fulfill(content_type='text/html',body=rendered);return
   if name.startswith('api/'):
    if name in ['api/personal-task','api/task'] and r.request.method=='POST':
     creates.append(dict(r.request.post_data_json,endpoint=name));r.fulfill(json={'id':'created-'+str(len(creates))});return
    if name=='api/task-comments' and r.request.method=='POST':
     messages.append(r.request.post_data_json)
     if fail_comment[0]:fail_comment[0]=False;r.fulfill(status=500,json={'error':'Sınaq xətası'});return
     r.fulfill(json={'comment':{'id':'message-'+str(len(messages))}});return

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
  p.evaluate('()=>{openCommentChat();}')
  fab=p.locator('#adibChatOverlay > [data-discussion-task-add]');fab.wait_for(state='visible');assert fab.count()==1
  assert p.locator('.adib-chat-head [data-discussion-task-add]').count()==0
  rect=fab.bounding_box();assert abs(rect['width']-54)<1 and abs(rect['height']-54)<1 and abs(rect['x']+54-(width-18))<2,rect
  assert rect['y']>500 and rect['y']+54<844-58,rect
  fab.click();dialog=p.locator('.adib-discussion-quick-add');dialog.wait_for(state='visible')
  assert dialog.locator('form').count()==1
  assert dialog.get_by_label('Tapşırığın adı',exact=True).is_visible()
  assert dialog.get_by_label('İlk mesaj',exact=True).is_visible()
  assert dialog.get_by_role('button',name='Yarat və söhbətə keç',exact=True).is_visible()
  assert dialog.evaluate('(d)=>d.scrollWidth<=d.clientWidth')
  # Escape dismisses only creation; it must not close the underlying discussion.
  p.keyboard.press('Escape');dialog.wait_for(state='detached');assert p.locator('#adibChatOverlay').is_visible()
  fab.click();dialog.wait_for(state='visible');dialog.get_by_label('Tapşırığın adı',exact=True).fill('Yeni tapşırıq');dialog.get_by_label('İlk mesaj',exact=True).fill('İlk mesaj mətni')
  # Double submission still performs one task creation and one message write.
  dialog.locator('form').evaluate("form=>{form.dispatchEvent(new Event('submit',{bubbles:true,cancelable:true}));form.dispatchEvent(new Event('submit',{bubbles:true,cancelable:true}));}")
  dialog.wait_for(state='detached');assert len(creates)==1 and len(messages)==1
  assert creates[0]['title']=='Yeni tapşırıq' and messages[0]=={'id':'created-1','text':'İlk mesaj mətni'}
  p.wait_for_selector('#adibChatInput[data-task-id="created-1"]');p.wait_for_timeout(230)
  assert not errors,errors
  # A failed message keeps the existing task ID, and retry does not create another task.
  p.evaluate('()=>{openCommentChat();}');fab.wait_for(state='visible');fab.click();dialog.wait_for(state='visible');dialog.get_by_label('Tapşırığın adı',exact=True).fill('Yenidən yoxlama');dialog.get_by_label('İlk mesaj',exact=True).fill('Saxlanmış qaralama')
  fail_comment[0]=True;dialog.get_by_role('button',name='Yarat və söhbətə keç',exact=True).click()
  p.wait_for_function("document.querySelector('.adib-discussion-create-error').textContent.includes('Sınaq xətası')")
  assert dialog.get_by_label('İlk mesaj',exact=True).input_value()=='Saxlanmış qaralama';assert len(creates)==2
  dialog.get_by_role('button',name='Yarat və söhbətə keç',exact=True).click();dialog.wait_for(state='detached')
  assert len(creates)==2 and len(messages)==3 and messages[-1]['id']=='created-2'
  for source in ['gorulen','todo']:
   p.evaluate('()=>{openCommentChat();}');fab.wait_for(state='visible');fab.click();dialog.wait_for(state='visible')
   dialog.get_by_label('Tapşırıq bölməsi',exact=True).select_option(source)
   machine_search=dialog.get_by_label('Avadanlıq axtarın',exact=True);machine_search.fill('Nasos');assert dialog.get_by_role('option',name='Nasos · İstehsalat',exact=True).is_visible();dialog.get_by_role('option',name='Nasos · İstehsalat',exact=True).click()
   assert dialog.locator('select[aria-label="Avadanlıq"]').input_value()=='machine-1' and dialog.locator('select[aria-label="Plan"]').input_value()=='plan-1'
   dialog.get_by_label('Tapşırığın adı',exact=True).fill('Avadanlıq tapşırığı '+source)
   dialog.get_by_label('İlk mesaj',exact=True).fill('İşin müzakirəsi')
   dialog.get_by_role('button',name='Yarat və söhbətə keç',exact=True).click();dialog.wait_for(state='detached')
   assert creates[-1]['endpoint']=='api/task' and creates[-1]['sourceKey']==source and creates[-1]['planId']=='plan-1' and creates[-1]['machineId']=='machine-1',creates[-1]
   assert messages[-1]['id']=='created-'+str(len(creates))
  p.evaluate('()=>{openCommentChat();}');fab.wait_for(state='visible');fab.click();dialog.wait_for(state='visible')
  dialog.get_by_label('Tapşırıq bölməsi',exact=True).select_option('todo')
  plan_search=dialog.get_by_label('Plan axtarın',exact=True);plan_search.fill('Anbar');dialog.get_by_role('option',name='Anbar',exact=True).click()
  assert dialog.locator('select[aria-label="Avadanlıq"]').input_value()=='' and dialog.locator('select[aria-label="Plan"]').input_value()=='plan-2'
  dialog.get_by_label('Tapşırığın adı',exact=True).fill('Plan üzrə tapşırıq')
  dialog.get_by_label('İlk mesaj',exact=True).fill('Plan-only message')
  dialog.get_by_role('button',name='Yarat və söhbətə keç',exact=True).click();dialog.wait_for(state='detached')
  assert creates[-1]['sourceKey']=='todo' and creates[-1]['planId']=='plan-2' and creates[-1]['machineId']==''
  assert creates[0]['endpoint']=='api/personal-task'
  assert not errors,errors
  print(f'PASS {width}px: direct equipment selection for ToDo/Görülən işlər, auto plan, optional plan-only task, safe comment retry.')
  c.close()
 b.close()
