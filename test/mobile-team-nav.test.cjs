const test=require('node:test'),assert=require('node:assert/strict'),vm=require('node:vm'),fs=require('node:fs'),path=require('node:path');
const source=fs.readFileSync(path.join(__dirname,'..','compact-design.js'),'utf8');
function setup({desktop=false,role='admin'}={}){
 const calls=[],nodes=new Map();
 function element(){return {children:[],dataset:{},setAttribute(k,v){this[k]=v},append(...items){this.children.push(...items)}}}
 const body=element();body.classList={add(){}};
 const window={ADIBDesktop:desktop,ADIBAccount:{user:role?{role}:null,section:()=>true},ADIBHome:{canLeave:()=>true},ADIBHomeBridge:{closeViews(){calls.push('closeViews')},matrix(){calls.push('matrix')}},alert(e){throw Error(e)}};
 const document={body,createElement:element,getElementById:id=>nodes.get(id),querySelectorAll:()=>[],querySelector:()=>null};
 const sandbox={window,document,matchMedia:()=>({matches:!desktop}),localStorage:{setItem(){}}};
 vm.createContext(sandbox);
 const prefix=source.slice(0,source.indexOf('let lastGlobalMenu=null;'));
 vm.runInContext(prefix+'root.__test={ensureNav,navigate,allowed};})(window);',sandbox);
 window.__test.ensureNav();return {window,calls,nodes,nav:body.children[0]};
}
test('mobile bottom bar replaces Matris with Komanda in the second slot',()=>{
 const s=setup();assert.deepEqual(Array.from(s.nav.children,b=>b.dataset.designNav),['tasks','team','calendar','equipment']);
 assert.equal(s.nav.children[1]['aria-label'],'Komanda');assert.equal(s.nav.children[1].hidden,false);
 s.nodes.set('teamSidebarButton',{click(){s.calls.push('team')}});s.nav.children[1].onclick();assert.deepEqual(s.calls,['closeViews','team']);
});
test('team access stays restricted and supports authentication completing later',()=>{
 const s=setup({role:null});assert.equal(s.nav.children[1].hidden,true);
 s.window.ADIBAccount.user={role:'manager'};assert.equal(s.window.__test.allowed('team'),true);
 s.window.ADIBAccount.user={role:'employee'};assert.equal(s.window.__test.allowed('team'),false);
 s.window.__test.navigate('team');assert.equal(s.calls.includes('team'),false);
});
test('desktop matrix navigation is unchanged',()=>{
 const s=setup({desktop:true});assert.equal(s.nav.children[1].dataset.designNav,'matrix');
 s.nav.children[1].onclick();assert.deepEqual(s.calls,['matrix']);
});
test('unsaved edits prevent navigation',()=>{
 const s=setup();s.window.ADIBHome.canLeave=()=>false;s.nav.children[1].onclick();assert.equal(s.calls.length,0);
});
