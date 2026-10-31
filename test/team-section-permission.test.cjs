'use strict';
const test=require('node:test'),assert=require('node:assert/strict'),fs=require('fs'),vm=require('vm');
const {Accounts,rules,defaults,SECTIONS}=require('../accounts');
test('team is explicit, persisted and not granted to employees by default',async()=>{
 assert(SECTIONS.includes('team'));assert.deepEqual(rules({sections:['team','untrusted']}).sections,['team']);assert(!defaults('employee').sections.includes('team'));assert(defaults('manager').sections.includes('team'));
 const a=new Accounts();await a.ready;
 const u={id:'e',role:'employee',rules:rules({sections:['team']})};assert(a.section(u,'team'));assert(!a.section({...u,rules:rules()},'team'));assert(a.section({role:'admin'},'team'));
 // Team access never grants other task/container/plan permissions.
 assert(!a.task(u,{id:'t',containerId:'x'},'personal'));assert(!a.task(u,{id:'t',planId:'p'},'equipment'));
 const admin={id:'a',name:'Admin',role:'admin',rules:defaults('manager')};a.state.users=[admin,u];const session=a.session(admin),req={method:'PATCH',headers:{authorization:'Bearer '+session.token}};
 await a.route(req,'/api/admin/users',{id:'e',name:'Employee',role:'employee',rules:{sections:['team'],actions:[]}});assert(a.state.users.find(x=>x.id==='e').rules.sections.includes('team'));
 await a.route(req,'/api/admin/users',{id:'e',name:'Employee',role:'employee',rules:{sections:[],actions:[]}});assert(!a.state.users.find(x=>x.id==='e').rules.sections.includes('team'));
});
test('actual server team route uses section permission, not manager role',async()=>{
 const a=new Accounts();await a.ready;
 const {accountAuthorize}=require('../server-access')({accounts:a,accessError:(message,statusCode)=>Object.assign(Error(message),{statusCode})});
 const user=sections=>({role:'employee',rules:rules({sections})});
 const request={method:'GET'};
 await accountAuthorize(request,{},new URL('http://local/api/team-snapshot'),user(['team']),{});
 await assert.rejects(accountAuthorize(request,{},new URL('http://local/api/team-snapshot'),user([]),{}));
 await assert.rejects(accountAuthorize({method:'POST'},{},new URL('http://local/api/team-snapshot'),user(['team']),{}));

});
