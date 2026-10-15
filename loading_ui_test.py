"""Browser regression tests. Mock APIs only; no real account or timer changes."""
from pathlib import Path
from playwright.sync_api import sync_playwright
import os,re
B=Path(__file__).parent
CSS=(B/'loading-ui.css').read_text()+'\n'+(B/'network-time.css').read_text()
CSS+='\n'+re.search(r'<style id="adib-startup-style">(.*?)</style>',(B/'ela-nov-paketleme-dynamic.html').read_text(),re.S)[1]
ZONE=(B/'zoned-time.js').read_text()
LOAD=(B/'loading-ui.js').read_text()
CLOCK=(B/'network-time.js').read_text()
with sync_playwright() as pw:
 browser=pw.chromium.launch(executable_path=os.environ.get('CHROMIUM_PATH','/usr/local/bin/chromium'),args=['--no-sandbox'])
 def page(width=390):
  c=browser.new_context(viewport={'width':width,'height':844},service_workers='block');p=c.new_page();p.route('https://loading.test/',lambda r:r.fulfill(body='<html><head><style>'+CSS+'</style></head><body><main>Tapşırıqlarım</main></body></html>',content_type='text/html'));p.goto('https://loading.test/');p.add_script_tag(content=LOAD);return c,p
 for width in [320,390,1440]:
  c,p=page(width);errors=[];p.on('pageerror',lambda e:errors.append(str(e)));p.add_script_tag(content=ZONE)
  # Pending response: no technical text or retry button before a real failure.
  p.evaluate("""()=>{window.realFetch=window.fetch;window.fetch=()=>new Promise(r=>window.clockReply=r)}""")
  p.add_script_tag(content=CLOCK);p.evaluate('ADIBClock.attach()');p.wait_for_selector('#adibClockNotice.is-syncing')
  assert p.locator('#adibClockNotice').inner_text()=='Vaxt sinxronlaşdırılır…'
  assert p.locator('#adibTimeWait').count()==0
  assert 'Kompüter' not in p.locator('#adibClockNotice').inner_text()
  assert p.evaluate('document.documentElement.scrollWidth<=innerWidth')
  p.evaluate("clockReply(new Response(JSON.stringify({trusted:true,now:1792051200000,timeZone:'Asia/Baku'}),{status:200}))")
  p.wait_for_selector('#adibClockNotice[hidden]',state='attached');assert p.evaluate('ADIBClock.trusted')
  assert p.locator('#adibClockNotice').is_hidden()
  # No request interception, no duplicated fetch and correct overlapping operations.
  p.evaluate('window.fetch=window.realFetch;window.a=ADIBLoading.begin();window.b=ADIBLoading.begin("save");void 0')
  p.wait_for_function("document.querySelector('#adibLoadingStatus [data-loading-label]').textContent==='Yadda saxlanılır…'");assert p.locator('#adibLoadingStatus').inner_text()=='Yadda saxlanılır…'
  p.evaluate('window.b()');assert p.evaluate('ADIBLoading.pending')==1
  assert p.locator('#adibLoadingStatus').inner_text()=='Sinxronizasiya edilir…'
  p.evaluate('window.a()');p.wait_for_selector('#adibLoadingStatus[hidden]',state='attached');assert p.evaluate('ADIBLoading.pending')==0
  # Visual authentication screen stays visible while private workspace stays hidden.
  p.evaluate('document.documentElement.style.visibility="hidden";document.documentElement.classList.add("adib-starting");window.authScreen=ADIBLoading.screen()')
  assert p.locator('.adib-loading-screen').is_visible()
  p.evaluate('window.authScreen.fail()');assert p.locator('.adib-loading-screen button').is_visible()
  p.evaluate('window.authScreen.done();document.documentElement.classList.remove("adib-starting");document.documentElement.style.visibility=""')
  assert p.locator('.adib-loading-screen').count()==0
  assert not errors,errors
  print(f'PASS {width}px: non-blocking clock sync, trusted status release, concurrent progress, fail-closed auth screen, no overflow/errors.')
  c.close()
 # Actual failed network gate, then retry/success without changing network-only policy.
 c,p=page();p.add_script_tag(content=ZONE);p.evaluate("window.fetch=async()=>{throw Error('offline')};void 0");p.add_script_tag(content=CLOCK);p.evaluate('ADIBClock.attach()');p.wait_for_function("document.querySelector('#adibClockNotice').textContent.includes('Yenidən cəhd et')")
 assert p.locator('#adibClockNotice').is_visible();assert not p.evaluate('ADIBClock.trusted')
 p.evaluate("window.fetch=()=>new Promise(r=>window.reply=r);void 0");p.locator('#adibClockNotice').click();p.wait_for_selector('#adibClockNotice.is-syncing');assert p.locator('#adibTimeWait').count()==0
 p.evaluate("reply(new Response(JSON.stringify({trusted:true,now:1792051200000,timeZone:'Asia/Baku'}),{status:200}))");p.wait_for_selector('#adibClockNotice[hidden]',state='attached');c.close();print('PASS: offline error and retry; no fallback to device clock.')
 # Real wrapped fetch: pending indicator clears on rejection and aborted requests.
 c,p=page();p.evaluate("""()=>{window.calls=0;window.fetch=()=>{calls++;return new Promise((r,j)=>window.rejectRequest=j)};delete window.ADIBLoading}""");p.add_script_tag(content=LOAD)
 p.evaluate("window.request=fetch('/api/test').catch(()=>null);void 0");p.wait_for_selector('#adibLoadingStatus:not([hidden])');p.evaluate("rejectRequest(new DOMException('Aborted','AbortError'))");p.wait_for_selector('#adibLoadingStatus[hidden]',state='attached');assert p.evaluate('calls')==1;assert p.evaluate('ADIBLoading.pending')==0;c.close();print('PASS: aborted fetch releases progress, exactly one request.')
 browser.close()
