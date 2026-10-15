from pathlib import Path
from playwright.sync_api import sync_playwright
with sync_playwright() as pw:
 b=pw.chromium.launch(executable_path='/usr/local/bin/chromium',headless=True,args=['--no-sandbox'])
 p=b.new_page()
 p.set_content('<div class="task-card" data-task-id="w" style="height:60px">Equipment</div><div class="task-card" data-task-id="p" style="height:60px">Personal</div>')
 p.evaluate("""()=>{window.ADIBHome={open:()=>Promise.resolve()};window.ADIBHomeBridge={snapshot:()=>({tasks:[{id:'w',sourceKey:'todo',title:'Equipment'},{id:'p',sourceKey:'personal',title:'Personal'}]}),timerInfo:()=>({status:window.testRunning?'running':'idle'}),timerAction:()=>{}};window.ADIBWork={state:{own:[]}};window.testRunning=false;}""")
 p.add_script_tag(content=(Path(__file__).parent/'startup-view.js').read_text())
 p.wait_for_function("()=>document.querySelectorAll('[data-quick-icon=\"start\"]').length===2")
 p.evaluate("""()=>{window.testRunning=true;window.ADIBWork.state.own=[{taskId:'w',status:'running'}];dispatchEvent(new Event('adib-work-data'));}""")
 p.wait_for_function("()=>document.querySelectorAll('[data-quick-icon=\"stop\"]').length===2")
 p.evaluate("""()=>{window.testRunning=false;window.ADIBWork.state.own=[];dispatchEvent(new Event('adib-work-data'));}""")
 p.wait_for_function("()=>document.querySelectorAll('[data-quick-icon=\"start\"]').length===2")
 print('PASS: both card kinds start -> stop -> start, rendered SVG controls.')
 b.close()
