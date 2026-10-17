const test=require('node:test');
const assert=require('node:assert/strict');
const history=require('../task-history.js');

test('completed tasks are visible only inside the last seven days',()=>{
  const now=Date.parse('2026-10-17T12:00:00Z');
  assert.equal(history.visible({id:'recent',completed:true,completedAt:new Date(now-6*86400000).toISOString()},now),true);
  assert.equal(history.visible({id:'old',completed:true,completedAt:new Date(now-8*86400000).toISOString()},now),false);
  assert.equal(history.visible({id:'open',completed:false},now),true);
});

test('completed tasks fail closed when trusted network time is unavailable',()=>{
  const done={id:'done',completed:true,completedAt:'2026-10-17T11:00:00Z'};
  assert.equal(history.visible(done,NaN),false);
  assert.equal(history.visible({id:'open',completed:false},NaN),true);
});