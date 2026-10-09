(function(root,factory){const api=factory();if(typeof module==='object'&&module.exports)module.exports=api;else root.ADIBZone=api;})(typeof globalThis==='object'?globalThis:this,function(){'use strict';
const cache=new Map();function formatter(zone){if(!cache.has(zone))cache.set(zone,new Intl.DateTimeFormat('en-CA',{timeZone:zone,year:'numeric',month:'2-digit',day:'2-digit',hour:'2-digit',minute:'2-digit',second:'2-digit',hourCycle:'h23'}));return cache.get(zone);}
function parts(epoch,zone){if(!Number.isFinite(epoch))return {year:NaN,month:NaN,day:NaN,hour:NaN,minute:NaN,second:NaN,millisecond:NaN};const p=Object.fromEntries(formatter(zone).formatToParts(new Date(epoch)).filter(x=>x.type!=='literal').map(x=>[x.type,Number(x.value)]));return {year:p.year,month:p.month-1,day:p.day,hour:p.hour,minute:p.minute,second:p.second,millisecond:new Date(epoch).getUTCMilliseconds()};}
function wallEpoch(p,zone){const wanted=Date.UTC(p.year,p.month,p.day,p.hour||0,p.minute||0,p.second||0,p.millisecond||0);let guess=wanted;for(let i=0;i<4;i++){const q=parts(guess,zone),actual=Date.UTC(q.year,q.month,q.day,q.hour,q.minute,q.second,q.millisecond);const delta=wanted-actual;if(!delta)break;guess+=delta;}return guess;}
class ZonedDate extends Date{
 constructor(epoch=NaN,zone='Asia/Baku'){super(epoch);this.zone=zone;}
 _p(){return parts(this.getTime(),this.zone);}
 getFullYear(){return this._p().year;}getMonth(){return this._p().month;}getDate(){return this._p().day;}getHours(){return this._p().hour;}getMinutes(){return this._p().minute;}getSeconds(){return this._p().second;}getMilliseconds(){return this._p().millisecond;}
 getDay(){const p=this._p();return new Date(Date.UTC(p.year,p.month,p.day)).getUTCDay();}
 getTimezoneOffset(){const p=this._p();return (this.getTime()-Date.UTC(p.year,p.month,p.day,p.hour,p.minute,p.second,p.millisecond))/60000;}
 _set(kind,args){const p=this._p();if(!Number.isFinite(p.year))return this.setTime(NaN);const d=new Date(Date.UTC(p.year,p.month,p.day,p.hour,p.minute,p.second,p.millisecond));d['setUTC'+kind](...args);return this.setTime(wallEpoch({year:d.getUTCFullYear(),month:d.getUTCMonth(),day:d.getUTCDate(),hour:d.getUTCHours(),minute:d.getUTCMinutes(),second:d.getUTCSeconds(),millisecond:d.getUTCMilliseconds()},this.zone));}
 setFullYear(...a){return this._set('FullYear',a);}setMonth(...a){return this._set('Month',a);}setDate(...a){return this._set('Date',a);}setHours(...a){return this._set('Hours',a);}setMinutes(...a){return this._set('Minutes',a);}setSeconds(...a){return this._set('Seconds',a);}setMilliseconds(...a){return this._set('Milliseconds',a);}
 toLocaleDateString(locale='ru-RU',options={}){return Number.isFinite(this.getTime())?new Date(this.getTime()).toLocaleDateString(locale,{...options,timeZone:this.zone}):'Время не подтверждено';}
 toLocaleTimeString(locale='ru-RU',options={}){return Number.isFinite(this.getTime())?new Date(this.getTime()).toLocaleTimeString(locale,{...options,timeZone:this.zone}):'Время не подтверждено';}
 toLocaleString(locale='ru-RU',options={}){return Number.isFinite(this.getTime())?new Date(this.getTime()).toLocaleString(locale,{...options,timeZone:this.zone}):'Время не подтверждено';}
 toDateString(){const p=this._p();return Number.isFinite(p.year)?[p.year,p.month+1,p.day].join('-'):'unconfirmed';}
 clone(){return new ZonedDate(this.getTime(),this.zone);}
}
function fromParts(year,month,day=1,hour=0,minute=0,second=0,millisecond=0,zone='Asia/Baku'){const d=new Date(Date.UTC(year,month,day,hour,minute,second,millisecond));return new ZonedDate(wallEpoch({year:d.getUTCFullYear(),month:d.getUTCMonth(),day:d.getUTCDate(),hour:d.getUTCHours(),minute:d.getUTCMinutes(),second:d.getUTCSeconds(),millisecond:d.getUTCMilliseconds()},zone),zone);}
function parse(value,zone='Asia/Baku'){if(!value)return null;const s=String(value),m=/^(\d{4})-(\d{2})-(\d{2})(?:T(\d{2}):(\d{2})(?::(\d{2})(?:\.(\d{1,3}))?)?)?$/.exec(s);const d=m?fromParts(+m[1],+m[2]-1,+m[3],+(m[4]||0),+(m[5]||0),+(m[6]||0),Number((m[7]||'0').padEnd(3,'0')),zone):new ZonedDate(Date.parse(s),zone);return Number.isFinite(d.getTime())?d:null;}
return {ZonedDate,fromParts,parse,parts,wallEpoch};});
