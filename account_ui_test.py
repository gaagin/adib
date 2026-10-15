from pathlib import Path
from playwright.sync_api import sync_playwright
import json
base=Path(__file__).parent
rules={'sections':['personal','calendar','chat'],'actions':['status','comment','timer'],'containers':[],'plans':[],'assignedOnly':True,'assignee':'Huseyn'}
users=[{'id':'admin','name':'ilqar mamedov','login':'ilqar','role':'admin','rules':rules},{'id':'employee','name':'Huseyn','login':'huseyn','role':'employee','rules':rules},{'id':'manager','name':'Araz','login':'araz','role':'manager','disabled':True,'rules':rules}]
def asset(r):
 from urllib.parse import urlparse
 path=urlparse(r.request.url).path
 if path in ['/loading-ui.js','/loading-ui.css','/az-locale.js']:
  r.fulfill(content_type='text/css' if path.endswith('.css') else 'text/javascript',body=(base/path[1:]).read_text());return True
 return False
with sync_playwright() as pw:
 b=pw.chromium.launch(executable_path=__import__('os').environ.get('CHROMIUM_PATH','/usr/local/bin/chromium'),headless=True,args=['--no-sandbox'])
 for width,height in [(390,844),(320,740),(1440,1000)]:
  c=b.new_context(viewport={'width':width,'height':height},service_workers='block');p=c.new_page();errors=[];calls=[];p.on('pageerror',lambda e:errors.append(str(e)))
  def route(r):
   u=r.request.url;method=r.request.method
   if asset(r):return
   if '/api/' not in u:r.fulfill(content_type='text/html',body=(base/'account.html').read_text());return
   body=r.request.post_data_json if method not in ['GET','HEAD'] else None;calls.append((u,method,body))
   if '/api/auth/status' in u:d={'enabled':True,'serverUrl':'https://account.test'}
   elif '/api/auth/me' in u:d={'user':users[0]}
   elif '/api/admin/users' in u:d={'users':users,'invites':[]}
   elif '/api/personal-snapshot' in u:d={'containers':[{'id':'c1','name':'Tasks'}],'tasks':[{'assignees':['Huseyn']}]}
   elif '/api/plan-snapshot' in u:d={'plans':[{'id':'p1','name':'Zavod'}]}
   elif '/api/admin/invites' in u:d={'invite':'test-only-invite'}
   else:d={}
   r.fulfill(json=d)
  c.route('https://account.test/**',route);p.goto('https://account.test/account.html');p.wait_for_selector('#add:not(:disabled)')
  assert p.locator('#who').inner_text()=='ilqar mamedov';assert p.locator('#role').inner_text()=='İdarəçi';assert p.locator('.member-row').count()==3;assert p.locator('#userCount').inner_text()=='3';assert p.locator('#loginForm').is_hidden();assert p.locator('#profile').is_visible();assert p.evaluate('()=>document.documentElement.scrollWidth<=innerWidth')
  p.get_by_role('button',name='Huseyn · icazələri dəyiş',exact=True).click();p.wait_for_selector('#editor[open]');assert p.locator('#userForm input[name=name]').input_value()=='Huseyn';assert p.locator('#userForm input[name=assignee]').input_value()=='Huseyn';p.locator('#userForm').get_by_role('button',name='Saxla',exact=True).click();p.wait_for_selector('#editor:not([open])',state='attached')
  patch=next(x for x in calls if x[1]=='PATCH')[2];assert patch['id']=='employee' and patch['rules']==rules
  p.locator('#add').click();p.locator('#userForm input[name=name]').fill('Yeni əməkdaş');p.locator('#userForm').get_by_role('button',name='Saxla',exact=True).click();p.wait_for_selector('#inviteLink a');assert '#invite=test-only-invite' in p.locator('#inviteLink a').get_attribute('href')
  p.locator('#changePassword').click();p.wait_for_selector('dialog:has(input[name=currentPassword])');p.locator('dialog:has(input[name=currentPassword])').get_by_role('button',name='Ləğv et',exact=True).click()
  assert not errors,errors
  if width==390:p.screenshot(path=str(base/'account-mobile.png'),full_page=True)
  if width==1440:p.screenshot(path=str(base/'account-desktop.png'))
  print(f'PASS {width}px: responsive profile, employee rows, permission edit payload unchanged, invitations, password dialog; no overflow/errors.')
  c.close()
 # Non-admin stays non-admin: no admin requests or visible employee management.
 c=b.new_context(service_workers='block');p=c.new_page();reads=[]
 def employee_route(r):
  u=r.request.url;reads.append(u)
  if asset(r):return
  if '/api/auth/status' in u:r.fulfill(json={'enabled':True})
  elif '/api/auth/me' in u:r.fulfill(json={'user':users[1]})
  else:r.fulfill(content_type='text/html',body=(base/'account.html').read_text())
 c.route('https://account.test/**',employee_route);p.goto('https://account.test/account.html');p.wait_for_selector('#profile:not([hidden])');assert p.locator('#admin').is_hidden();assert not any('/api/admin/' in u for u in reads);print('PASS: employee has no admin UI/API requests.');c.close()
 # Login page remains accessible and retains required password/username controls.
 c=b.new_context(viewport={'width':390,'height':844},service_workers='block');p=c.new_page()
 def login_route(r):
  u=r.request.url
  if asset(r):return
  if '/api/auth/status' in u:r.fulfill(json={'enabled':True})
  elif '/api/auth/me' in u:r.fulfill(status=401,json={'error':'Daxil olun'})
  else:r.fulfill(content_type='text/html',body=(base/'account.html').read_text())
 c.route('https://account.test/**',login_route);p.goto('https://account.test/account.html');p.wait_for_selector('#loginForm');assert p.locator('#profile').is_hidden();assert p.locator('input[name=password]').get_attribute('minlength')=='12';p.locator('#accept').click();assert p.locator('#inviteField').is_visible();assert p.locator('input[name=password]').get_attribute('autocomplete')=='new-password';print('PASS: login and invite-accept forms preserve auth controls.');c.close()
 b.close()
