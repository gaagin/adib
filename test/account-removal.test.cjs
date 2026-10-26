const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { Accounts, defaults } = require('../accounts');

const root = path.join(__dirname, '..');
const serverPath = process.env.ADIB_SERVER_SOURCE || path.join(root, 'server.js');
const htmlPath = process.env.ADIB_ACCOUNT_HTML_SOURCE || path.join(root, 'account.html');

async function fixture() {
  const accounts = new Accounts({ file: null, enabled: true, adminLogin: 'owner', adminPassword: 'StrongAdminPassword123' });
  await accounts.ready;
  const admin = accounts.state.users[0];
  const adminSession = accounts.session(admin);
  const request = token => ({ method: 'DELETE', headers: { authorization: `Bearer ${token}` }, socket: { remoteAddress: 'test' } });
  return { accounts, admin, adminRequest: request(adminSession.token), request };
}

function employee(id = 'worker-id') {
  return { id, login: `worker-${id}`, name: 'Worker', password: 'unused', role: 'employee', disabled: false, revision: 1, rules: defaults('employee') };
}

test('admin removal revokes the account sessions and closes its live streams', async () => {
  const { accounts, adminRequest } = await fixture();
  const worker = employee();
  accounts.state.users.push(worker);
  const workerSession = accounts.session(worker);
  let streamEnded = false;
  let streamMessage = '';
  accounts.streams.add({ id: worker.id, response: { write: value => { streamMessage += value; }, end: () => { streamEnded = true; } } });

  const result = await accounts.route(adminRequest, '/api/admin/users', { id: worker.id });
  assert.equal(result.deleted, true);
  assert.equal(accounts.state.users.some(user => user.id === worker.id), false);
  assert.equal(accounts.state.sessions.some(session => session.userId === worker.id), false);
  assert.equal(streamEnded, true);
  assert.match(streamMessage, /access-changed/);
  await assert.rejects(accounts.route({ ...adminRequest, headers: { authorization: `Bearer ${workerSession.token}` } }, '/api/auth/me'), error => error.statusCode === 401);
});

test('an administrator cannot delete their own account; non-admins cannot remove accounts', async () => {
  const { accounts, admin, adminRequest, request } = await fixture();
  await assert.rejects(accounts.route(adminRequest, '/api/admin/users', { id: admin.id }), error => error.statusCode === 409);
  const worker = employee();
  accounts.state.users.push(worker);
  const workerSession = accounts.session(worker);
  await assert.rejects(accounts.route(request(workerSession.token), '/api/admin/users', { id: admin.id }), error => error.statusCode === 403);
});

test('the user list exposes a confirmed remove action and the API permits DELETE', () => {
  const server = fs.readFileSync(serverPath, 'utf8');
  const html = fs.readFileSync(htmlPath, 'utf8');
  assert.match(server, /'\/api\/admin\/users':\['GET','PATCH','DELETE'\]/);
  assert.match(html, /api\('\/api\/admin\/users','DELETE',\{id:target\.id\}\)/);
  assert.match(html, /deleteUserDialog/);
  assert.match(html, /showModal\(\)/);
  assert.doesNotMatch(html, /if\(!confirm\(/);
  assert.match(html, /if\(u\.id!==me\.id\)memberActions\.append\(remove\)/);
});
