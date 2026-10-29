const test=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const path=require('node:path');
const vm=require('node:vm');
const source=fs.readFileSync(path.join(__dirname,'../team-view.js'),'utf8');
const tick=()=>new Promise(r=>setTimeout(r,10));
function harness(kind='equipment',opener){
 let active=false,observer,shown=0,closed=0;
 const scroller={isConnected:true,scrollTop:125,scrollLeft:0};
 const root={...scroller,querySelectorAll:()=>[scroller]};
 class Observer{constructor(fn){this.fn=fn;observer=this}observe(){}disconnect(){this.disconnected=true}}
 const window={ADIBHomeBridge:{activate(){},openTask:opener||(()=>{active=true})},ADIBEquipmentCalendar:{open:opener||(()=>{active=true})}};
 const document={body:{},querySelector:()=>active?{}:null};
 const code=source.replace(/  if \(document.readyState === 'loading'\)[\s\S]*?else init\(\);/,`window.testAPI={openTask,cancelTaskReturn,rememberTeamScroll,setup:r=>{root=r;show=()=>window.shown();close=()=>window.closed();setMessage=()=>{};}};`);
 window.shown=()=>shown++;window.closed=()=>closed++;
 vm.runInNewContext(code,{window,document,MutationObserver:Observer,setTimeout,clearTimeout,Intl,Date});window.testAPI.setup(root);
 return {api:window.testAPI,root,scroller,open:()=>window.testAPI.openTask({id:'task',kind}),active:value=>active=value,change:()=>observer.fn(),shown:()=>shown,closed:()=>closed};
}
for(const kind of ['equipment','personal'])test(`${kind}: only exiting a team-opened editor restores team`,async()=>{
 const h=harness(kind);await h.open();await tick();assert.equal(h.shown(),0);assert.equal(h.closed(),1);
 h.change();await tick();assert.equal(h.shown(),0,'saving or switching tabs must not return');
 h.active(false);h.change();await tick();assert.equal(h.shown(),1);
 h.change();await tick();assert.equal(h.shown(),1,'return context is one-shot');
});
test('explicit navigation cancels the pending team return',async()=>{
 const h=harness();await h.open();h.api.cancelTaskReturn();h.active(false);h.change();await tick();assert.equal(h.shown(),0);
});
test('failed task opening restores team and does not leave an observer behind',async()=>{
 const h=harness('equipment',()=>Promise.reject(Error('Missing')));await h.open();assert.equal(h.shown(),1);h.change();await tick();assert.equal(h.shown(),1);
});
test('async opening does not restore team before the editor appears',async()=>{
 let resolve;const h=harness('equipment',()=>new Promise(r=>resolve=r));const pending=h.open();h.change();await tick();assert.equal(h.shown(),0);h.active(true);resolve();await pending;await tick();assert.equal(h.shown(),0);h.active(false);h.change();await tick();assert.equal(h.shown(),1);
});
test('restores original scroll without recreating the dashboard',()=>{
 const h=harness();const restore=h.api.rememberTeamScroll();h.scroller.scrollTop=0;h.root.scrollTop=0;restore();assert.equal(h.scroller.scrollTop,125);assert.equal(h.root.scrollTop,125);
});
