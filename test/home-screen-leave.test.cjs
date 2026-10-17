const test=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const vm=require('node:vm');

test('calendar navigation can leave the canvas before the home panel was initialized',async()=>{
  let callbackRan=false,viewsClosed=0;
  const root={
    ADIBFilters:{read:(key,fallback)=>({...fallback}),write(){}},
    ADIBFilterDialog:{read:(key,fallback)=>({...fallback})},
    ADIBHomeBridge:{closeViews(){viewsClosed++;}},
    addEventListener(){}
  };
  const document={
    body:{classList:{remove(){}}},
    querySelectorAll(){return[];},
    getElementById(){return null;}
  };
  const context=vm.createContext({window:root,document,console,Promise,setTimeout,clearTimeout,setInterval:()=>1});
  vm.runInContext(fs.readFileSync(require.resolve('../home-screen.js'),'utf8'),context);

  assert.doesNotThrow(()=>root.ADIBHome.leave(()=>{callbackRan=true;}));
  await new Promise(resolve=>setImmediate(resolve));
  assert.equal(viewsClosed,1);
  assert.equal(callbackRan,true);
});