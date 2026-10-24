'use strict';

const test=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const path=require('node:path');
const server=fs.readFileSync(path.join(__dirname,'..','server.js'),'utf8');
const runtime=fs.readFileSync(path.join(__dirname,'..','realtime-runtime.js'),'utf8');

test('saving an equipment layout invalidates and broadcasts the shared equipment snapshot',()=>{
 const start=server.indexOf('async function saveLayout(body)');
 const end=server.indexOf('\n}',start);
 assert.notEqual(start,-1);
 const save=server.slice(start,end);
 assert.ok(save.indexOf('updateLayoutCaches(id, values)')<save.indexOf("realtime.invalidate(['equipment'])"));
});

test('plan snapshot ETag changes when a device receives new equipment coordinates',()=>{
 assert.match(server,/const layoutRevision=crypto\.createHash\('sha1'\)/);
 assert.match(server,/item\.id,item\.x,item\.y,item\.width,item\.height,item\.parentId,item\.planId,item\.color/);
 assert.ok(server.includes("taskManagement.snapshot().revision+':'+layoutRevision"));
});

test('plan and equipment colors are read from and written to the shared Notion Color property',()=>{
 assert.match(server,/function mapPlans[\s\S]*?color: select\(page, 'Color'\)/);
 assert.match(server,/function mapEquipment[\s\S]*?color: select\(page, 'Color'\)/);
 const start=server.indexOf('async function saveLayoutColor(body)');
 const end=server.indexOf('\n}',start);
 assert.notEqual(start,-1);
 const save=server.slice(start,end);
 assert.ok(save.includes("Color: color ? { select: { name: color } } : { select: null }"));
 assert.ok(save.indexOf('updateLayoutCaches(id, values)')<save.indexOf("realtime.invalidate(['equipment'])"));
 assert.match(server,/async function ensureLayoutColorSchema\(kind\)[\s\S]*?method: 'PATCH'[\s\S]*?properties: \{ Color:/);
});

test('the inspector exposes shared color choices and the canvas renders the selected color',()=>{
 assert.match(runtime,/id="inspectorColor"/);
 assert.match(runtime,/\/api\/layout-color/);
 assert.match(runtime,/CANVAS_COLORS\[o\.color\]/);
});