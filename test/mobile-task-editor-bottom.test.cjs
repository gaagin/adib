'use strict';
const test=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const path=require('node:path');
const root=path.join(__dirname,'..');
const css=fs.readFileSync(path.join(root,'elegant-ui.css'),'utf8');
const tabsCss=fs.readFileSync(path.join(root,'task-tabs.css'),'utf8');
const html=fs.readFileSync(path.join(root,'ela-nov-paketleme-dynamic.html'),'utf8');
const js=fs.readFileSync(path.join(root,'elegant-ui.js'),'utf8');
test('mobile task sheet pins actions to the bottom and does not reserve hidden navigation space',()=>{
 assert.match(css,/height:var\(--adib-elegant-sheet-height,100dvh\)!important;max-height:var\(--adib-elegant-sheet-height,100dvh\)!important/);
 assert.match(css,/adib-elegant-footer\{position:fixed!important;left:0!important;right:0!important;bottom:0!important/);
 assert.match(js,/fullScreenTaskModal=!!panel\.closest\('#taskModal\.open'\);if\(root\.innerWidth<800&&!fullScreenTaskModal\)/);
 assert.match(html,/if\(options\.returnToStats\)modal\.classList\.add\('adib-task-stats-origin'\)/);
 assert.match(tabsCss,/adib-task-stats-origin[^}]*\.adib-task-footer\{position:fixed!important;left:0!important;right:0!important;bottom:0!important/);
});
