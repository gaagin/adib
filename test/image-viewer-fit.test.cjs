'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const root = path.join(__dirname, '..');
const viewer = fs.readFileSync(path.join(root, 'images.js'), 'utf8');
const html = fs.readFileSync(path.join(root, 'ela-nov-paketleme-dynamic.html'), 'utf8');

test('full-size image is contained within the viewer instead of cropped by global image styles', () => {
  assert.match(
    viewer,
    /\.adib-photo-viewport>img\{[^}]*width:100%!important;height:100%!important;max-width:none!important;max-height:none!important;object-fit:contain!important/,
  );
  assert.match(viewer, /fit=Math\.min\(rect\.width\/naturalWidth,rect\.height\/naturalHeight\)/);
});

test('page uses a refreshed image-viewer asset key', () => {
  assert.match(html, /images\.js\?v=1\.1\.68-photo-fit-v1/);
});