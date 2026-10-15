"""Full workspace startup using cached tasks and deliberately blocked network reads."""
from pathlib import Path
from urllib.parse import urlparse,parse_qs
from playwright.sync_api import sync_playwright
import json,os,subprocess,io
from PIL import Image
buf=io.BytesIO();Image.new('RGB',(180,140),'#5773ec').save(buf,format='PNG');png=buf.getvalue()
B=Path(__file__).parent
rendered=subprocess.check_output(['node','-e',r"const fs=require('fs'),{UiAssets}=require('./ui-assets');const names=JSON.parse(fs.readFileSync('server.js','utf8').match(/const publicAssets=new Set\((\[.*?\])\);/)[1]);process.stdout.write(new UiAssets(process.cwd(),names).renderHtml('ela-nov-paketleme-dynamic.html'));"],cwd=B,text=True)
snapshot={'tasks':[{'id':'cached-t1','title':'Saxlanmış tapşırıq','sourceKey':'personal','completed':False,'status':'Not started','assignees':[]}],'containers':[],'positions':{},'connections':[],'pomodoroTasks':[],'pomodoroData':{'stats':{},'timers':{}}}
with sync_playwright() as pw:
 b=pw.chromium.launch(executable_path=os.environ.get('CHROMIUM_PATH','/usr/local/bin/chromium'),args=['--no-sandbox'])
 for width in [320,390,1440]:
  c=b.new_context(viewport={'width':width,'height':844},service_workers='block');p=c.new_page();errors=[];p.on('pageerror',lambda e:errors.append(str(e)));creates=[];messages=[];fail_comment=[False]
  c.add_init_script('''(()=>{localStorage.setItem('adib-account-owner','a:1');localStorage.setItem('ela-personal-snapshot-v1',%s);localStorage.setItem('ela-plan-snapshot-v1',JSON.stringify({plans:[],equipment:[],pomodoroTasks:[]}));const original=window.fetch.bind(window);window.fetch=(input,opts)=>{const u=new URL(typeof input==='string'?input:input.url,location.href);if(u.pathname==='/api/auth/me')return new Promise(r=>window.releaseAuth=()=>r(new Response(JSON.stringify({enabled:true,user:{id:'a',revision:1,name:'Huseyn',role:'admin'}}),{status:200})));if(u.pathname==='/api/time')return new Promise(r=>window.releaseTime=()=>r(new Response(JSON.stringify({trusted:true,now:1792051200000,timeZone:'Asia/Baku'}),{status:200})));if(u.pathname==='/api/personal-snapshot')return new Promise(()=>{});if(u.pathname==='/api/plan-snapshot')return Promise.resolve(new Response(JSON.stringify({plans:[{id:'plan-1',name:'İstehsalat'}],equipment:[{id:'machine-1',name:'Nasos',planId:'plan-1'}]}),{status:200}));return original(input,opts);};window.EventSource=class{addEventListener(){}close(){}};})();'''%json.dumps(json.dumps(snapshot,ensure_ascii=False)))
  def route(r):
   name=urlparse(r.request.url).path.lstrip('/')
   if not name or name=='ela-nov-paketleme-dynamic.html':r.fulfill(content_type='text/html',body=rendered);return
   if name=='test-photo.png':r.fulfill(content_type='image/png',headers={'Access-Control-Allow-Origin':'*'},body=png);return
   if name.startswith('api/'):
    if name in ['api/personal-task','api/task'] and r.request.method=='POST':
     creates.append(dict(r.request.post_data_json,endpoint=name));r.fulfill(json={'id':'created-'+str(len(creates))});return
    if name=='api/task-comments' and r.request.method=='POST':
     messages.append(r.request.post_data_json)
     if fail_comment[0]:fail_comment[0]=False;r.fulfill(status=500,json={'error':'Sınaq xətası'});return
     r.fulfill(json={'comment':{'id':'message-'+str(len(messages))}});return

    if name=='api/task-comments' and r.request.method=='GET':
     ident=parse_qs(urlparse(r.request.url).query).get('id',[''])[0];r.fulfill(json={'comments':[{'id':ident+'-msg','text':'Unikal ehtiyat hissəsi' if ident=='archive-a' else 'Aktiv müzakirə','authorName':'Huseyn','createdAt':'2026-10-15T10:00:00Z','attachments':[{'url':'https://adib.test/test-photo.png','name':'Sınaq fotosu'}]}]});return
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
  # Populate task discussions without writing real messages or tasks.
  p.evaluate("""()=>{const rows=[{taskId:'archive-a',title:'Köhnə nasos',source:'Avadanlıq',comments:[{id:'a-msg',text:'Unikal ehtiyat hissəsi',authorName:'Huseyn',createdAt:new Date().toISOString()}]},{taskId:'archive-b',title:'Cari tapşırıq',source:'Tapşırıqlarım',comments:[{id:'b-msg',text:'Aktiv müzakirə',createdAt:new Date().toISOString()}]}];localStorage.setItem('adib-chat-threads-cache-v1',JSON.stringify(rows));}""")
  # A reload initializes the real chat bridge from the preserved thread cache.
  p.reload(wait_until='domcontentloaded');p.wait_for_function('()=>!!window.releaseAuth');p.evaluate('()=>releaseAuth()');p.wait_for_selector('#adibHome');p.evaluate('()=>releaseTime()');p.wait_for_function('()=>ADIBClock.trusted');p.evaluate('()=>openCommentChat()')
  row=p.locator('[data-chat-thread="archive-a"]');row.wait_for(state='visible');row.click()
  thumb=p.locator('.adib-chat-messages .adib-auto-thumbnail').first;thumb.wait_for(state='visible');thumb.scroll_into_view_if_needed();p.wait_for_function('(img)=>img.complete&&img.naturalWidth>0',arg=thumb.element_handle())
  rect=thumb.bounding_box();assert rect['width']<=114 and rect['height']<=90,rect
  p.locator('.adib-chat-messages [data-adib-show-photo]').first.click();viewer=p.locator('dialog.adib-photo-viewer');viewer.wait_for(state='visible');p.keyboard.press('Escape');viewer.wait_for(state='detached')
  assert p.locator('#adibChatOverlay').is_visible()
  assert p.evaluate('document.documentElement.scrollWidth<=innerWidth')
  assert not errors,errors
  print(f'PASS full workspace {width}px: actual discussion image auto-preview, zoom and Escape preserve chat.')
  c.close()
 b.close()
