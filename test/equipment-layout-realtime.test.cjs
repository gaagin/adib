'use strict';

const test=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const path=require('node:path');
const server=fs.readFileSync(path.join(__dirname,'..','server.js'),'utf8');
const runtime=fs.readFileSync(path.join(__dirname,'..','realtime-runtime.js'),'utf8');
const html=fs.readFileSync(path.join(__dirname,'..','ela-nov-paketleme-dynamic.html'),'utf8');

test('saving an equipment layout invalidates and broadcasts the shared equipment snapshot',()=>{
 const start=server.indexOf('async function saveLayout(body)');
 const end=server.indexOf('\n}',start);
 assert.notEqual(start,-1);
 const save=server.slice(start,end);
 assert.ok(save.indexOf('updateLayoutCaches(id, values)')<save.indexOf("realtime.invalidate(['equipment'])"));
});

test('layout coordinates are written to the durable Railway snapshot cache',()=>{
 const start=server.indexOf('function updateLayoutCaches(id, values)');
 const end=server.indexOf('\n}',start);
 assert.notEqual(start,-1);
 const update=server.slice(start,end);
 assert.ok(update.includes('saveRawSnapshotCache()'));
});


test('layout save requires Notion to return the exact persisted coordinates before caching success',()=>{
 const start=server.indexOf('async function saveLayout(body)');
 const end=server.indexOf('\n}',start);
 assert.notEqual(start,-1);
 const save=server.slice(start,end);
 assert.ok(save.includes('const writtenPage = await notion('));
 assert.ok(save.includes("savedProperties['Uzunluğu']?.number"));
 assert.ok(save.includes('NOTION_LAYOUT_SAVE_UNCONFIRMED'));
 assert.ok(save.indexOf('if (mismatches.length)')<save.indexOf('updateLayoutCaches(id, values)'));
 assert.ok(save.includes('confirmedFromNotion: confirmed'));
});

test('layout saves do not silently return on file URLs or non-HTTP origins',()=>{
 const start=runtime.indexOf('async function writeRemotePosition(a,position)');
 const end=runtime.indexOf('\nfunction updateSyncUi',start);
 assert.notEqual(start,-1);
 const save=runtime.slice(start,end);
 assert.ok(!save.includes("if(location.protocol==='file:')return"));
 assert.ok(save.includes("!['http:','https:'].includes(base.protocol)"));
});

test('plan snapshot ETag changes when a device receives new equipment coordinates',()=>{
 assert.match(server,/const layoutRevision=crypto\.createHash\('sha1'\)/);
 assert.match(server,/item\.id,item\.x,item\.y,item\.width,item\.height,item\.parentId,item\.planId,item\.color/);
 assert.ok(server.includes("taskManagement.snapshot().revision+':'+layoutRevision"));
});

test('mobile canvas lets the explicitly selected equipment receive a move gesture',()=>{
 assert.ok(html.includes('window.__adibGetActiveMoveTarget=()=>adibActiveMoveTarget;'));
 const start=runtime.indexOf("svg.addEventListener('pointerdown',e=>{\n  if(window.ADIBDesktop||e.pointerType!=='touch')return;");
 const end=runtime.indexOf('},true);',start);
 assert.ok(start>=0&&end>start,'mobile touch capture handler should exist');
 const handler=runtime.slice(start,end);
 assert.ok(handler.indexOf("const object=e.target.closest?.('.machine,.plan-box');")<handler.indexOf('activePointers.set('));
 assert.match(handler,/if\(object&&moveTarget&&\['equipment','plan'\]\.includes\(moveTarget\.kind\)&&String\(object\.dataset\.id\)===String\(moveTarget\.id\)\)return;/);
});

test('a successful position save clears its pending override and asks for canonical coordinates',()=>{
 const start=runtime.indexOf('async function writeRemotePosition(a,position)');
 const end=runtime.indexOf('\nfunction updateSyncUi',start);
 assert.notEqual(start,-1);
 const save=runtime.slice(start,end);
 assert.ok(save.includes('pendingLayouts.delete(a.id)'));
 assert.ok(save.includes("request('equipment')"));
 assert.ok(save.includes('__refreshEquipmentData?.(false,true)'));
});

test('mobile app revalidates equipment coordinates when it returns to foreground',()=>{
 assert.ok(runtime.includes("document.addEventListener('visibilitychange',()=>{if(shouldAutoSync())refresh(true)})"));
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

test('opening container properties switches mobile canvas to the inspector panel',()=>{
 const start=html.indexOf('async function adibContextRun(action,target){');
 const end=html.indexOf("\ndocument.addEventListener('contextmenu'",start);
 assert.ok(start>=0&&end>start,'canvas context menu handler should exist');
 const handler=html.slice(start,end);
 assert.match(handler,/if\(action==='open-properties'\)\{select\(target\.id,target\.kind\);if\(window\.matchMedia\('\(max-width:650px\)'\)\.matches\)setMobileMode\('inspector'\);return\}/);
 assert.match(runtime,/function setMobileMode\(mode\)/);
});

test('equipment layout accepts its Notion Plan relation ID while validating numeric coordinates',()=>{
 const start=server.indexOf('async function saveLayout(body)');
 const end=server.indexOf('\n}',start);
 assert.ok(start>=0&&end>start,'saveLayout should exist');
 const save=server.slice(start,end);
 assert.match(save,/\['x', 'y', 'width', 'height'\]\.some\(key => !Number\.isFinite\(values\[key\]\)\)/);
 assert.doesNotMatch(save,/Object\.values\(values\)\.some\(value => !Number\.isFinite\(value\)\)/);
 const isValid=values=>!['x','y','width','height'].some(key=>!Number.isFinite(values[key]));
 assert.equal(isValid({x:10,y:20,width:200,height:200,planId:'notion-plan-id'}),true);
 assert.equal(isValid({x:Infinity,y:20,width:200,height:200,planId:'notion-plan-id'}),false);
});
