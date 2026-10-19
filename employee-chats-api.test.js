'use strict';
const test=require('node:test'),assert=require('node:assert/strict');
const {EmployeeChatsAPI}=require('./employee-chats-api');
const {DirectChats}=require('./direct-chats');
const admin={id:'admin-id',role:'admin',name:'Admin',personalPageId:'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',rules:{sections:['chat'],actions:['comment']}};
const worker={id:'worker-id',role:'employee',name:'Araz',personalPageId:'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb',rules:{sections:['chat'],actions:['comment']}};
function setup(){
 admin.personalPageId='aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';worker.personalPageId='bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb';
 const accounts={enabled:true,state:{users:[admin,worker]},user:req=>req.user,section:()=>true,action:()=>true};
 const chats=new DirectChats(); const threads=new Map(); let nextId=0;
 const comments={
  async create({pageId,discussionId,user,text,attachments=[]}){const tid=discussionId||'thread-1';let items=threads.get(tid)||[];const comment={id:'c'+(++nextId),authorId:'bot',authorName:'['+user.name+']',text,createdAt:new Date(1700000000000+nextId*1000).toISOString(),discussionId:tid,attachments};items.push(comment);threads.set(tid,items);return {discussionId:tid,comment};},
  async list(pageId,discussionId){return threads.get(discussionId)||[];}
 };
 return {api:new EmployeeChatsAPI({accounts,chats,comments}),threads,chats};
}
const req=(method,user)=>({method,headers:{},user});
const url=(path,query='')=>new URL('http://localhost'+path+query);
test('chat starts a Notion discussion on the employee Personal page and reads its thread',async()=>{
 const {api,threads,chats}=setup();
 const sent=await api.handle(req('POST',admin),url('/api/employee-messages'),{peerId:worker.id,text:'Salam',operationId:'op-00000001'});
 assert.equal(sent.message.text,'Salam');
 assert.equal(chats.conversation(admin.id,worker.id).notionPageId,worker.personalPageId,'prefer employee profile over admin profile');
 assert.equal(threads.get('thread-1').length,1);
 threads.get('thread-1').push({id:'external-1',authorId:'person',authorName:'Araz',text:'Cavab',createdAt:new Date(1700000005000).toISOString(),discussionId:'thread-1'});
 const received=await api.handle(req('GET',admin),url('/api/employee-messages','?peerId='+worker.id),{});
 assert.deepEqual(received.messages.map(m=>m.text),['Salam','Cavab']);
 assert.equal(received.messages[1].senderId,worker.id);
});
test('retries are idempotent and unlinked chats retain local fallback',async()=>{
 const {api,chats}=setup();
 const sent=await api.handle(req('POST',admin),url('/api/employee-messages'),{peerId:worker.id,text:'Once',operationId:'op-00000002'});
 const retry=await api.handle(req('POST',admin),url('/api/employee-messages'),{peerId:worker.id,text:'Once',operationId:'op-00000002'});
 assert.equal(retry.duplicate,true);assert.equal(chats.conversation(admin.id,worker.id).messages.length,1);
 worker.personalPageId='';admin.personalPageId='';
 const local=await api.handle(req('POST',admin),url('/api/employee-messages'),{peerId:worker.id,text:'Local',operationId:'op-00000003'});
 assert.equal(local.message.text,'Local');assert.equal(chats.conversation(admin.id,worker.id).messages.length,2);
});
test('image-only messages are persisted in the Personal discussion',async()=>{
 const {api,chats}=setup(),attachment={type:'file_upload',file_upload_id:'upload-1'};
 const sent=await api.handle(req('POST',admin),url('/api/employee-messages'),{peerId:worker.id,text:'',attachments:[attachment],operationId:'op-00000004'});
 assert.equal(sent.message.text,'📷 Şəkil');
 assert.deepEqual(sent.message.attachments,[attachment]);
 assert.equal(chats.conversation(admin.id,worker.id).notionPageId,worker.personalPageId);
});
test('image messages require a linked Personal page',async()=>{
 const {api}=setup();admin.personalPageId='';worker.personalPageId='';
 await assert.rejects(()=>api.handle(req('POST',admin),url('/api/employee-messages'),{peerId:worker.id,text:'',attachments:[{file_upload_id:'upload-2'}],operationId:'op-00000005'}),/Personal profili/);
});
