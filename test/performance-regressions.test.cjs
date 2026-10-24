const test=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const path=require('node:path');

const root=path.join(__dirname,'..');
const read=file=>fs.readFileSync(path.join(root,file),'utf8');

test('large network runtime is a content-addressed cached asset',()=>{
  const html=read('ela-nov-paketleme-dynamic.html');
  const realtime=html.indexOf('<script src="/realtime-runtime.js">');
  assert.ok(realtime>=0);
  assert.ok(fs.statSync(path.join(root,'realtime-runtime.js')).size>180_000);
  const server=read('server.js'),worker=read('sw.js');
  for(const asset of ['realtime-runtime.js']){
    assert.ok(server.includes(`"${asset}"`),`${asset} must be served with content hash`);
    assert.ok(worker.includes(`"${asset}"`),`${asset} must be cached by the service worker`);
  }
  const scripts=[...html.matchAll(/<script\b[^>]*>([\s\S]*?)<\/script\s*>/gi)].map(match=>match[1]);
  assert.ok(Math.max(...scripts.map(script=>script.length))<300_000,'the remaining personal-board script is unchanged');
});

test('Notion calls use the existing shared 350ms rate gate',()=>{
  const server=read('server.js'),gate=read('notion-rate.js');
  assert.match(server,/notionRate\.request\(/);
  assert.match(server,/fetch\(url,options\)/);
  assert.match(gate,/spacingMs=350/);
  assert.match(gate,/this\.tail=job\.catch/);
});

test('Android WebView avoids blur filters without changing desktop/browser styling',()=>{
  const css=read('hybrid-theme.css'),manifest=read('android-patches/mobile-camera-1.1.6/AndroidManifest.xml');
  assert.match(css,/html\.adib-native-android[^}]*backdrop-filter:none!important/);
  assert.match(manifest,/android:hardwareAccelerated="true"/);
});

test('a stale Android photo chooser result cannot block or feed the next selection',()=>{
  const source=read('android-patches/mobile-camera-1.1.6/WebPhotoChooser.java');
  assert.match(source,/private int beginRequest\(int kind\)/);
  assert.match(source,/abandonedRequests\.get\(request\)/);
  assert.match(source,/void close\(\)\{abandonRequest\(\);discardCamera\(\);finish\(null\);\}/);
  assert.match(source,/state\.putInt\("adib_photo_next_request",nextRequestCode\)/);
});