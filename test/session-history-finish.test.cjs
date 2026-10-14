const {test}=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const vm=require('node:vm');

class FakeElement{
  constructor(tag){this.tagName=tag.toUpperCase();this.children=[];this.listeners={};this.attributes={};this.className='';this.textContent='';this.disabled=false;this.parent=null;this.open=false;this.classList={add:(name)=>{const names=new Set(this.className.split(/\s+/).filter(Boolean));names.add(name);this.className=[...names].join(' ')},contains:(name)=>this.className.split(/\s+/).includes(name)}}
  append(...nodes){for(const node of nodes){node.parent=this;this.children.push(node)}}
  setAttribute(key,value){this.attributes[key]=value}
  addEventListener(type,fn){this.listeners[type]=fn}
  dispatch(type,event={}){this.listeners[type]?.(event)}
  close(){this.open=false;this.dispatch('close')}
  showModal(){this.open=true}
  focus(){}
  remove(){if(this.parent)this.parent.children=this.parent.children.filter(child=>child!==this)}
  scrollIntoView(){}
  closest(selector){return selector==='button'&&this.tagName==='BUTTON'?this:null}
  querySelector(selector){const cls=selector.startsWith('.')?selector.slice(1):null;for(const child of this.children){if(cls&&child.classList.contains(cls))return child;const nested=child.querySelector(selector);if(nested)return nested}return null}
  find(predicate){if(predicate(this))return this;for(const child of this.children){const found=child.find(predicate);if(found)return found}return null}
}
function setup(status){
  const session={id:'s1',taskId:'t1',title:'Test timer',kind:'work',status,revision:1,startedAt:Date.now()-5000,endedAt:status==='pending'?Date.now():null,seconds:5,worker:'Araz',sourceKey:'todo'};
  const body=new FakeElement('body'),document={body,createElement:tag=>new FakeElement(tag)};
  const calls=[],state={sessions:[session]};
  const root={document,ADIBClock:{now:()=>Date.now(),timeZone:'UTC'},ADIBWork:{state,stop:async()=>{},action:async request=>{calls.push(request.action);const current=state.sessions[0];if(request.action==='stop'){current.status='pending';current.endedAt=Date.now();current.revision++;return{session:{...current}}}if(request.action==='save'){current.status='saved';current.revision++;return{session:{...current}}}throw Error('unexpected action')}}};
  vm.runInNewContext(fs.readFileSync(__dirname+'/pomodoro-session-ui.js','utf8'),{window:root});
  root.ADIBSessions.history('t1');
  const history=body.children[0],row=history.find(e=>e.classList.contains('session-finishable'));
  row.dispatch('click',{target:row,preventDefault(){}});
  const popup=history.find(e=>e.className==='adib-session-finish');
  return{root,calls,history,popup};
}

test('clicking a running timer session opens a finish dialog and saves it',async()=>{
  const e=setup('running');assert.ok(e.popup?.open);assert.equal(e.popup.find(x=>x.tagName==='BUTTON'&&x.textContent==='Seansı bitir').disabled,false);
  await e.popup.find(x=>x.tagName==='BUTTON'&&x.textContent==='Seansı bitir').onclick();
  assert.deepEqual(e.calls,['stop','save']);assert.equal(e.history.open,false);
});
test('clicking a stopped, unconfirmed session offers to finish and save it',async()=>{
  const e=setup('pending');assert.ok(e.popup?.open);
  await e.popup.find(x=>x.tagName==='BUTTON'&&x.textContent==='Seansı bitir').onclick();
  assert.deepEqual(e.calls,['save']);assert.equal(e.history.open,false);
});
