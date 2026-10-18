'use strict';
const test=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const path=require('node:path');
const server=fs.readFileSync(path.join(__dirname,'..','server.js'),'utf8');
test('legacy Pomodoro completion is saved to the Notion journal',()=>{
 const start=server.indexOf('async function savePersonalPomodoroUnlocked(body)');
 const end=server.indexOf('async function aiChat(body)',start);
 assert.ok(start>=0&&end>start);
 const handler=server.slice(start,end);
 assert.match(handler,/completedSession=action==='finish'&&!global&&mode!=='break'/);
 assert.match(handler,/browserPomodoroSessions\.flushSessionLog\(completedSession\)/);
});
test('recent legacy completions are queued once for journal backfill',()=>{
 assert.match(server,/legacyPomodoroCutoff=Date\.now\(\)-7\*24\*60\*60\*1000/);
 assert.match(server,/legacyBackfill:true/);
 assert.match(server,/knownPomodoroSessionIds\.has\(timer\.sessionId\)/);
});
