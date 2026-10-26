'use strict';
const assert=require('node:assert/strict');
const fs=require('node:fs');
const path=require('node:path');
const vm=require('node:vm');
const test=require('node:test');
const root=path.join(__dirname,'..');
const runtime=fs.readFileSync(path.join(root,'realtime-runtime.js'),'utf8');
const html=fs.readFileSync(path.join(root,'ela-nov-paketleme-dynamic.html'),'utf8');

test('dragging plans and equipment uses smart edge/center snapping and guide lines',()=>{
 assert.ok(runtime.includes("function visibleObjects(){")&&runtime.includes("kind:'plan'")&&runtime.includes("kind:'equipment'"));
 assert.match(runtime,/function snapTargets\(excludeId\)[\s\S]*?xs\.push\(x,x\+w\/2,x\+w\);ys\.push\(y,y\+h\/2,y\+h\)/);
 const start=runtime.indexOf("svg.addEventListener('pointermove',e=>");
 const end=runtime.indexOf('\nfunction stopDrag(e)',start);
 assert.ok(start>=0&&end>start,'shared canvas pointermove handler should exist');
 const handler=runtime.slice(start,end);
 assert.match(handler,/next=snapMove\(item,rawX,rawY,e\.altKey\)/);
 assert.match(handler,/item\.x=next\.x;item\.y=next\.y;state\.snapGuides=\{x:next\.guideX,y:next\.guideY\}/);
 assert.match(runtime,/function renderGuides\(\)[\s\S]*?class','snap-guide'/);
 assert.match(html,/realtime-runtime\.js\?v=canvas-alignment-guides-v1/);
});

test('nearby edge alignment snaps exactly and reports both guide axes; Alt disables snapping',()=>{
 const start=runtime.indexOf('const SNAP_DISTANCE=8;');
 const end=runtime.indexOf('function renderGuides()',start);
 assert.ok(start>=0&&end>start);
 const moving={id:'moving',x:0,y:0,width:100,height:80};
 const other={id:'other',kind:'equipment',x:200,y:100,width:150,height:120};
 const context={CANVAS_WIDTH:2400,CANVAS_HEIGHT:1400,visibleObjects:()=>[moving,other]};
 vm.runInNewContext(`${runtime.slice(start,end)}\nglobalThis.testSnapMove=snapMove;`,context);
 const aligned=context.testSnapMove(moving,101,101,false);
 assert.deepEqual({x:aligned.x,y:aligned.y,guideX:aligned.guideX,guideY:aligned.guideY},{x:100,y:100,guideX:200,guideY:100});
 const free=context.testSnapMove(moving,101,101,true);
 assert.equal(free.x,101);assert.equal(free.y,101);assert.equal(free.guideX,null);assert.equal(free.guideY,null);
});
