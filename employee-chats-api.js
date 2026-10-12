'use strict';
const {fail}=require('./accounts');
class EmployeeChatsAPI {
 constructor({accounts,chats}){this.accounts=accounts;this.chats=chats;}
 routes(path){return ['/api/employee-chats','/api/employee-messages'].includes(path);}
 handle(req,url,body={}){
  const a=this.accounts,p=url.pathname,method=req.method;if(!body||typeof body!=='object'||Array.isArray(body))throw fail('Yanlış sorğu',400);
  if(!this.routes(p))throw fail('Naməlum marşrut',404);
  if(!a.enabled){if(p==='/api/employee-chats'&&method==='GET')return {ok:true,available:false,employees:[],threads:[]};throw fail('Əməkdaşlarla söhbət üçün ADIB hesabına daxil olun',409);}
  const u=a.user(req);if(!a.section(u,'chat'))throw fail('Müzakirələrə giriş yoxdur');
  if(req.headers.origin&&!req.headers.authorization&&method!=='GET'){const o=new URL(req.headers.origin);if(o.host!==req.headers.host&&o.protocol!=='adib:')throw fail('Yanlış sorğu mənbəyi');}
  const peers=a.state.users.filter(v=>!v.disabled&&v.id!==u.id&&a.section(v,'chat'));
  if(p==='/api/employee-chats'){
   if(method!=='GET')throw fail('Metod icazə verilmir',405);
   const ids=new Set(peers.map(v=>v.id)),name=id=>peers.find(v=>v.id===id)?.name||'Əməkdaş';
   return {ok:true,available:true,employees:peers.map(v=>({id:v.id,name:v.name})),threads:this.chats.list(u.id,name).filter(v=>ids.has(v.peerId))};
  }
  if(!['GET','POST'].includes(method))throw fail('Metod icazə verilmir',405);
  const peerId=method==='GET'?url.searchParams.get('peerId'):body.peerId,peer=peers.find(v=>v.id===peerId);
  if(!peer)throw fail('Əməkdaş mövcud deyil',404);
  if(method==='POST'){
   if(!a.action(u,'comment'))throw fail('Mesaj göndərmək icazəsi yoxdur');
   const op=String(body.operationId||'');if(!/^[a-zA-Z0-9-]{8,100}$/.test(op))throw fail('Əməliyyat identifikatoru yanlışdır',400);
   const existing=this.chats.conversation(u.id,peerId)?.messages.find(m=>m.senderId===u.id&&m.operationId===op);
   if(existing){this.chats.save();return {ok:true,message:existing,duplicate:true};}
   const message=this.chats.send(u,peerId,body.text,op);return {ok:true,message};
  }
  return {ok:true,...this.chats.messages(u.id,peerId,peer.name)};
 }
}
module.exports={EmployeeChatsAPI};
