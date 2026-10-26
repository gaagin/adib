'use strict';
const test=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const path=require('node:path');
const T=require('./calendar-time.js');
const view=fs.readFileSync(path.join(__dirname,'calendar-view.js'),'utf8');
const css=fs.readFileSync(path.join(__dirname,'calendar-view.css'),'utf8');
const sessionCss=css.slice(css.lastIndexOf('/* Pomodoro cards follow')); 

test('close Pomodoro sessions are assigned separate lanes for their visible card height',()=>{
 const tasks=[
  {start:600,end:630,task:{id:'a',workSession:{id:'a'}}},
  {start:605,end:640,task:{id:'b',workSession:{id:'b'}}},
  {start:620,end:659,task:{id:'c',workSession:{id:'c'}}},
 ];
 const laidOut=T.layout(tasks,item=>item.task.workSession?10.5:0);
 assert.deepEqual(laidOut.map(item=>item.lane),[0,1,2]);
 assert.ok(laidOut.every(item=>item.lanes===3));
 assert.deepEqual(laidOut.map(item=>item.end),[630,640,659],'visual spacing must not change saved event times');
});

test('ordinary scheduled events retain the default true-time overlap behavior',()=>{
 const events=[{start:600,end:630,task:{}},{start:635,end:660,task:{}}];
 const laidOut=T.layout(events);
 assert.deepEqual(laidOut.map(item=>item.lane),[0,0]);
});

test('short session marks use a small visual collision allowance',()=>{
 const sessions=[{start:600,end:601,task:{workSession:{}}},{start:603,end:604,task:{workSession:{}}},{start:612,end:613,task:{workSession:{}}}];
 const laidOut=T.layout(sessions,item=>item.task.workSession?10.5:0);
 assert.deepEqual(laidOut.map(item=>item.lane),[0,1,0]);
 assert.deepEqual(laidOut.map(item=>item.end),[601,604,613]);
});

test('five-minute Pomodoro cards stay slim, keep their label, and hide the time range',()=>{
 assert.ok(view.includes("height=Math.max(isSession?14:24,(part.end-part.start)*HOUR/60)"));
 assert.ok(view.includes("node.classList.toggle('calendar-session-tiny',isSession&&height<20)"));
 assert.ok(view.includes('visualMinimum=part=>(part.task.workSession?14:24)*60/HOUR'));
 assert.ok(sessionCss.includes('#adibCalendar .calendar-time-event.calendar-session{min-height:14px!important'));
 assert.ok(sessionCss.includes('calendar-time-event.calendar-session-tiny .calendar-event-title{display:block!important'));
 assert.ok(sessionCss.includes('calendar-time-event.calendar-session-tiny .calendar-event-time'));
 assert.ok(sessionCss.includes('calendar-session-tiny .calendar-event-menu{display:none!important')); 
 assert.ok(sessionCss.includes('calendar-session-compact:not(.calendar-session-tiny) .calendar-event-time')&&sessionCss.includes('display:none!important'));
 assert.ok(!sessionCss.includes('min-height:64px!important'));
 assert.ok(!sessionCss.includes('min-height:88px!important'));
});
