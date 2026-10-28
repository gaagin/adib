const test=require('node:test'),assert=require('node:assert/strict'),fs=require('node:fs'),path=require('node:path'),vm=require('node:vm');
const source=fs.readFileSync(path.join(__dirname,'..','team-view.js'),'utf8');
const css=fs.readFileSync(path.join(__dirname,'..','team-view.css'),'utf8');
const helper=source.slice(source.indexOf('  function syncSharedNavigation()'),source.indexOf('  function show()'));
test('team uses existing navigation rather than creating a second footer',()=>{
 assert.doesNotMatch(source,/team-mobile-bottom|data-team-destination/);
 assert.match(css,/body\.adib-team-open \.adib-design-nav\{z-index:30001!important\}/);
 assert.match(source,/button\.dataset\.designNav !== 'team'/);
});
test('team content reserves actual shared bar height and responds to resizing',()=>{
 let height=67;const root={hidden:false,style:{},setAttribute(k,v){this[k]=v}};
 const context={root,document:{querySelector:()=>({getBoundingClientRect:()=>({height})})}};vm.createContext(context);vm.runInContext(helper,context);
 context.syncSharedNavigation();assert.equal(root.style.bottom,'67px');assert.equal(root['aria-modal'],'false');
 height=90;context.syncSharedNavigation();assert.equal(root.style.bottom,'90px');
 height=0;context.syncSharedNavigation();assert.equal(root.style.bottom,'0px');assert.equal(root['aria-modal'],'true');
 assert.match(source,/new ResizeObserver\(syncSharedNavigation\)/);
});
