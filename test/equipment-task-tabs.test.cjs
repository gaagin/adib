const test=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const path=require('node:path');
const vm=require('node:vm');
const source=fs.readFileSync(path.join(__dirname,'../task-tabs.js'),'utf8');
const css=fs.readFileSync(path.join(__dirname,'../task-tabs.css'),'utf8');
function setup(){const calls=[];const root={addEventListener(){},ADIBAutosave:{bind(...args){calls.push({receiver:this,args});return 'saved'}}};vm.runInNewContext(source,{window:root});return {root,calls}}
test('shared equipment layout is independent of desktop/Android flags',()=>{
 assert.match(source,/const androidEquipment=!personal;/);
 assert.match(source,/androidEquipment\?\['chat','task','description'\]/);
 assert.match(source,/if\(isNew\)return null/);
 assert.match(css,/@media all\{/);
 assert.match(css,/grid-template-columns:minmax\(0,1fr\)!important/);
});
test('autosave bridge preserves binding arguments, receiver and return value',()=>{
 const {root,calls}=setup(),list={querySelector:()=>null},options={id:'a',endpoint:'/api/task'};
 assert.equal(root.ADIBAutosave.bind(list,options),'saved');
 assert.equal(calls.length,1);assert.equal(calls[0].receiver,root.ADIBAutosave);
 assert.equal(calls[0].args[0],list);assert.equal(calls[0].args[1],options);
});
test('new tasks do not install existing-task tabs',()=>{
 const {root,calls}=setup();const editor={querySelector:s=>s==='#taskTitle'?{}:null};
 root.ADIBAutosave.bind({querySelector:()=>editor},{id:'draft',endpoint:'/api/task',fresh:true});
 assert.equal(calls.length,1);assert.equal(editor.__adibTaskTabs,undefined);
});
test('personal forms and unrelated endpoints keep their original lifecycle',()=>{
 const {root,calls}=setup();
 root.ADIBAutosave.bind({querySelector:()=>({querySelector:()=>null})},{id:'personal',endpoint:'/api/personal-task'});
 root.ADIBAutosave.bind({querySelector:()=>({querySelector:()=>({})})},{id:'other',endpoint:'/api/other'});
 assert.equal(calls.length,2);
});
test('installation is idempotent and never clones save controls',()=>{
 assert.match(source,/if\(editor\.__adibTaskTabs\)return editor\.__adibTaskTabs/);
 assert.doesNotMatch(source,/cloneNode|innerHTML\s*\+=/);
 assert.match(source,/return bind\.apply\(this,arguments\)/);
 assert.match(source,/tabs\.panes\.description\.append\(photos\)/);
});
