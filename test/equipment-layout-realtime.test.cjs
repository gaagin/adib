'use strict';

const test=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const path=require('node:path');
const server=fs.readFileSync(path.join(__dirname,'..','server.js'),'utf8');

test('saving an equipment layout invalidates and broadcasts the shared equipment snapshot',()=>{
 const start=server.indexOf('async function saveLayout(body)');
 const end=server.indexOf('\n}',start);
 assert.notEqual(start,-1);
 const save=server.slice(start,end);
 assert.ok(save.indexOf('updateLayoutCaches(id, values)')<save.indexOf("realtime.invalidate(['equipment'])"));
});

test('plan snapshot ETag changes when a device receives new equipment coordinates',()=>{
 assert.match(server,/const layoutRevision=crypto\.createHash\('sha1'\)/);
 assert.match(server,/item\.id,item\.x,item\.y,item\.width,item\.height,item\.parentId,item\.planId/);
 assert.ok(server.includes("taskManagement.snapshot().revision+':'+layoutRevision"));
});