'use strict';
const test=require('node:test');
const assert=require('node:assert/strict');
const {shouldOpenMyTasks,shouldUseCachedWorkspace}=require('../startup-view');

test('previously authenticated devices can open the cached workspace without waiting for navigation data',()=>{
 assert.equal(shouldUseCachedWorkspace('account-id:revision'),true);
 assert.equal(shouldUseCachedWorkspace(''),false);
 assert.equal(shouldUseCachedWorkspace(null),false);
 assert.equal(shouldOpenMyTasks('https://app.example/'),true);
 assert.equal(shouldOpenMyTasks('https://app.example/?id=task'),false);
});