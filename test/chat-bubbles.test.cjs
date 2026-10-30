const {test}=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs'),vm=require('node:vm'),path=require('node:path');
const source=fs.readFileSync(path.join(__dirname,'../discussions-ui.js'),'utf8');
const start=source.indexOf('function chatMessageView('),end=source.indexOf('function decorateMessageBubbles(',start);
const context={};vm.createContext(context);vm.runInContext(source.slice(start,end)+';this.view=chatMessageView',context);
const view=context.view;
test('own task comment is outgoing, other author incoming',()=>{
 assert.equal(view({authorName:'Ilqar Mamedov',text:'Salam'},{id:'u1',name:'Ilqar Mamedov'}).mine,true);
 assert.equal(view({authorName:'Araz Verdiyev',text:'Salam'},{id:'u1',name:'Ilqar Mamedov'}).mine,false);
});
test('direction reverses for the other signed-in account',()=>{
 assert.equal(view({authorName:'Ilqar Mamedov'},{name:'Araz Verdiyev'}).mine,false);
 assert.equal(view({authorName:'Araz Verdiyev'},{name:'Araz Verdiyev'}).mine,true);
});
test('legacy zavod bridge prefix selects displayed author and removes prefix',()=>{
 const result=view({authorName:'zavod',text:'[Ilqar Mamedov] Salam'},{name:'Ilqar Mamedov'});
 assert.equal(result.mine,true);assert.equal(result.text,'Salam');assert.equal(result.name,'Ilqar Mamedov');
});
test('native Notion comment with brackets is not stripped',()=>{
 const result=view({authorName:'Araz',text:'[Ilqar Mamedov] quoted text'},{name:'Ilqar Mamedov'});
 assert.equal(result.mine,false);assert.equal(result.text,'[Ilqar Mamedov] quoted text');
});
test('explicit employee alias is supported without fuzzy first-name matching',()=>{
 assert.equal(view({authorName:'Araz'},{name:'Araz Verdiyev',rules:{assignee:'Araz'}}).mine,true);
 assert.equal(view({authorName:'Araz'},{name:'Araz Verdiyev'}).mine,false);
});
test('direct account IDs take precedence over identical display names',()=>{
 assert.equal(view({direct:true,authorId:'u2',authorName:'Same'},{id:'u1',name:'Same'}).mine,false);
 assert.equal(view({direct:true,authorId:'u1',authorName:'Old name'},{id:'u1',name:'New name'}).mine,true);
});
test('empty identities never match',()=>assert.equal(view({text:'Hi'},{}).mine,false));
test('presentation does not mutate source comments or interpret HTML',()=>{
 const comment=Object.freeze({authorName:'zavod',text:'[Araz] <script>bad</script>\n🙂'});
 assert.equal(view(comment,{name:'Araz'}).text,'<script>bad</script>\n🙂');
 assert.equal(comment.text,'[Araz] <script>bad</script>\n🙂');
});
