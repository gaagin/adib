'use strict';
const test=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const html=fs.readFileSync(require('node:path').join(__dirname,'..','account.html'),'utf8');
const match=html.match(/function normalizeInviteCode\(value\)\{[^\n]+\}/);
assert.ok(match,'invite normalization helper should exist');
const normalizeInviteCode=new Function(`${match[0]}; return normalizeInviteCode;`)();
test('extracts invite token when user pastes a full account invitation URL',()=>{
 assert.equal(normalizeInviteCode('https://adib-production-eba3.up.railway.app/account.html#invite=abc_DEF-123'),'abc_DEF-123');
});
test('leaves a plain invitation token unchanged',()=>{
 assert.equal(normalizeInviteCode('abc_DEF-123'),'abc_DEF-123');
});
test('extracts a URL-encoded invitation token',()=>{
 assert.equal(normalizeInviteCode('https://example.test/account.html#invite=abc%5FDEF'),'abc_DEF');
});
