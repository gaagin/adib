'use strict';

const test=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const path=require('node:path');
const vm=require('node:vm');

const page=fs.readFileSync(path.join(__dirname,'..','ela-nov-paketleme-dynamic.html'),'utf8');
const helper=page.match(/function adibCanOpenObjectContextMenu\(target\)\{[^\n]*\}/)?.[0];
assert.ok(helper,'context-menu permission guard exists');

function canOpen(target,account){const context={window:{ADIBAccount:account}};vm.runInNewContext(helper,context);return context.adibCanOpenObjectContextMenu(target)}

test('employees cannot open equipment or plan context menus',()=>{
 const employee={user:{role:'employee'}};
 assert.equal(canOpen({kind:'equipment'},employee),false);
 assert.equal(canOpen({kind:'plan'},employee),false);
});

test('admins keep equipment and plan context menus',()=>{
 const admin={user:{role:'admin'}};
 assert.equal(canOpen({kind:'equipment'},admin),true);
 assert.equal(canOpen({kind:'plan'},admin),true);
});

test('other context menus and installations without account management are unchanged',()=>{
 assert.equal(canOpen({kind:'personal-task'},{user:{role:'employee'}}),true);
 assert.equal(canOpen({kind:'equipment'},undefined),true);
});

test('all object-menu open paths pass through the role guard',()=>{
 assert.match(page,/function adibContextOpen\(target,x,y\)\{if\(!adibCanOpenObjectContextMenu\(target\)\)return;/);
});
