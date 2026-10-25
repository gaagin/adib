const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const html = fs.readFileSync('ela-nov-paketleme-dynamic.html', 'utf8');
const css = fs.readFileSync('whatsapp-discussions.css', 'utf8');
const runtime = fs.readFileSync('realtime-runtime.js', 'utf8');

test('WhatsApp-style discussion stylesheet is loaded after existing view overrides', () => {
  assert.match(html, /whatsapp-discussions\.css\?v=1\.1\.68/);
  assert.match(html, /<link rel="stylesheet" href="\/whatsapp-discussions\.css\?v=1\.1\.68">\s*<\/body>/);
});

test('discussion layout has dark/light WhatsApp palettes and responsive mobile thread navigation', () => {
  assert.match(css, /html\.dark\{--wa-app:#0b141a/);
  assert.match(css, /html:not\(\.dark\)\{--wa-app:#efeae2/);
  assert.match(css, /\.adib-chat-bubble\.mine\{[^}]*var\(--wa-outgoing\)/);
  assert.match(css, /\.adib-chat-bubble\{[^}]*var\(--wa-incoming\)/);
  assert.match(css, /\.adib-chat-messages\{[^}]*var\(--wa-pattern\)/);
  assert.match(css, /#adibChatOverlay\.conversation-open \.adib-chat-conversation\{display:flex/);
  assert.match(css, /env\(safe-area-inset-bottom\)/);
});

test('conversation header shows participant context and attachment control stays beside composer', () => {
  assert.match(runtime, /function chatParticipantSummary\(/);
  assert.match(runtime, /escapeHtml\(chatParticipantSummary\(thread,currentUser\.name\)\)/);
  assert.match(runtime, /form\.prepend\(imagePicker\)/);
  assert.match(runtime, /adib-chat-open-task-label/);
});

test('chat wallpaper uses scattered doodles instead of a rigid grid', () => {
  assert.match(css, /--wa-pattern:url\("data:image\/svg\+xml/);
  assert.match(css, /conversation-open \.adib-discussion-fab\{display:none/);
});

test('opening a discussion shows the latest messages and preserves a user reading older messages', () => {
  assert.match(runtime, /follow=!oldMessages\|\|oldMessages\.scrollHeight-oldMessages\.scrollTop-oldMessages\.clientHeight<=64/);
  assert.match(runtime, /oldTask===thread\?\.taskId&&!follow\?oldY:messages\.scrollHeight/);
});
