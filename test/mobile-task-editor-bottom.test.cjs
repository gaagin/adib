'use strict';
const test=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const path=require('node:path');
const css=fs.readFileSync(path.join(__dirname,'..','focused-views.css'),'utf8');
test('mobile task properties sheet fills the viewport and removes the oversized bottom gap',()=>{
 assert.match(css,/\.adib-task-properties-panel\.adib-elegant-sheet\{[^}]*height:100dvh!important;max-height:100dvh!important/);
 assert.match(css,/\.adib-task-properties-panel\.adib-elegant-sheet>#taskList\{padding-bottom:calc\(12px \+ var\(--adib-safe-bottom,0px\)\)!important\}/);
});
