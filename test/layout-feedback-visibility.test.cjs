'use strict';
const assert=require('node:assert/strict');
const fs=require('node:fs');
const path=require('node:path');
const test=require('node:test');
const root=path.join(__dirname,'..');
const html=fs.readFileSync(path.join(root,'ela-nov-paketleme-dynamic.html'),'utf8');
const runtime=fs.readFileSync(path.join(root,'realtime-runtime.js'),'utf8');
test('mobile equipment canvas exposes pending, successful and failed Notion layout saves',()=>{
 assert.match(html,/layout-sync-feedback-mobile-fix/);
 assert.match(html,/\.layout\.mobile-canvas-mode \.canvas-wrap #syncError:not\(:empty\)\{[\s\S]*?display:block!important/);
 assert.match(html,/layout-write-through-v3-feedback/);
 assert.match(runtime,/dataset\.layoutSyncState='pending'/);
 assert.match(runtime,/dataset\.layoutSyncState='success'/);
 assert.match(runtime,/dataset\.layoutSyncState='error'/);
});
