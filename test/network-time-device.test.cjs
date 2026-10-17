const test=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const vm=require('node:vm');
const {performance}=require('node:perf_hooks');
const ADIBZone=require('../zoned-time.js');

function loadClock(){
  const elements=new Map();
  class Element{
    constructor(tag){this.tagName=tag;this.children=[];this.className='';this.textContent='';this.value='';this.removed=false;}
    append(...nodes){this.children.push(...nodes);}
    remove(){this.removed=true;}
    close(){this.closed=true;}
    showModal(){this.open=true;}
  }
  const oldNotice=new Element('button');
  elements.set('adibClockNotice',oldNotice);
  const document={
    body:{children:[],append(...nodes){this.children.push(...nodes);}},
    createElement:tag=>new Element(tag),
    getElementById:id=>elements.get(id)||null,
    addEventListener(){}
  };
  let requests=0;
  const window={
    ADIBZone,
    addEventListener(){},
    dispatchEvent(){},
  };
  const context=vm.createContext({
    window,document,performance,Date,Intl,Event,
    fetch:()=>{requests++;throw Error('network time should not be requested');},
    setInterval:()=>1,
    clearInterval(){}
  });
  vm.runInContext(fs.readFileSync(require.resolve('../network-time.js'),'utf8'),context);
  return {clock:window.ADIBClock,document,oldNotice,get requests(){return requests;}};
}

test('the app clock trusts the device time and never requests network time',async()=>{
  const app=loadClock();
  assert.equal(app.clock.trusted,true);
  assert.ok(Math.abs(app.clock.now()-Date.now())<1000);
  assert.equal(app.clock.timeZone,Intl.DateTimeFormat().resolvedOptions().timeZone||'Asia/Baku');
  assert.equal(app.oldNotice.removed,true);
  await app.clock.ready;
  await app.clock.refresh(true);
  assert.equal(app.requests,0);
});

test('the clock details identify the device as the time source',()=>{
  const app=loadClock();
  app.clock.details();
  const dialog=app.document.body.children.at(-1);
  assert.equal(dialog.children[0].textContent,'Cihaz vaxtı');
  assert.match(dialog.children[1].value,/Mənbə: bu cihaz/);
});