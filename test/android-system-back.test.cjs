const {test}=require('node:test'),assert=require('node:assert/strict'),fs=require('node:fs'),path=require('node:path'),vm=require('node:vm');
const root=path.join(__dirname,'..'),activity=fs.readFileSync(path.join(root,'android-patches/mobile-camera-1.1.6/OnlineMainActivity.java'),'utf8'),gradle=fs.readFileSync(path.join(root,'android-patches/mobile-camera-1.1.6/build.gradle'),'utf8'),readme=fs.readFileSync(path.join(root,'android-patches/mobile-camera-1.1.6/README-RU.txt'),'utf8');
test('Android system Back uses a modern callback and preserves keyboard-first behavior',()=>{
 assert.match(activity,/registerOnBackInvokedCallback\(OnBackInvokedDispatcher\.PRIORITY_DEFAULT,systemBackCallback\)/);
 assert.match(activity,/hideKeyboardForBack\(\)\)return/);
 assert.match(activity,/window\.__adibAndroidSystemBack\?window\.__adibAndroidSystemBack\(\):0/);
 assert.match(activity,/if\("1"\.equals\(result\)\)return;/);
 assert.match(activity,/if\("-1"\.equals\(result\)\)\{finish\(\);return;\}/);
 assert.match(activity,/if\(web!=null&&web\.canGoBack\(\)&&offline\.getVisibility\(\)!=View\.VISIBLE\)web\.goBack\(\);else finish\(\)/);
 assert.match(activity,/unregisterOnBackInvokedCallback\(systemBackCallback\)/);
});
test('Android web back closes top overlays, task properties, then internal app history',()=>{
 const i=activity.indexOf('window.__adibAndroidSystemBack=function'),end=activity.indexOf('function call(method)',i),handler=activity.slice(i,end);
 assert.ok(handler.indexOf("querySelectorAll(':popover-open')")<handler.indexOf("querySelectorAll('dialog[open]')"));
 assert.ok(handler.indexOf("querySelector('[data-chat-back]')")<handler.indexOf('history.back()'));
 assert.ok(handler.includes('window.setMobileMode'));
 assert.ok(handler.indexOf('window.__adibPersonalBack()')<handler.indexOf('history.back()'));
 assert.ok(handler.indexOf('window.__adibEquipmentBack()')<handler.indexOf('history.back()'));
 assert.ok(handler.includes('s.adibNavigation&&!s.adibRoot'));
 assert.ok(handler.includes('s.adibNavigation&&s.adibRoot'));
});
test('next Android patch increments installable APK version',()=>{assert.match(gradle,/versionCode 9/);assert.match(gradle,/versionName '1\.1\.7-system-back'/);assert.match(readme,/1\.1\.7/);assert.match(readme,/одного обновления онлайн-страницы недостаточно/)});

function executeBackHandler({state,canPersonal=false,canEquipment=false,dialog=null,personalMode=false}={}){
 const calls=[],hidden=id=>({hidden:true,setAttribute(){},classList:{contains:()=>false,remove(){}}});
 const elements={adibChatOverlay:hidden('chat'),adibSettingsMenu:hidden('settings'),personalMode:hidden('personal'),mobileSearchPanel:hidden('search'),taskFiltersPanel:hidden('filters'),adibSettingsButton:hidden('settingsButton')};elements.personalMode.hidden=!personalMode;
 const document={body:{classList:{contains:()=>false,remove(){}}},getElementById:id=>elements[id]||null,querySelector:()=>null,querySelectorAll:selector=>selector==='dialog[open]'&&dialog?[dialog]:[]};
 const window={__adibCanPersonalBack:()=>canPersonal,__adibPersonalBack:()=>{calls.push('personal');return true},__adibCanEquipmentBack:()=>canEquipment,__adibEquipmentBack:()=>{calls.push('equipment');return true}};
 const history={state,back:()=>calls.push('history')};
 const line=activity.split('\n').find(row=>row.includes('window.__adibAndroidSystemBack=function'));
 const literal=line.trim().slice(0,-1);
 const context={window,document,history,Event:class{constructor(type,options){this.type=type;this.cancelable=options.cancelable}},calls};
 vm.runInNewContext(JSON.parse(literal),context);
 return {result:window.__adibAndroidSystemBack(),calls};
}
test('Android Back handler closes dialogs and task editors before navigating, exits at app root',()=>{
 const dialog={requestClose(){this.closed=true}};
 assert.equal(executeBackHandler({state:{adibNavigation:true},dialog}).result,1);assert.equal(dialog.closed,true);
 assert.deepEqual(executeBackHandler({state:{adibNavigation:true},canEquipment:true}).calls,['equipment']);
 assert.deepEqual(executeBackHandler({state:{adibNavigation:true},canPersonal:true,personalMode:true}).calls,['personal']);
 const route=executeBackHandler({state:{adibNavigation:true,adibPlanId:'nested'}});assert.equal(route.result,1);assert.deepEqual(route.calls,['history']);
 assert.equal(executeBackHandler({state:{adibNavigation:true,adibRoot:true}}).result,-1);
});
