const test=require('node:test'),assert=require('node:assert/strict'),fs=require('node:fs'),path=require('node:path'),vm=require('node:vm');
const js=fs.readFileSync(path.join(__dirname,'..','team-view.js'),'utf8');
const css=fs.readFileSync(path.join(__dirname,'..','team-view.css'),'utf8');
test('desktop team view reserves the existing sidebar width and collapse state',()=>{
 assert.match(css,/@media\(min-width:701px\)\{\s*body\.adib-side-ready \.adib-team-view\{left:var\(--adib-side-width,0px\)\}/);
 assert.match(css,/body\.adib-team-open #adibPersistentSide\{z-index:30002\}/);
 assert.match(js,/sideButton\.id !== 'teamSidebarButton'/);
 assert.match(js,/!sideButton\.matches\('\.adib-side-toggle,\.adib-home-theme,\.adib-home-clock'\)/);
});
test('shared sidebar and footer remain accessible, not behind a modal',()=>{
 const root={hidden:false,style:{},setAttribute(k,v){this[k]=v}};
 const context={root,window:{innerWidth:1440},document:{body:{classList:{contains:()=>true}},querySelector:()=>null}};
 vm.createContext(context);vm.runInContext(js.slice(js.indexOf('  function syncSharedNavigation()'),js.indexOf('  function show()')),context);
 context.syncSharedNavigation();assert.equal(root['aria-modal'],'false');assert.equal(root.style.bottom,'0px');
 context.window.innerWidth=390;context.document.querySelector=()=>({getBoundingClientRect:()=>({height:66})});context.syncSharedNavigation();assert.equal(root.style.bottom,'66px');assert.equal(root['aria-modal'],'false');
});
