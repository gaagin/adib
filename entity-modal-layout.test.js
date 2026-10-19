const {test}=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');

test('plan and equipment creation modal stays clear of the persistent sidebar',()=>{
 const html=fs.readFileSync(require.resolve('./ela-nov-paketleme-dynamic.html'),'utf8');
 const style=html.match(/<style id="entity-create-modal-layout-fix">([\s\S]*?)<\/style>/)?.[1]||'';
 assert.match(style,/inset:0 0 0 var\(--adib-side-width,0px\)!important/);
 assert.match(style,/z-index:60020!important/);
 assert.match(style,/#entityModal\.open>\.modal/);
 assert.match(style,/grid-template-columns:repeat\(2,minmax\(0,1fr\)\)!important/);
 assert.match(style,/@media\(max-width:700px\)/);
});