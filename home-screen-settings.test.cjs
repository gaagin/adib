const {test}=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const source=fs.readFileSync(__dirname+'/home-screen.js','utf8');

test('mobile settings portal measures after unhide and stays inside the viewport',()=>{
 const start=source.indexOf('const openSettings=event=>');
 const end=source.indexOf('const sideBottom=',start);
 const handler=source.slice(start,end);
 assert.ok(start>=0&&end>start);
 assert.match(handler,/event\.preventDefault\(\);event\.stopImmediatePropagation\(\)/);
 assert.ok(handler.indexOf('panel.hidden=false')<handler.indexOf('const height=Math.min(panel.scrollHeight||panel.getBoundingClientRect().height'));
 assert.match(handler,/if\(top\+height>viewHeight-12\)top=Math\.max\(12,rect\.top-height-8\)/);
 assert.match(handler,/top=Math\.max\(12,Math\.min\(viewHeight-height-12,top\)\)/);
 assert.match(fs.readFileSync(__dirname+'/ela-nov-paketleme-dynamic.html','utf8'),/home-screen\.js\?v=[^" ]*android-settings-tap-v1/);
});
