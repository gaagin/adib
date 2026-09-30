const fs=require('node:fs'),path=require('node:path');
function canonicalDuration(raw,mode='work'){const n=Number(raw),fallback=mode==='break'?5:25;return Math.max(1,Math.min(mode==='break'?60:180,Number.isFinite(n)&&n>0&&Number.isInteger(n)?n:fallback));}
function normalizeTimer(t){return {...t,duration:canonicalDuration(t.plannedDuration??t.duration,t.mode),plannedDuration:canonicalDuration(t.plannedDuration??t.duration,t.mode)};}
class SharedPomodoroStore{
 constructor(file=''){this.file=file;this.timers=new Map();this.revision=0;if(file)try{const data=JSON.parse(fs.readFileSync(file,'utf8'));for(const t of data.timers||[])if(t.id)this.timers.set(t.id,normalizeTimer(t));this.revision=Number(data.revision)||0}catch{}}
 get(id){return this.timers.get(id)}
 put(timer){const value={...normalizeTimer(timer),revision:this.revision=Math.max(Date.now(),this.revision+1)};this.timers.set(value.id,value);if(this.timers.size>300){const oldest=[...this.timers.values()].filter(t=>!t.running).sort((a,b)=>a.revision-b.revision)[0];if(oldest)this.timers.delete(oldest.id)}if(this.file){fs.mkdirSync(path.dirname(this.file),{recursive:true});const tmp=this.file+'.tmp';fs.writeFileSync(tmp,JSON.stringify({revision:this.revision,timers:[...this.timers.values()]}));fs.renameSync(tmp,this.file)}return value}
 snapshot(now=Date.now()){return{ok:true,serverNow:now,revision:this.revision,timers:[...this.timers.values()].map(t=>({...t,remainingSeconds:t.running?Math.max(0,Math.ceil((t.endsAt-now)/1000)):t.remainingSeconds}))}}
}
function timerFromTask(task,now=Date.now()){
 const mode=String(task.pomodoroMode||'').toLowerCase().includes('перерыв')?'break':'work',raw=Number(task.pomodoroDuration),fallback=mode==='break'&&String(task.pomodoroMode).includes('15')?15:mode==='break'?5:25;
 const duration=canonicalDuration(Number.isInteger(raw)&&raw>0?raw:fallback,mode),clockMinutes=raw>0?raw:duration,started=Date.parse(task.pomodoroStartedAt),running=Boolean(task.pomodoroRunning&&Number.isFinite(started)),endsAt=running?started+clockMinutes*60000:0;
 return{id:task.id,title:task.title||'Pomodoro',mode,duration,plannedDuration:duration,running,status:running?'running':'stopped',startedAt:running?task.pomodoroStartedAt:'',endsAt,remainingSeconds:running?Math.max(0,Math.ceil((endsAt-now)/1000)):duration*60,sessionId:running?task.id+':'+task.pomodoroStartedAt:'',openedAt:0,pomodoroCount:Number(task.pomodoroCount)||0,pomodoroMinutes:Number(task.pomodoroMinutes)||0};
}
module.exports={SharedPomodoroStore,timerFromTask,canonicalDuration};
