/* Calendar intervals are independent of estimates and Pomodoro sessions. */
(function(root,factory){const api=factory(root);if(typeof module==='object'&&module.exports)module.exports=api;else root.ADIBCalendarTime=api;})(typeof window==='object'?window:globalThis,function(root){'use strict';
const DEFAULT=30,STEP=15,MAX=7*1440;
const key=d=>d.getFullYear()+'-'+String(d.getMonth()+1).padStart(2,'0')+'-'+String(d.getDate()).padStart(2,'0');
const Z=typeof module==='object'&&module.exports?require('./zoned-time'):root.ADIBZone;const zone=()=>root.ADIBClock?.timeZone||'Asia/Baku';
const fromParts=(year,month,day=1,hour=0,minute=0,second=0,millisecond=0)=>Z.fromParts(year,month,day,hour,minute,second,millisecond,zone());
const clone=d=>new Z.ZonedDate(d.getTime(),zone());
function parse(value){return Z.parse(value,zone());}
const minutes=d=>d.getHours()*60+d.getMinutes();const time=n=>String(Math.floor(n/60)).padStart(2,'0')+':'+String(Math.floor(n%60)).padStart(2,'0');
function interval(task){const start=parse(task.date),end=parse(task.dateEnd),allDay=!start||!String(task.date).includes('T'),delta=start&&end?(end-start)/60000:0;return {start,end:!allDay&&delta>0&&delta<=MAX?end:start?clone(new Date(start.getTime()+DEFAULT*60000)):null,duration:!allDay&&delta>0&&delta<=MAX?delta:DEFAULT,allDay};}
function slot(day,minute,duration=DEFAULT){const start=parse(day);if(!start)throw Error('Yanlış gün');start.setMinutes(Math.max(0,Math.min(1439,Math.round(minute))));const end=clone(new Date(start.getTime()+Math.max(STEP,Math.min(MAX,duration))*60000));return {date:start.toISOString(),dateEnd:end.toISOString()};}
function moveDay(task,day){if(!day)return {date:'',dateEnd:''};const old=interval(task);if(old.allDay)return {date:day,dateEnd:''};return slot(day,minutes(old.start),old.duration);}
function segments(task,days){const item=interval(task);if(item.allDay)return [];const out=[];for(const day of days){const start=parse(day),next=clone(start);next.setDate(next.getDate()+1);if(item.start>=next||item.end<=start)continue;const a=item.start>start?item.start:start,b=item.end<next?item.end:next;out.push({task,day,start:a.getTime()===start.getTime()?0:minutes(a),end:b.getTime()===next.getTime()?1440:minutes(b),first:a.getTime()===item.start.getTime(),last:b.getTime()===item.end.getTime(),duration:item.duration});}return out;}
function layout(items){const sorted=items.map(x=>({...x})).sort((a,b)=>a.start-b.start||b.end-a.end);let active=[],group=[],groupEnd=-1;
const finish=()=>{const lanes=Math.max(1,...group.map(x=>x.lane+1));group.forEach(x=>x.lanes=lanes);group=[];};
for(const item of sorted){if(item.start>=groupEnd){finish();active=[];groupEnd=-1;}active=active.filter(x=>x.end>item.start);const used=new Set(active.map(x=>x.lane));let lane=0;while(used.has(lane))lane++;item.lane=lane;active.push(item);group.push(item);groupEnd=Math.max(groupEnd,item.end);}finish();return sorted;}
return {fromParts,clone,DEFAULT,STEP,MAX,key,parse,minutes,time,interval,slot,moveDay,segments,layout};});
