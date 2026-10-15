from pathlib import Path
from urllib.parse import urlparse
from playwright.sync_api import sync_playwright
from PIL import Image
import io,os
B=Path(__file__).parent
buf=io.BytesIO();Image.new('RGB',(200,150),'#5c75ea').save(buf,format='PNG');png=buf.getvalue()
with sync_playwright() as pw:
 b=pw.chromium.launch(executable_path=os.environ.get('CHROMIUM_PATH','/usr/local/bin/chromium'),args=['--no-sandbox'])
 for width in [320,390,1440]:
  c=b.new_context(viewport={'width':width,'height':1000},service_workers='block');p=c.new_page();errors=[];p.on('pageerror',lambda e:errors.append(str(e)));requests=[]
  def route(r):
   u=urlparse(r.request.url)
   if u.hostname=='photos.test':
    requests.append(u.path)
    if u.path=='/broken':r.fulfill(status=404,headers={'Access-Control-Allow-Origin':'*'},body='Not found');return
    r.fulfill(content_type='image/png',headers={} if u.path=='/no-cors' else {'Access-Control-Allow-Origin':'*'},body=png);return
   if u.path=='/images.js':r.fulfill(content_type='text/javascript; charset=utf-8',body=(B/'images.js').read_bytes());return
   r.fulfill(content_type='text/html',body='''<!doctype html><html><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"></head><body style="font-family:Arial;margin:12px"><section id="comments"></section><section id="task"></section><section id="fields"></section><section id="failed"></section><script>window.ADIBAccount={user:{id:'test',revision:1},action:()=>true};window.ADIBAz={label:v=>v};</script><script src="/images.js"></script></body></html>''')
  c.route('https://adib.test/**',route);c.route('https://photos.test/**',route);p.goto('https://adib.test/')
  p.evaluate('''()=>{ADIBImages.setApi(async path=>path.startsWith('/api/task-images')?{images:[{url:'https://photos.test/task',name:'Task photo'}]}:{supported:true,fields:{'Foto evvel':{available:true,version:'a',images:[{url:'https://photos.test/before',name:'Before',index:0}]},'Foto sonra':{available:true,version:'b',images:[{url:'https://photos.test/after',name:'After',index:0}]}}});document.querySelector('#comments').innerHTML=ADIBImages.imageMarkup([{url:'https://photos.test/comment',name:'Photo <safe>'},{url:'https://photos.test/no-cors',name:'No CORS'},{url:'javascript:alert(1)',name:'Bad'}]);ADIBImages.taskPanel(document.querySelector('#task'),'task-id');ADIBImages.photoFields(document.querySelector('#fields'),'task-id');}''')
  p.locator('#fields .adib-auto-thumbnail').first.wait_for()
  for selector in ['#comments .adib-auto-thumbnail','#task .adib-auto-thumbnail','#fields .adib-auto-thumbnail']:
   for img in p.locator(selector).all():
    img.scroll_into_view_if_needed();img.wait_for(state='visible');p.wait_for_function('(img)=>img.complete&&img.naturalWidth>0',arg=img.element_handle())
    rect=img.bounding_box();assert rect['width']<=114 and rect['height']<=90,rect
  assert p.locator('#comments .adib-auto-thumbnail').count()==2
  assert len(requests)>=5,requests
  # No click-to-load step: every visible attachment is already an actual thumbnail.
  assert p.locator('#comments').get_by_role('button',name='Şəkli böyüt 1: Photo <safe>').is_visible()
  trigger=p.locator('#fields [data-adib-show-photo]').first;trigger.click();viewer=p.locator('dialog.adib-photo-viewer');viewer.wait_for(state='visible')
  assert viewer.locator('img').get_attribute('src')=='https://photos.test/before'
  p.keyboard.press('Escape');viewer.wait_for(state='detached');assert p.locator('#fields').is_visible()
  # Redrawing identical comments reuses the bounded, account-scoped memory thumbnail.
  count=requests.count('/comment')
  p.evaluate("()=>document.querySelector('#comments').innerHTML=ADIBImages.imageMarkup([{url:'https://photos.test/comment',name:'Cached'}])")
  img=p.locator('#comments img');img.scroll_into_view_if_needed();p.wait_for_function('(img)=>img.complete&&img.naturalWidth>0',arg=img.element_handle());assert img.get_attribute('src').startswith('data:image/jpeg;');assert requests.count('/comment')==count
  # A different account cannot reuse the previous account's in-memory preview.
  p.evaluate("()=>{ADIBAccount.user={id:'other',revision:1};document.querySelector('#comments').innerHTML=ADIBImages.imageMarkup([{url:'https://photos.test/comment'}])}")
  assert p.locator('#comments img').get_attribute('src').startswith('https://photos.test/')
  p.evaluate("()=>document.querySelector('#failed').innerHTML=ADIBImages.imageMarkup([{url:'https://photos.test/broken'}])")
  p.locator('#failed [data-adib-show-photo]').scroll_into_view_if_needed();p.locator('#failed [data-photo-state]').wait_for(state='visible');assert p.locator('#failed').get_by_text('Foto açılmadı. Yenilə').is_visible()
  assert p.locator('#failed [data-adib-show-photo]').evaluate('(b)=>!b.disabled')
  assert p.evaluate('document.documentElement.scrollWidth<=innerWidth')
  assert not errors,errors
  print(f'PASS {width}px: automatic task/comment/before-after thumbnails, zoom/Escape, CORS fallback, memory cache/account isolation, invalid URL filter and failed-image retry.')
  c.close()
 b.close()
