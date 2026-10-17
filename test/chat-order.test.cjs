const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const vm = require('node:vm');
const path = require('node:path');

const html = fs.readFileSync(path.join(__dirname, '..', 'ela-nov-paketleme-dynamic.html'), 'utf8');
const line = prefix => {
  const result = html.split(/\r?\n/).find(value => value.startsWith(prefix));
  assert.ok(result, `missing ${prefix}`);
  return result;
};

test('chat messages sort oldest first and keep the original list untouched', () => {
  const context = vm.createContext({ chatDate: value => value ? new Date(value) : null });
  vm.runInContext(line('function chatCompareDates(') + '\n' + line('function chatSortedComments('), context);
  const input = [
    { id: 'new', createdAt: '2026-10-18T18:26:00+04:00' },
    { id: 'middle', createdAt: '2026-10-18T00:58:00+04:00' },
    { id: 'old', createdAt: '2026-10-12T18:26:00+04:00' },
  ];
  const ordered = Array.from(context.chatSortedComments(input), item => item.id);
  assert.deepEqual(ordered, ['old', 'middle', 'new']);
  assert.deepEqual(input.map(item => item.id), ['new', 'middle', 'old']);
});

test('the chat bubble renderer applies chronological ordering', () => {
  assert.match(line('function chatBubbles('), /comments=chatSortedComments\(comments\)/);
});

test('task discussions sort newest activity first, independent of cache order', () => {
  const context = vm.createContext({ chatDate: value => value ? new Date(value) : null });
  vm.runInContext([
    line('function chatCompareDates('),
    line('function chatSortedComments('),
    line('function chatThreadLastComment('),
    line('function chatSortedThreads('),
  ].join('\n'), context);
  const input = [
    { id: 'old', comments: [
      { createdAt: '2023-02-22T10:00:00Z' },
      { createdAt: '2023-04-27T10:00:00Z' },
    ] },
    { id: 'newest', comments: [{ createdAt: '2026-09-09T10:00:00Z' }] },
    { id: 'middle', comments: [{ createdAt: '2024-11-08T10:00:00Z' }] },
  ];
  assert.deepEqual(Array.from(context.chatSortedThreads(input), item => item.id), ['newest', 'middle', 'old']);
  assert.deepEqual(input.map(item => item.id), ['old', 'newest', 'middle']);
});

test('discussion list uses latest message date and latest-message preview', () => {
  assert.match(html, /const discussionThreads=chatSortedThreads\(chatThreads\.filter/);
  assert.match(html, /last=chatThreadLastComment\(item\)/);
});
