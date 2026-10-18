'use strict';
const test=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const path=require('node:path');
const server=fs.readFileSync(path.join(__dirname,'..','server.js'),'utf8');
test('legacy Pomodoro finish journals the completed task session',()=>{
 const start=server.indexOf('async function savePersonalPomodoroUnlocked(body)');
 const end=server.indexOf('async function aiChat(body)',start);
 assert.ok(start>=0&&end>start,'legacy Pomodoro handler is present');
 const handler=server.slice(start,end);
 assert.match(handler,/completedSession=action==='finish'&&!global&&mode!=='break'/);
 assert.match(handler,/notionLogEligible:true/);
 assert.match(handler,/sharedPomodoro\.commit\(savedTimer,completedSession,null\)/);
 assert.match(handler,/browserPomodoroSessions\.flushSessionLog\(completedSession\)/);
});
