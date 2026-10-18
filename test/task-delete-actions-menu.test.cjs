'use strict';
const test=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const path=require('node:path');
const root=path.join(__dirname,'..');
const js=fs.readFileSync(path.join(root,'elegant-ui.js'),'utf8');
test('task delete actions for equipment and personal task editors are placed inside the ellipsis menu',()=>{
 assert.match(js,/\.adib-elegant-footer \.editor-actions,\.adib-task-footer \.editor-actions/);
 assert.match(js,/querySelectorAll\('#deleteTask,#personalDeleteTask'\)/);
 assert.match(js,/for\(const node of deletions\)\{if\(node\.parentElement!==pop\)pop\.append\(node\)/);
 assert.match(js,/if\(actions&&\(copies\.length\|\|deletions\.length\)\)/);
});
