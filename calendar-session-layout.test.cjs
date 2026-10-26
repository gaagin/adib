'use strict';
const test=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const path=require('node:path');
const T=require('./calendar-time.js');
const view=fs.readFileSync(path.join(__dirname,'calendar-view.js'),'utf8');
const css=fs.readFileSync(path.join(__dirname,'calendar-view.css'),'utf8');

test('close Pomodoro sessions are assigned separate lanes for their visible card height',()=>{
 const tasks=[
  {start:600,end:630,task:{id:'a',workSession:{id:'a'}}},
  {start:605,end:640,task:{id:'b',workSession:{id:'b'}}},
  {start:620,end:659,task:{id:'c',workSession:{id:'c'}}},
 ];
 const laidOut=T.layout(tasks,item=>item.task.workSession?48:0);
 assert.deepEqual(laidOut.map(item=>item.lane),[0,1,2]);
 assert.ok(laidOut.every(item=>item.lanes===3));
 assert.deepEqual(laidOut.map(item=>item.end),[630,640,659],'visual spacing must not change saved event times');
});

test('ordinary scheduled events retain the default true-time overlap behavior',()=>{
 const events=[{start:600,end:630,task:{}},{start:635,end:660,task:{}}];
 const laidOut=T.layout(events);
 assert.deepEqual(laidOut.map(item=>item.lane),[0,0]);
});

test('calendar uses matching visual collision padding and wraps session names with visible time ranges',()=>{
 assert.ok(view.includes("visualMinimum=part=>{const height=part.task.workSession?(root.matchMedia?.('(max-width:700px)').matches?88:64):24;"));
 assert.ok(view.includes('T.layout(segments,visualMinimum)'));
 assert.ok(css.includes('#adibCalendar .calendar-time-event.calendar-session{min-height:64px!important'));
 assert.ok(css.includes('white-space:normal!important'));
 assert.ok(css.includes('calendar-session.calendar-short .calendar-event-time{display:block!important'));
 assert.ok(css.includes('min-height:88px!important'));
});
