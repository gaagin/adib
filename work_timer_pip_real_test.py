from playwright.sync_api import sync_playwright
from pathlib import Path
with sync_playwright() as pw:
 b=pw.chromium.launch(executable_path='/usr/local/bin/chromium',headless=True,args=['--no-sandbox'])
 c=b.new_context(viewport={'width':1200,'height':800});p=c.new_page()
 c.route('https://pip.test/**',lambda r:r.fulfill(content_type='text/html',body='<button id="go" onclick="ADIBWork.openWindow()">Open</button>'))
 p.goto('https://pip.test/');p.add_script_tag(content=(Path(__file__).parent/'work-timer-ui.js').read_text())
 print('Native document PiP API available:',p.evaluate('()=>!!window.documentPictureInPicture?.requestWindow'))
 p.click('#go');p.wait_for_timeout(800)
 print('Real PiP window opened:',p.evaluate('()=>!!window.documentPictureInPicture?.window'))
 if p.evaluate('()=>!!window.documentPictureInPicture?.window'):
  assert p.evaluate("()=>window.documentPictureInPicture.window.document.documentElement.lang==='az'")
  print('PASS: real Chromium Document Picture-in-Picture, not a popup mock.')
 b.close()
