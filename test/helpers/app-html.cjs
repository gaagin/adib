const fs=require('node:fs');
const path=require('node:path');

const root=path.join(__dirname,'../..');

function appHtml(){
  const html=fs.readFileSync(path.join(root,'ela-nov-paketleme-dynamic.html'),'utf8');
  const runtime=fs.readFileSync(path.join(root,'realtime-runtime.js'),'utf8');
  const marker=/<script src="\/realtime-runtime\.js(?:\?[^"]*)?"><\/script>/;
  if(!marker.test(html))throw new Error('Realtime runtime script tag is missing');
  return html.replace(marker,`<script>${runtime}</script>`);
}

module.exports={appHtml};