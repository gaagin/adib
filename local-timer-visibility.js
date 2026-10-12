(function(root){'use strict';
// Browser-local visual ownership only; shared work data and Pomodoro are unchanged.
const memory=new Map(),unavailable=new Set();
const scope=()=>location.origin+':'+(root.ADIBWork?.state.actor?.id||root.ADIBAccount?.user?.id||'default');
const storage=()=> 'adib-local-timer-visibility-v2:'+scope();
function read(){const k=storage();if(unavailable.has(k))return memory.get(k)||{};try{const value=JSON.parse(localStorage.getItem(k)||'{}');if(value&&typeof value==='object'&&!Array.isArray(value))return value;}catch{}return memory.get(k)||{};}
function write(value){const k=storage();memory.set(k,value);try{localStorage.setItem(k,JSON.stringify(value));unavailable.delete(k);}catch{unavailable.add(k);}}
function claim(kind,t){if(kind!=='work'||!t?.id)return;write({...read(),work:String(t.id)});}
function allowed(kind,t){return kind==='work'&&!!t?.id&&read().work===String(t.id);}
function remember(operationId){const s=read();write({...s,pending:[...(Array.isArray(s.pending)?s.pending:[]),operationId].slice(-10)});}
function recover(rows){const s=read(),pending=Array.isArray(s.pending)?s.pending:[];const t=(rows||[]).find(t=>t?.startOperation&&pending.includes(t.startOperation));if(t)claim('work',t);}
root.ADIBLocalTimer={claim,allowed,remember,recover};
})(window);
