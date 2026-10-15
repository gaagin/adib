"""Real Chromium HTTP/service-worker cache test, localhost fixture only."""
from pathlib import Path
from playwright.sync_api import sync_playwright
import subprocess,json,os,tempfile
B=Path(__file__).parent
server=r'''
const http=require('http'),fs=require('fs'),path=require('path');const {UiAssets}=require(process.argv[1]+'/ui-assets');const dir=fs.mkdtempSync('/tmp/adib-ui-cache-');
fs.writeFileSync(path.join(dir,'network-time.js'),'window.fixtureVersion=1;');fs.writeFileSync(path.join(dir,'loading-ui.css'),'body{color:rgb(1,2,3)}');fs.writeFileSync(path.join(dir,'index.html'),'<link rel="stylesheet" href="loading-ui.css?v=1"><script src="network-time.js?v=1"></script><main>Test</main><script>navigator.serviceWorker.register("/sw.js")</script>');let ui=new UiAssets(dir,['network-time.js','loading-ui.css']);const counts={};let api=0;
const app=http.createServer((req,res)=>{const u=new URL(req.url,'http://test');counts[u.pathname]=(counts[u.pathname]||0)+1;if(u.pathname==='/sw.js'){res.writeHead(200,{'Content-Type':'application/javascript','Cache-Control':'no-cache'});res.end(fs.readFileSync(process.argv[1]+'/sw.js'));return;}if(u.pathname==='/__counts'){res.end(JSON.stringify(counts));return;}if(u.pathname==='/__update'){fs.writeFileSync(path.join(dir,'network-time.js'),'window.fixtureVersion=2;');ui=new UiAssets(dir,['network-time.js','loading-ui.css']);res.end('ok');return;}if(u.pathname==='/api/private'){res.writeHead(200,{'Cache-Control':'no-store','Content-Type':'application/json'});res.end(JSON.stringify({read:++api}));return;}if(u.pathname==='/'){res.writeHead(200,{'Content-Type':'text/html','Cache-Control':'no-store'});res.end(ui.renderHtml(path.join(dir,'index.html')));return;}if(ui.serve(req,res,u))return;res.writeHead(404);res.end();});app.listen(0,'127.0.0.1',()=>console.log(app.address().port));process.on('SIGTERM',()=>{fs.rmSync(dir,{recursive:true,force:true});app.close(()=>process.exit(0))});
'''
proc=subprocess.Popen(['node','-e',server,str(B)],stdout=subprocess.PIPE,text=True)
try:
 port=int(proc.stdout.readline().strip());url=f'http://127.0.0.1:{port}/'
 with sync_playwright() as pw:
  b=pw.chromium.launch(executable_path=os.environ.get('CHROMIUM_PATH','/usr/local/bin/chromium'),args=['--no-sandbox']);c=b.new_context();p=c.new_page();errors=[];p.on('pageerror',lambda e:errors.append(str(e)))
  p.goto(url);p.evaluate('()=>navigator.serviceWorker.ready');p.wait_for_function('()=>!!navigator.serviceWorker.controller');p.reload();assert p.evaluate('fixtureVersion')==1
  # Ensure SW cache has received the public entries before another navigation.
  p.wait_for_function("async()=>{const keys=await caches.open('adib-online-ui-content-v1').then(c=>c.keys());return keys.length===2}")
  counts=lambda:p.request.get(url+'__counts').json()
  before=counts();p.reload();assert counts()['/network-time.js']==before['/network-time.js'];assert counts()['/loading-ui.css']==before['/loading-ui.css']
  a=p.evaluate("async()=>fetch('/api/private').then(r=>r.json())");d=p.evaluate("async()=>fetch('/api/private').then(r=>r.json())");assert a['read']+1==d['read']
  keys=p.evaluate("async()=>{const c=await caches.open('adib-online-ui-content-v1');return (await c.keys()).map(r=>new URL(r.url).pathname)}");assert set(keys)=={'/network-time.js','/loading-ui.css'}
  before=counts();p.request.get(url+'__update');p.reload();assert p.evaluate('fixtureVersion')==2;assert counts()['/network-time.js']==before['/network-time.js']+1;assert counts()['/loading-ui.css']==before['/loading-ui.css']
  assert not errors,errors
  print('PASS: real service worker/HTTP reuse; only changed JS redownloaded; unchanged CSS reused; HTML and API data never stored.')
  b.close()
finally:
 proc.terminate();proc.wait(timeout=10)
