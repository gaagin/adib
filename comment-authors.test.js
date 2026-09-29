const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const vm = require('node:vm');
const source = fs.readFileSync(__dirname + '/server.js', 'utf8');
function helpers(lookup) {
  const code = source.slice(source.indexOf('function commentText('), source.indexOf('async function listTaskComments('));
  const context = vm.createContext({ notion: lookup, console: { warn() {} } });
  vm.runInContext(code, context);
  return context;
}
function comment(text, author = { id: 'person-1', type: 'person' }) {
  return { id: 'comment-1', created_by: author, created_time: '2026-01-01T10:00:00Z', rich_text: [{ plain_text: text }] };
}
test('native Notion comment resolves the actual user name and keeps text', async () => {
  const api = helpers(async endpoint => { assert.equal(endpoint, '/users/person-1'); return { name: 'Али Мамедов' }; });
  const result = await api.resolveCommentAuthor(comment('Проверил оборудование'));
  assert.equal(result.authorName, 'Али Мамедов');
  assert.equal(result.text, 'Проверил оборудование');
});
test('native bracketed text is not interpreted as another author', async () => {
  const api = helpers(async () => ({ name: 'Али' }));
  const result = await api.resolveCommentAuthor(comment('[Важно] Проверить насос'));
  assert.equal(result.authorName, 'Али');
  assert.equal(result.text, '[Важно] Проверить насос');
});
test('service sender is preserved rather than overwritten with bot name', async () => {
  const api = helpers(async () => { throw new Error('Should not look up bot'); });
  const result = await api.resolveCommentAuthor(comment('[ilqar mamedov] Готово', { id: 'bot-1', type: 'bot' }));
  assert.equal(result.authorName, 'ilqar mamedov');
  assert.equal(result.text, 'Готово');
});
test('embedded Notion user name is retained without another request', async () => {
  const api = helpers(async () => { throw new Error('Should not look up'); });
  assert.equal((await api.resolveCommentAuthor(comment('Текст', { id: 'person-1', type: 'person', name: 'Лейла' }))).authorName, 'Лейла');
});
test('Notion display name is fallback when user lookup is unavailable', async () => {
  const api = helpers(async () => { throw new Error('403'); });
  const item = comment('Текст'); item.display_name = { resolved_name: 'Лейла' };
  assert.equal((await api.resolveCommentAuthor(item)).authorName, 'Лейла');
});
test('unknown author uses neutral fallback, not a fabricated user or email', async () => {
  const api = helpers(async () => ({ person: { email: 'private@example.test' } }));
  assert.equal((await api.resolveCommentAuthor(comment('Текст'))).authorName, 'Пользователь Notion');
});
test('multi-part rich text and line breaks are preserved', async () => {
  const api = helpers(async () => ({ name: 'Али' }));
  const item = comment(''); item.rich_text = [{ plain_text: 'Строка 1\n' }, { text: { content: 'Строка 2' } }];
  assert.equal((await api.resolveCommentAuthor(item)).text, 'Строка 1\nСтрока 2');
});
