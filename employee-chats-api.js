'use strict';
const {fail}=require('./accounts');
class EmployeeChatsAPI {
 constructor({accounts,chats,comments=null}){this.accounts=accounts;this.chats=chats;this.comments=comments;this.inFlight=new Map();}
 routes(path){return ['/api/employee-chats','/api/employee-messages'].includes(path);}
 pageFor(a,b){
  const candidates=[a,b].filter(x=>String(x.personalPageId||'').trim());
  candidates.sort((x,y)=>(x.role==='admin'?1:0)-(y.role==='admin'?1:0)||String(x.id).localeCompare(String(y.id)));
  return candidates[0]?.personalPageId||'';
 }
 normalizeName(v){return String(v||'').trim().toLocaleLowerCase('az');}
 async handle(req,url,body={}){
  const a=this.accounts,p=url.pathname,method=req.method;if(!body||typeof body!=='object'||Array.isArray(body))throw fail('Yanlış sorğu',400);
  if(!this.routes(p))throw fail('Naməlum marşrut',404);
  if(!a.enabled){if(p==='/api/employee-chats'&&method==='GET')return {ok:true,available:false,employees:[],threads:[]};throw fail('Əməkdaşlarla söhbət üçün ADIB hesabına daxil olun',409);}
  const u=a.user(req);if(!a.section(u,'chat'))throw fail('Müzakirələrə giriş yoxdur');
  if(req.headers.origin&&!req.headers.authorization&&method!=='GET'){const o=new URL(req.headers.origin);if(o.host!==req.headers.host&&o.protocol!=='adib:')throw fail('Yanlış sorğu mənbəyi');}
  const peers=a.state.users.filter(v=>!v.disabled&&v.id!==u.id&&a.section(v,'chat'));
  if(p==='/api/employee-chats'){
   if(method!=='GET')throw fail('Metod icazə verilmir',405);
   const ids=new Set(peers.map(v=>v.id)),name=id=>peers.find(v=>v.id===id)?.name||'Əməkdaş';
   return {ok:true,available:true,employees:peers.map(v=>({id:v.id,name:v.name,personalLinked:!!v.personalPageId})),threads:this.chats.list(u.id,name).filter(v=>ids.has(v.peerId))};
  }
  if(!['GET','POST'].includes(method))throw fail('Metod icazə verilmir',405);
  const peerId=method==='GET'?url.searchParams.get('peerId'):body.peerId,peer=peers.find(v=>v.id===peerId);
  if(!peer)throw fail('Əməkdaş mövcud deyil',404);
  if(method==='GET'){
   this.chats.messages(u.id,peerId,peer.name);
   const conversation=this.chats.conversation(u.id,peerId),pageId=conversation?.notionPageId||this.pageFor(u,peer),discussionId=conversation?.notionDiscussionId||'';
   if(pageId&&discussionId&&this.comments?.list){
    const comments=await this.comments.list(pageId,discussionId);
    const messages=comments.map(comment=>{
     const authorName=String(comment.authorName||'Əməkdaş');
     const sender=[u,peer].find(v=>v.id===comment.authorId||this.normalizeName(v.name)===this.normalizeName(authorName))||peer;
     const parsed=Date.parse(comment.createdAt||'');
     return {id:String(comment.id),senderId:sender.id,senderName:authorName,recipientId:sender.id===u.id?peer.id:u.id,text:String(comment.text||''),createdAt:Number.isFinite(parsed)?parsed:comment.createdAt,attachments:comment.attachments||[]};
    });
    this.chats.importMessages(u.id,peerId,messages);
   }
   return {ok:true,...this.chats.messages(u.id,peerId,peer.name)};
  }
  if(!a.action(u,'comment'))throw fail('Mesaj göndərmək icazəsi yoxdur');
  const text=String(body.text||'').trim(),attachments=body.attachments===undefined?[]:body.attachments,op=String(body.operationId||'');if(!/^[a-zA-Z0-9-]{8,100}$/.test(op))throw fail('Əməliyyat identifikatoru yanlışdır',400);
  if(!Array.isArray(attachments)||attachments.length>3)throw fail('Mesaja 3-ə qədər şəkil əlavə edə bilərsiniz',400);
  if((!text&&!attachments.length)||text.length>4000)throw fail('Mesaj və ya şəkil əlavə edin',400);
  const previous=this.chats.findOperation(u.id,peerId,op);if(previous)return {ok:true,message:previous,duplicate:true};
  const sendKey=this.chats.key(u.id,peerId)+':'+op;if(this.inFlight.has(sendKey))return this.inFlight.get(sendKey);
  const job=(async()=>{
   const conversation=this.chats.conversation(u.id,peerId),pageId=conversation?.notionPageId||this.pageFor(u,peer);
   if(attachments.length&&(!pageId||!this.comments?.create))throw fail('Şəkil göndərmək üçün söhbətin iştirakçısını Personal profili ilə bağlayın',409);
   if(pageId&&this.comments?.create){
    if(text.length>1850)throw fail('Mesajlar Personal şərhləri üçün 1850 simvoldan qısa olmalıdır',400);
    const result=await this.comments.create({pageId,discussionId:conversation?.notionDiscussionId||'',user:u,text,attachments});
    const discussionId=result.discussionId||conversation?.notionDiscussionId||'';if(!discussionId)throw fail('Notion cavabında söhbət mövzusu yoxdur. Yoxlayın Personal qeydlərinə şərh yazmaq icazəsini.',502);
    this.chats.bindNotionThread(u.id,peerId,pageId,discussionId);
    const comment=result.comment||{},message={id:String(comment.id||''),senderId:u.id,senderName:u.name,recipientId:peer.id,text:String(comment.text||text||(attachments.length?'📷 Şəkil':'')),createdAt:Number.isFinite(Date.parse(comment.createdAt||''))?Date.parse(comment.createdAt):Date.now(),operationId:op,attachments:comment.attachments||[]};
    if(!message.id)message.id=op;this.chats.record(u.id,peerId,message);return {ok:true,message};
   }
   const message=this.chats.send(u,peerId,text,op);return {ok:true,message};
  })();
  this.inFlight.set(sendKey,job);try{return await job}finally{this.inFlight.delete(sendKey)}
 }
}
module.exports={EmployeeChatsAPI};
