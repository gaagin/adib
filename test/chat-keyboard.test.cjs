const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const vm = require('node:vm');
const source=fs.readFileSync(require.resolve('../discussions-ui.js'),'utf8');
const code=source.slice(source.indexOf('/* Keep mobile chat inside the visible viewport'));
function fixture({mobile=true,visual=true}={}){
  const events=new Map(),raf=[],observers=[];
  const style=new Map(),attrs=new Map();
  const list={scrollTop:100,scrollHeight:1000,clientHeight:300};
  const field={matches:()=>true};
  const overlay={hidden:false,style:{getPropertyValue:k=>style.get(k)||'',setProperty:(k,v)=>style.set(k,v),removeProperty:k=>style.delete(k)},
    setAttribute:(k,v)=>attrs.set(k,v),removeAttribute:k=>attrs.delete(k),toggleAttribute:(k,v)=>v?attrs.set(k,''):attrs.delete(k),
    contains:node=>node===field,querySelector:()=>list};
  const classes=new Set(['adib-chat-open']);
  const doc={readyState:'complete',activeElement:field,body:{classList:{contains:k=>classes.has(k)}},documentElement:{classList:{contains:()=>false}},
    getElementById:()=>overlay,addEventListener:(k,fn)=>events.set('doc:'+k,fn)};
  const vv={height:480,offsetTop:0,scale:1,addEventListener:(k,fn)=>events.set('vv:'+k,fn)};
  const vk={boundingRect:{height:0,top:0},addEventListener:(k,fn)=>events.set('vk:'+k,fn)};
  const win={document:doc,innerHeight:844,visualViewport:visual?vv:undefined,navigator:{virtualKeyboard:vk},matchMedia:()=>({matches:mobile}),
    requestAnimationFrame:fn=>{raf.push(fn);return raf.length},setTimeout:()=>1,clearTimeout(){},addEventListener:(k,fn)=>events.set(k,fn)};
  const context={window:win,MutationObserver:class{constructor(fn){this.fn=fn;observers.push(this)}observe(){}disconnect(){}}};
  vm.runInNewContext(code,context);
  const flush=()=>{let count=0;while(raf.length){assert.ok(count++<10);raf.shift()();}};
  flush();return {win,doc,vv,vk,events,overlay,attrs,style,list,classes,observers,flush};
}
test('visual viewport pins mobile chat above keyboard without changing draft or focus',()=>{
 const f=fixture();assert.equal(f.style.get('--adib-chat-visible-height'),'480px');assert.ok(f.attrs.has('data-chat-keyboard'));assert.ok(f.attrs.has('data-chat-viewport'));assert.ok(f.doc.activeElement);
});
test('viewport scrolling and keyboard dismissal restore bounds',()=>{
 const f=fixture();f.vv.offsetTop=35;f.events.get('vv:scroll')();f.flush();assert.equal(f.style.get('--adib-chat-visible-top'),'35px');
 f.vv.height=844;f.vv.offsetTop=0;f.events.get('vv:resize')();f.flush();assert.equal(f.style.get('--adib-chat-visible-height'),'844px');assert.equal(f.attrs.has('data-chat-keyboard'),false);
});
test('older WebViews fall back to resized innerHeight',()=>{
 const f=fixture({visual:false});f.win.innerHeight=390;f.events.get('resize')();f.flush();assert.equal(f.style.get('--adib-chat-visible-height'),'390px');
});
test('overlay-mode virtual keyboard geometry is respected',()=>{
 const f=fixture();f.vv.height=844;f.vk.boundingRect={top:460,height:384};f.events.get('vk:geometrychange')();f.flush();assert.equal(f.style.get('--adib-chat-visible-height'),'460px');
});
test('closing chat removes temporary bounds',()=>{
 const f=fixture();f.overlay.hidden=true;f.observers.at(-1).fn();f.flush();assert.equal(f.attrs.size,0);assert.equal(f.style.size,0);
});
test('desktop is not resized and pinch zoom is not treated as keyboard',()=>{
 const d=fixture({mobile:false});assert.equal(d.attrs.size,0);
 const f=fixture();f.vv.scale=2;f.vv.height=200;f.events.get('vv:resize')();f.flush();assert.equal(f.style.get('--adib-chat-visible-height'),'480px');
});
test('history reader keeps position; bottom-following reader stays at newest message',()=>{
 const f=fixture();assert.equal(f.list.scrollTop,100);
 f.list.scrollTop=700;f.vv.height=400;f.events.get('vv:resize')();f.flush();assert.equal(f.list.scrollTop,1000);
});
