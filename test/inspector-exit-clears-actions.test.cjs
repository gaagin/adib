'use strict';

const test=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const path=require('node:path');

const runtime=fs.readFileSync(path.join(__dirname,'..','realtime-runtime.js'),'utf8');
const page=fs.readFileSync(path.join(__dirname,'..','ela-nov-paketleme-dynamic.html'),'utf8');

test('returning from mobile properties clears the selected element and its action row',()=>{
 assert.match(runtime,/leavingInspector=mode==='canvas'&&layout\.classList\.contains\('mobile-inspector-mode'\)/);
 assert.match(runtime,/if\(leavingInspector&&state\.selected!==null\)\{state\.selected=null;renderCanvas\(\);renderInspector\(\)\}/);
});

test('closing the desktop inspector also clears the element action row',()=>{
 assert.match(runtime,/if\(collapsed&&state\.selected!==null\)\{state\.selected=null;renderCanvas\(\);renderInspector\(\)\}/);
});

test('Android back returns to canvas before navigating between plans',()=>{
 assert.match(page,/if\(document\.getElementById\('layout'\)\?\.classList\.contains\('mobile-inspector-mode'\)\)\{setMobileMode\('canvas'\);return\}/);
});
