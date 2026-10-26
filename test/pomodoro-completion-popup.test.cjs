'use strict';
const test=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const path=require('node:path');
const runtime=fs.readFileSync(path.join(__dirname,'..','realtime-runtime.js'),'utf8');
const html=fs.readFileSync(path.join(__dirname,'..','ela-nov-paketleme-dynamic.html'),'utf8');
test('completion popup resolves task title through the shared home bridge',()=>{const start=runtime.indexOf('function showPomodoroCompletionPopup');const end=runtime.indexOf('\n',start);assert.ok(start>=0&&end>start);const popup=runtime.slice(start,end);assert.ok(popup.includes('window.ADIBHomeBridge?.taskById?.(String(id))'));assert.ok(!popup.includes('pomodoroTaskById('));});
test('home bridge exposes task lookup inside its defining script scope',()=>{assert.ok(html.includes('window.ADIBHomeBridge={taskById:id=>pomodoroTaskById(String(id)),calendarCapabilities:'));assert.ok(html.includes('realtime-runtime.js?v=pomodoro-completion-task-lookup-v1'));});
