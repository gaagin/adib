from pathlib import Path
from playwright.sync_api import sync_playwright
import time
base=Path(__file__).parent
with sync_playwright() as pw:
 b=pw.chromium.launch(executable_path='/usr/local/bin/chromium',headless=True,args=['--no-sandbox']);c=b.new_context(viewport={'width':390,'height':844});p=c.new_page();errors=[];p.on('pageerror',lambda e:errors.append(str(e)))
 def handle(r):
  if '/api/work-state' in r.request.url:r.fulfill(json={'serverNow':int(time.time()*1000),'actor':{'id':'a','assignee':'Huseyn'},'sessions':[],'own':[],'tasks':[],'totals':{},'revision':1})
  else:r.fulfill(content_type='text/html',body='<div class="task-list"><div class="task-editor"><input id="taskTitle"><div class="adib-notion-date-field">Tarix və vaxt</div><label>Prioritet<select id="taskPrioritet"><option>!!</option></select></label></div></div>')
 c.route('https://adib.test/**',handle);p.goto('https://adib.test/')
 p.add_script_tag(content=(base/'elegant-ui.js').read_text());p.add_script_tag(content=(base/'work-timer-ui.js').read_text());p.evaluate('()=>ADIBWork.refresh()')
 p.evaluate("()=>ADIBWork.attach(document.querySelector('.task-list'),{id:'e1',title:'Avadanlıq',sourceKey:'todo',tapsirildi:['Huseyn']})")
 assert p.evaluate("()=>document.querySelector('.adib-notion-date-field').nextElementSibling.matches('.adib-work-panel')")
 p.get_by_role('button',name='İşə başla',exact=True).click();p.wait_for_selector('dialog[open]');assert p.locator('dialog select').input_value()=='Huseyn';p.get_by_role('button',name='Ləğv et',exact=True).click();assert not errors,errors
 print('PASS: actual ADIBWork.attach places original panel after date; original Start opens the existing worker/session flow.')
 b.close()
