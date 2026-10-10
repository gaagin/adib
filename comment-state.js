(function(root){'use strict';
function own(author,user){return String(author||'').trim().toLocaleLowerCase()===String(user||'').trim().toLocaleLowerCase()}
function incoming(threads,{seen=[],notified=null,initialized=false,previous=[],user=''}={}){
 if(!Array.isArray(threads))throw Error('Yanlış şərh cavabı');
 const read=new Set(seen),delivered=new Set(notified===null?[...seen,...previous.flatMap(t=>(t.comments||[]).map(c=>c.id))]:notified),notices=[];
 for(const thread of threads){if(!thread||!Array.isArray(thread.comments))continue;for(const c of thread.comments){if(!c?.id)continue;if(!initialized){read.add(c.id);delivered.add(c.id);continue}if(own(c.authorName,user)){read.add(c.id);delivered.add(c.id);continue}if(!read.has(c.id)&&!delivered.has(c.id)){notices.push({thread,comment:c});delivered.add(c.id)}}}
 return{seen:[...read],notified:[...delivered],initialized:true,notices};
}
const api={incoming,own};if(typeof module==='object'&&module.exports)module.exports=api;else root.ADIBCommentState=api;
})(typeof globalThis==='object'?globalThis:this);
