const test=require('node:test'),assert=require('node:assert/strict'),fs=require('node:fs'),path=require('node:path');
const html=fs.readFileSync(path.join(__dirname,'..','ela-nov-paketleme-dynamic.html'),'utf8');
test('task editor Plan has searchable suggestions wired to the saved select',()=>{
 assert.ok(html.includes('id=\\"taskPlanSearch\\" type=\\"search\\" placeholder=\\"Plan axtarışı…\\"'));
 assert.ok(html.includes('id=\\"taskPlanResults\\" class=\\"task-machine-results\\" role=\\"listbox\\"'));
 assert.ok(html.includes("planSearch?.addEventListener('input',()=>"));
 assert.ok(html.includes('data-plan-search-value=\\"\'+escapeHtml(option.value)+\'\\"'));
 assert.ok(html.includes('planSelect.value=button.dataset.planSearchValue'));
 assert.ok(html.includes("document.getElementById('taskPlan')?.value||task.planId||''"));
});
