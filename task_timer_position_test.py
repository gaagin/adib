from playwright.sync_api import sync_playwright
from pathlib import Path
base=Path(__file__).parent
with sync_playwright() as pw:
 b=pw.chromium.launch(executable_path='/usr/local/bin/chromium',headless=True,args=['--no-sandbox'])
 for width in [390,1440]:
  for personal in [False,True]:
   c=b.new_context(viewport={'width':width,'height':900});p=c.new_page();errors=[];p.on('pageerror',lambda e:errors.append(str(e)))
   p.route('https://adib.test/**',lambda r:r.fulfill(content_type='text/html',body='<body></body>'));p.goto('https://adib.test/')
   p.set_content('<section class="adib-task-properties-panel"><div class="task-list"><div class="task-editor '+('personal-task-editor' if personal else '')+'"><label>Ad<input id="'+('personalEditTitle' if personal else 'taskTitle')+'" value="Test"></label><div class="adib-notion-date-field"><span>Tarix və vaxt</span><button class="date-test">15.10.2026</button><input id="'+('personalEditDate' if personal else 'taskDate')+'" type="date" value="2026-10-15"></div><label>Prioritet<select id="'+('personalEditPrioritet' if personal else 'taskPrioritet')+'"><option>!!</option></select></label><div class="editor-actions"><button id="personalOpenPomodoro">Parametrlər</button><button id="saveTask">Saxla</button></div></div></div></section>')
   p.add_style_tag(content=':root{--blue:#4b6bfa;--surface:white;--text:#253047;--soft:#f5f7ff;--line:#d7e1fb;--muted:#73819a}body{font:14px Arial;margin:0}.adib-task-properties-panel{width:100%;max-width:760px}.task-editor{padding:16px}.task-editor>label{display:block;margin:10px 0}')
   p.add_style_tag(content=(base/'elegant-ui.css').read_text())
   p.evaluate('''()=>{window.task={id:'t1',title:'Test',sourceKey:'personal',tapsirildi:['Huseyn']};window.status='idle';window.calls=[];window.current={remaining:1500,status:'idle',count:0,minutes:0,trusted:true};window.ADIBHomeBridge={timerInfo:()=>({...window.current}),timerAction:async(id,action)=>{calls.push({id,action});window.current.status='running';return true}};window.ADIBBrowserPomodoro={action:async(id,action)=>{calls.push({id,action});window.current.status='idle'}};window.ADIBWork={timeLabel:n=>n+' dəq'};}''')
   for n in ['personal-workspace.js','elegant-ui.js']:p.add_script_tag(content=(base/n).read_text())
   if personal:
    p.evaluate("()=>ADIBElegantUI.bind(document,{task,personal:true,isNew:false})")
   else:
    p.evaluate('''()=>{const node=document.createElement('section');node.className='adib-work-panel';node.innerHTML='<h3>İş taymeri</h3><strong>00:00:00</strong><button id="work-start">İşə başla</button>';node.querySelector('button').onclick=()=>calls.push({id:'t1',action:'start',kind:'work'});document.querySelector('.task-list').append(node);ADIBElegantUI.bind(document);}''')
   p.wait_for_selector('.adib-task-quick-timer')
   assert p.evaluate("()=>document.querySelector('.adib-notion-date-field').nextElementSibling.matches('.adib-task-quick-timer')")
   assert p.locator('.adib-task-quick-timer').count()==1
   assert p.locator('.adib-personal-timer').count()==(1 if personal else 0)
   assert p.locator('.adib-work-panel').count()==(0 if personal else 1)
   # Observer rebinding and late DOM additions must not duplicate/reset a timer.
   p.evaluate("()=>{document.querySelector('.task-editor').append(document.createElement('div'));ADIBElegantUI.bind(document)}")
   assert p.locator('.adib-task-quick-timer').count()==1
   if personal:
    p.locator('.adib-workspace-timer-start').click();assert p.evaluate('()=>calls[0].action')=='start';assert '■ Bitir'==p.locator('.adib-workspace-timer-start').inner_text()
    p.locator('.adib-workspace-timer-start').click();assert p.evaluate('()=>calls[1].action')=='finish'
    # Pending server call stays disabled even during clock refresh.
    p.evaluate("()=>{ADIBHomeBridge.timerAction=()=>new Promise(resolve=>window.releaseTimer=resolve)}")
    p.locator('.adib-workspace-timer-start').click();p.evaluate("()=>ADIBPersonalWorkspace.updateTimer(document.querySelector('.adib-personal-timer'))");assert p.locator('.adib-workspace-timer-start').is_disabled()
    p.evaluate('()=>window.releaseTimer(true)');p.wait_for_function("()=>!document.querySelector('.adib-workspace-timer-start').disabled")
   else:
    p.locator('#work-start').click();assert p.evaluate('()=>calls[0].kind')=='work'
   assert p.locator('.adib-notion-date-field input').input_value()=='2026-10-15';assert not errors,errors
   print(f'PASS {width}px personal={personal}: immediately after date, one correct timer, handlers preserved, start/finish, no duplicate/reset.')
   c.close()
 # Unsaved personal tasks cannot start a timer.
 c=b.new_context();p=c.new_page();p.set_content('<div class="task-editor"><input id="personalEditTitle"><div class="adib-notion-date-field">Tarix və vaxt</div></div>');p.evaluate('()=>window.ADIBHomeBridge={timerInfo:()=>null}');p.add_script_tag(content=(base/'personal-workspace.js').read_text());p.add_script_tag(content=(base/'elegant-ui.js').read_text());p.evaluate("()=>ADIBElegantUI.bind(document,{task:{id:''},personal:true,isNew:true})");assert p.locator('.adib-workspace-timer-start').is_disabled();print('PASS: unsaved task requires creation before starting Pomodoro.');c.close()
 b.close()
