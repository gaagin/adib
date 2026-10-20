const {test}=require('node:test');
const assert=require('node:assert/strict');
const fs=require('node:fs');
const path=require('node:path');

const overlay=fs.readFileSync(path.join(__dirname,'../android-patches/mobile-work-confirmation-1.1.5/AdibWorkTimerOverlayService.java'),'utf8');
const overlay116=fs.readFileSync(path.join(__dirname,'../android-patches/mobile-work-confirmation-1.1.6/AdibWorkTimerOverlayService.java'),'utf8');

test('native work-time confirmation patch offers an explicit cancel action',()=>{
 assert.match(overlay,/cancelButton=actionButton\("Ləğv et"\)/);
 assert.match(overlay,/cancelButton\.setOnClickListener\(v->cancelConfirmedTime\(\)\)/);
 assert.match(overlay,/cancelParams\.setMargins\(0,0,dp\(8\),0\)/);
 assert.match(overlay116,/cancelButton=actionButton\("Ləğv et"\)/);
 assert.match(overlay116,/cancelButton\.setOnClickListener\(v->cancelConfirmedTime\(\)\)/);
});

test('native timer cancellation is acknowledged by the server before clearing the pending session',()=>{
 const start=overlay.indexOf('private void cancelConfirmedTime()');
 const end=overlay.indexOf('private void showConfirmationError',start);
 assert.notEqual(start,-1);
 assert.notEqual(end,-1);
 const cancel=overlay.slice(start,end);
 assert.match(cancel,/put\("action","cancel"\)/);
 assert.match(cancel,/put\("sessionId",sid\)/);
 assert.match(cancel,/put\("revision",rev\)/);
 assert.match(cancel,/put\("operationId",operationId\)/);
 assert.match(cancel,/!"saved"\.equals\(session\.optString\("status"\)\)/);
 assert.match(cancel,/!"cancelled"\.equals\(session\.optString\("completionReason"\)\)/);
 assert.ok(cancel.indexOf('completionReason')<cancel.indexOf('.remove(PENDING_KEY)'));
 assert.match(cancel,/catch\(Exception e\).*?showConfirmationError\("Ləğv etmək alınmadı:/s);
});