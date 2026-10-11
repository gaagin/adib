(function(root){'use strict';
const scope=()=>location.origin+':'+(root.ADIBWork?.state.actor?.id||root.ADIBAccount?.user?.id||'default');
const key=(kind,t)=>String(t?.id||'');
function storage(){return 'adib-local-timer-visibility-v2:'+scope()}
function read(){try{return JSON.parse(localStorage.getItem(storage())||'{}')}catch{return {}}}
function claim(kind,t){if(kind!=='work'||!t?.id)return;const s=read();s[kind]=key(kind,t);try{localStorage.setItem(storage(),JSON.stringify(s))}catch{}root.dispatchEvent(new Event('adib-local-timer-visibility'))}
function allowed(kind,t){return kind==='work'&&!!t?.id&&read()[kind]===key(kind,t)}
root.ADIBLocalTimer={claim,allowed};
})(window);