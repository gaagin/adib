package com.adib.maintenance;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.ClipData;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.webkit.ValueCallback;
import android.webkit.WebChromeClient.FileChooserParams;
import android.widget.Toast;
import java.util.ArrayList;
import java.util.BitSet;
import java.util.function.BooleanSupplier;

/** One chooser for every image input in the online UI; no direct camera permission required. */
final class WebPhotoChooser {
    private static final int PICK_FILE=1, TAKE_PHOTO=2;
    private static final int REQUEST_FIRST=1024, REQUEST_LAST=65535;
    private final Activity activity;
    private final BooleanSupplier trustedPage;
    private final BitSet abandonedRequests=new BitSet(REQUEST_LAST+1);
    private ValueCallback<Uri[]> callback;
    private AlertDialog dialog;
    private Uri cameraUri;
    private boolean multiple;
    private int outstandingRequest;
    private int outstandingKind;
    private int nextRequestCode=REQUEST_FIRST;

    WebPhotoChooser(Activity activity, BooleanSupplier trustedPage) {
        this.activity=activity;this.trustedPage=trustedPage;
    }
    static boolean isImageRequest(String[] types) {
        if(types==null)return false;
        for(String type:types)if(type!=null)for(String part:type.split(",")) {
            String value=part.trim().toLowerCase(java.util.Locale.ROOT);
            if(value.startsWith("image/")||value.matches("\\.(jpe?g|png|webp|gif|heic|heif)"))return true;
        }
        return false;
    }
    boolean open(ValueCallback<Uri[]> next, FileChooserParams params) {
        // Never replace an outstanding OS request: its late result must not reach a different input.
        if(callback!=null||outstandingRequest!=0){next.onReceiveValue(null);say("Əvvəlcə açıq foto seçimini tamamlayın.");return true;}
        if(!trustedPage.getAsBoolean()){next.onReceiveValue(null);return true;}
        callback=next;multiple=params.getMode()==FileChooserParams.MODE_OPEN_MULTIPLE;
        if(isImageRequest(params.getAcceptTypes())) {
            dialog=new AlertDialog.Builder(activity).setTitle("Foto əlavə et")
                .setItems(new String[]{"Kamera ilə çək","Qalereyadan seç"},(d,which)->{
                    dialog=null;if(which==0)camera();else gallery();
                }).setNegativeButton("Ləğv et",(d,w)->finish(null))
                .setOnCancelListener(d->finish(null)).create();
            dialog.show();
        } else {
            int request=beginRequest(PICK_FILE);
            try{activity.startActivityForResult(params.createIntent(),request);}
            catch(Exception e){clearRequest(request);say("Fayl seçimini açmaq alınmadı.");finish(null);}
        }
        return true;
    }
    private void gallery() {
        int request=beginRequest(PICK_FILE);
        try {
            Intent intent=new Intent(Intent.ACTION_OPEN_DOCUMENT).addCategory(Intent.CATEGORY_OPENABLE)
                .setType("image/*").putExtra(Intent.EXTRA_ALLOW_MULTIPLE,multiple)
                .addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
            activity.startActivityForResult(intent,request);
        } catch(Exception e){clearRequest(request);say("Qalereyanı açmaq alınmadı.");finish(null);}
    }
    private void camera() {
        int request=0;
        try {
            cameraUri=CameraPhotoProvider.create(activity);
            request=beginRequest(TAKE_PHOTO);
            activity.startActivityForResult(CameraPhotoProvider.intent(activity,cameraUri),request);
        } catch(Exception e) {
            if(request!=0)clearRequest(request);
            discardCamera();say("Kameranı açmaq alınmadı. Qalereyadan foto seçə bilərsiniz.");finish(null);
        }
    }
    private int beginRequest(int kind) {
        int available=REQUEST_LAST-REQUEST_FIRST+1;
        for(int i=0;i<available;i++) {
            int candidate=nextRequestCode;
            nextRequestCode=candidate>=REQUEST_LAST?REQUEST_FIRST:candidate+1;
            if(candidate!=outstandingRequest&&!abandonedRequests.get(candidate)) {
                outstandingRequest=candidate;outstandingKind=kind;return candidate;
            }
        }
        throw new IllegalStateException("No free file chooser request code");
    }
    private void clearRequest(int request) {
        if(outstandingRequest==request){outstandingRequest=0;outstandingKind=0;}
    }
    private void abandonRequest() {
        if(outstandingRequest!=0)abandonedRequests.set(outstandingRequest);
        outstandingRequest=0;outstandingKind=0;
    }
    boolean result(int request,int result,Intent data) {
        if(abandonedRequests.get(request)){abandonedRequests.clear(request);return true;}
        if(outstandingRequest!=request)return false;
        int kind=outstandingKind;
        outstandingRequest=0;outstandingKind=0;
        if(kind==TAKE_PHOTO) {
            Uri uri=cameraUri;cameraUri=null;
            if(result!=Activity.RESULT_OK||uri==null||callback==null||!trustedPage.getAsBoolean()) {
                CameraPhotoProvider.discard(activity,uri);finish(null);return true;
            }
            try {
                if(CameraPhotoProvider.file(activity,uri).length()==0)throw new java.io.IOException();
                // Revoke external camera access, but keep the JPEG for WebView's asynchronous read.
                activity.revokeUriPermission(uri,Intent.FLAG_GRANT_READ_URI_PERMISSION|Intent.FLAG_GRANT_WRITE_URI_PERMISSION);
                finish(new Uri[]{uri});
            } catch(Exception e){CameraPhotoProvider.discard(activity,uri);say("Kamera fotonu saxlamadı. Yenidən cəhd edin.");finish(null);}
        } else if(kind==PICK_FILE) {
            ArrayList<Uri> uris=new ArrayList<>();
            if(result==Activity.RESULT_OK&&data!=null&&trustedPage.getAsBoolean()) {
                ClipData clips=data.getClipData();
                if(clips!=null){for(int i=0;i<clips.getItemCount()&&(multiple||uris.isEmpty());i++)addUri(uris,clips.getItemAt(i).getUri());}
                else addUri(uris,data.getData());
            }
            finish(uris.isEmpty()?null:uris.toArray(new Uri[0]));
        } else return false;
        return true;
    }
    private void addUri(ArrayList<Uri> list,Uri uri) {
        // A document provider cannot redirect the chooser to private ADIB files.
        if(uri!=null&&"content".equals(uri.getScheme())&&uri.getAuthority()!=null
            &&!uri.getAuthority().startsWith(activity.getPackageName())&&!list.contains(uri))list.add(uri);
    }
    private void finish(Uri[] uris) {
        ValueCallback<Uri[]> target=callback;callback=null;
        if(dialog!=null){dialog.dismiss();dialog=null;}
        if(target!=null)target.onReceiveValue(uris);
    }
    void save(Bundle state){state.putInt("adib_photo_request",outstandingRequest);state.putInt("adib_photo_next_request",nextRequestCode);state.putByteArray("adib_abandoned_photo_requests",abandonedRequests.toByteArray());if(cameraUri!=null)state.putString("adib_pending_camera",cameraUri.toString());}
    void restore(Bundle state){if(state!=null){byte[] abandoned=state.getByteArray("adib_abandoned_photo_requests");if(abandoned!=null)abandonedRequests.or(BitSet.valueOf(abandoned));int pending=state.getInt("adib_photo_request",0);if(pending>0)abandonedRequests.set(pending);nextRequestCode=state.getInt("adib_photo_next_request",REQUEST_FIRST);String value=state.getString("adib_pending_camera");if(value!=null)CameraPhotoProvider.discard(activity,Uri.parse(value));}}
    void close(){abandonRequest();discardCamera();finish(null);}
    private void discardCamera(){CameraPhotoProvider.discard(activity,cameraUri);cameraUri=null;}
    private void say(String text){Toast.makeText(activity,text,Toast.LENGTH_LONG).show();}
}
