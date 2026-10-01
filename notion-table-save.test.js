const {test}=require('node:test'),assert=require('node:assert/strict'),vm=require('node:vm'),fs=require('node:fs');
function harness(fail={}){
 const source=fs.readFileSync(__dirname+'/server.js','utf8');const code=source.slice(source.indexOf('function decodeHtmlText('),source.indexOf('\nasync function createPersonalTask('));
 const calls=[],active=new Map([['old-1',{id:'old-1'}],['old-2',{id:'old-2'}]]);let n=0,write=0;
 const ctx=vm.createContext({console,cleanId:x=>x,listStructuredPageBlocks:async()=>[{id:'old-1'},{id:'old-2'}],loadStructuredBlockTree:async()=>[],notion:async(url,opts)=>{
  const body=opts.body?JSON.parse(opts.body):null;calls.push({url,method:opts.method,body});
  if(opts.method==='PATCH'&&url.endsWith('/children')){
   write++;if(fail.write===write)throw Error('Notion API 400: injected write validation failure');
   assert.ok(body.children.length<=100);
   for(const block of body.children){if(block.type==='table'){assert.ok(Array.isArray(block.table.children)&&block.table.children.length>=1,'body.children[0].table.children should be defined');assert.ok(block.table.children.length<=100);for(const row of block.table.children)assert.equal(row.table_row.cells.length,block.table.table_width)}}
   const results=body.children.map(block=>{const id='new-'+(++n);active.set(id,{id,block});return {id}});return {results};
  }
  const id=url.split('/').pop();if(opts.method==='DELETE'){
   if(fail.archive===id)throw Error('Injected archive error');active.delete(id);return {};
  }
  if(opts.method==='PATCH'&&body?.archived===false){active.set(id,{id});return {}}throw Error('Unexpected request');
 }});vm.runInContext(code,ctx);return {ctx,calls,active,save:b=>ctx.replacePersonalTaskBlocks('page',b)};
}
test('table creation includes children in the SAME request, before any old blocks are deleted',async()=>{const h=harness();await h.save([{type:'table',rows:[['A','B'],['C','D']]}]);const create=h.calls[0];assert.equal(create.body.children[0].table.children.length,2);assert.equal(create.body.children[0].table.table_width,2);assert.deepEqual(h.calls.slice(1).map(x=>x.method),['DELETE','DELETE'])});
test('empty table still has one valid empty row',async()=>{const h=harness();await h.save([{type:'table',rows:[]}]);const t=h.calls[0].body.children[0].table;assert.equal(t.table_width,1);assert.equal(t.children.length,1);assert.deepEqual(t.children[0].table_row.cells,[[]])});
test('ragged rows are padded to width rather than losing cells',async()=>{const h=harness();await h.save([{type:'table',rows:[['a','b','c'],['d']]}]);const t=h.calls[0].body.children[0].table;assert.equal(t.table_width,3);assert.equal(t.children[1].table_row.cells.length,3);assert.deepEqual(t.children[1].table_row.cells[1],[])});
test('tables wider than previous 20-column cap are not truncated',async()=>{const h=harness();await h.save([{type:'table',rows:[Array.from({length:25},(_,i)=>'C'+i)]}]);assert.equal(h.calls[0].body.children[0].table.table_width,25)});
test('table with 205 rows includes first 100 in table and batches remaining rows by 100',async()=>{const h=harness();await h.save([{type:'table',rows:Array.from({length:205},()=>['x','y'])}]);assert.equal(h.calls[0].body.children[0].table.children.length,100);assert.equal(h.calls[1].body.children.length,100);assert.equal(h.calls[2].body.children.length,5);assert.ok(h.calls.slice(3).every(x=>x.method==='DELETE'))});
test('table header and rich-text annotations are retained',async()=>{const h=harness();await h.save([{type:'table',hasColumnHeader:true,rows:[['<b>Bold</b>','<i>Italic</i>']]}]);const t=h.calls[0].body.children[0].table;assert.equal(t.has_column_header,true);assert.equal(t.children[0].table_row.cells[0][0].annotations.bold,true);assert.equal(t.children[0].table_row.cells[1][0].annotations.italic,true)});
test('invalid table validation does not make any Notion writes or delete old content',async()=>{for(const dto of [{type:'table',rows:['bad']},{type:'table',rows:[['x']],width:-2},{type:'table',rows:[Array(101).fill('x')]}]){const h=harness();await assert.rejects(()=>h.save([dto]));assert.equal(h.calls.length,0);assert.ok(h.active.has('old-1'))}});
test('Notion creation failure leaves old content untouched',async()=>{const h=harness({write:1});await assert.rejects(()=>h.save([{type:'table',rows:[['x']]}]));assert.deepEqual([...h.active.keys()],['old-1','old-2']);assert.ok(!h.calls.some(x=>x.method==='DELETE'))});
test('later block failure removes staged new blocks, never old ones',async()=>{const h=harness({write:2});await assert.rejects(()=>h.save([{type:'paragraph',html:'new'},{type:'table',rows:[['x']]}]));assert.deepEqual([...h.active.keys()],['old-1','old-2']);assert.deepEqual(h.calls.filter(x=>x.method==='DELETE').map(x=>x.url),['/blocks/new-1'])});
test('failure appending remaining table rows removes staged table, keeps old content',async()=>{const h=harness({write:2});await assert.rejects(()=>h.save([{type:'table',rows:Array.from({length:101},()=>['x'])}]));assert.ok(h.active.has('old-1'));assert.ok(h.active.has('old-2'));assert.ok(!h.active.has('new-1'))});
test('failure archiving old content attempts rollback instead of silently reporting success',async()=>{const h=harness({archive:'old-2'});await assert.rejects(()=>h.save([{type:'paragraph',html:'new'}]));assert.ok(h.active.has('old-1'));assert.ok(h.active.has('old-2'));assert.ok(!h.active.has('new-1'));assert.equal(h.calls.filter(x=>x.body?.archived===false).length,2)});
test('mixed paragraph/table/heading creates all content before archiving old blocks',async()=>{const h=harness();const result=await h.save([{type:'paragraph',html:'text'},{type:'table',rows:[['cell']]},{type:'heading_1',html:'title'}]);assert.equal(result.ok,true);assert.deepEqual(h.calls.map(x=>x.method),['PATCH','PATCH','PATCH','DELETE','DELETE']);assert.ok(!h.active.has('old-1'))});
