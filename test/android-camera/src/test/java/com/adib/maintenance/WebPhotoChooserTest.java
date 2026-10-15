package com.adib.maintenance;
import android.app.*;
import android.content.*;
import android.net.Uri;
import android.os.Bundle;
import android.webkit.WebChromeClient.FileChooserParams;
import org.junit.*;
import org.junit.runner.RunWith;
import org.robolectric.*;
import org.robolectric.annotation.Config;
import org.robolectric.shadows.*;
import java.io.*;
import java.util.*;
import static org.junit.Assert.*;

@RunWith(RobolectricTestRunner.class) @Config(sdk=35,manifest=Config.NONE)
public class WebPhotoChooserTest {
 Activity activity;WebPhotoChooser picker;List<Uri[]> results;
 @Before public void setup(){activity=Robolectric.buildActivity(Activity.class).setup().get();picker=new WebPhotoChooser(activity,()->true);results=new ArrayList<>();}
 FileChooserParams params(boolean multiple){return new FileChooserParams(){public int getMode(){return multiple?MODE_OPEN_MULTIPLE:MODE_OPEN;}public String[] getAcceptTypes(){return new String[]{"image/jpeg,image/png,image/webp,image/gif"};}public boolean isCaptureEnabled(){return false;}public CharSequence getTitle(){return "";}public String getFilenameHint(){return "";}public Intent createIntent(){return new Intent(Intent.ACTION_GET_CONTENT).setType("image/*");}};}
 Intent clipped(ClipData clips){Intent intent=new Intent();intent.setClipData(clips);return intent;}
 void open(boolean multiple){assertTrue(picker.open(results::add,params(multiple)));}
 void choose(int n){AlertDialog d=ShadowAlertDialog.getLatestAlertDialog();assertEquals("Foto əlavə et",Shadows.shadowOf(d).getTitle().toString());d.getListView().performItemClick(null,n,n);}
 ShadowActivity.IntentForResult started(){return Shadows.shadowOf(activity).getNextStartedActivityForResult();}
 @Test public void cameraReturnsFullSizeOutputEvenWhenResultIntentIsNull()throws Exception {open(true);choose(0);ShadowActivity.IntentForResult request=started();assertEquals(WebPhotoChooser.TAKE_PHOTO,request.requestCode);assertEquals("android.media.action.IMAGE_CAPTURE",request.intent.getAction());Uri uri=request.intent.getParcelableExtra("output");assertEquals("content",uri.getScheme());assertTrue((request.intent.getFlags()&Intent.FLAG_GRANT_WRITE_URI_PERMISSION)!=0);assertNotNull(request.intent.getClipData());try(FileOutputStream out=new FileOutputStream(CameraPhotoProvider.file(activity,uri))){out.write(new byte[]{(byte)255,(byte)216,(byte)255,1});}picker.result(request.requestCode,Activity.RESULT_OK,null);assertEquals(1,results.size());assertEquals(uri,results.get(0)[0]);assertTrue(CameraPhotoProvider.file(activity,uri).isFile());picker.close();assertEquals(1,results.size());CameraPhotoProvider.discard(activity,uri);}
 @Test public void cancelledCameraDeletesTemporaryFileAndCompletesOnce()throws Exception {open(false);choose(0);ShadowActivity.IntentForResult request=started();Uri uri=request.intent.getParcelableExtra("output");File file=CameraPhotoProvider.file(activity,uri);picker.result(request.requestCode,Activity.RESULT_CANCELED,null);assertEquals(1,results.size());assertNull(results.get(0));assertFalse(file.exists());picker.result(request.requestCode,Activity.RESULT_OK,null);assertEquals(1,results.size());}
 @Test public void emptyCaptureIsNotAttached(){open(false);choose(0);ShadowActivity.IntentForResult request=started();picker.result(request.requestCode,Activity.RESULT_OK,null);assertEquals(1,results.size());assertNull(results.get(0));}
 @Test public void galleryPreservesMultipleSelection(){open(true);choose(1);ShadowActivity.IntentForResult request=started();assertEquals(Intent.ACTION_OPEN_DOCUMENT,request.intent.getAction());assertEquals("image/*",request.intent.getType());assertTrue(request.intent.getBooleanExtra(Intent.EXTRA_ALLOW_MULTIPLE,false));Uri a=Uri.parse("content://gallery/a"),b=Uri.parse("content://gallery/b");ClipData clips=ClipData.newUri(activity.getContentResolver(),"Photos",a);clips.addItem(new ClipData.Item(b));picker.result(request.requestCode,Activity.RESULT_OK,clipped(clips));assertArrayEquals(new Uri[]{a,b},results.get(0));}
 @Test public void singleSelectionAndUnsafePrivateUris(){open(false);choose(1);started();Uri a=Uri.parse("content://gallery/a");ClipData clips=ClipData.newRawUri("Photos",Uri.parse("file:///data/private"));clips.addItem(new ClipData.Item(Uri.parse("content://"+activity.getPackageName()+".camera/secret")));clips.addItem(new ClipData.Item(a));clips.addItem(new ClipData.Item(Uri.parse("content://gallery/b")));picker.result(WebPhotoChooser.PICK_FILE,Activity.RESULT_OK,clipped(clips));assertArrayEquals(new Uri[]{a},results.get(0));}
 @Test public void dialogCancelCompletesCallback(){open(false);ShadowAlertDialog.getLatestAlertDialog().cancel();Shadows.shadowOf(android.os.Looper.getMainLooper()).idle();assertEquals(1,results.size());assertNull(results.get(0));picker.close();assertEquals(1,results.size());}
 @Test public void navigationCancelsAndLateResultCannotReachAnotherInput(){open(false);choose(1);started();picker.close();List<Uri[]> next=new ArrayList<>();picker.open(next::add,params(false));assertEquals(1,next.size());assertNull(next.get(0));picker.result(WebPhotoChooser.PICK_FILE,Activity.RESULT_OK,new Intent().setData(Uri.parse("content://gallery/old")));assertEquals(1,results.size());assertEquals(1,next.size());picker.open(next::add,params(false));choose(1);started();picker.result(WebPhotoChooser.PICK_FILE,Activity.RESULT_CANCELED,null);assertEquals(2,next.size());}
 @Test public void untrustedPageCannotOpenPicker(){picker=new WebPhotoChooser(activity,()->false);open(false);assertEquals(1,results.size());assertNull(results.get(0));assertNull(started());}
 @Test public void lostActivityCallbackDiscardsPendingCapture()throws Exception {open(false);choose(0);ShadowActivity.IntentForResult request=started();Uri uri=request.intent.getParcelableExtra("output");File file=CameraPhotoProvider.file(activity,uri);Bundle state=new Bundle();picker.save(state);WebPhotoChooser replacement=new WebPhotoChooser(activity,()->true);replacement.restore(state);assertFalse(file.exists());replacement.result(request.requestCode,Activity.RESULT_OK,null);replacement.close();}
 @Test public void imageMimeRecognition(){assertTrue(WebPhotoChooser.isImageRequest(new String[]{"image/*"}));assertTrue(WebPhotoChooser.isImageRequest(new String[]{".jpg"}));assertFalse(WebPhotoChooser.isImageRequest(new String[]{"application/pdf"}));assertFalse(WebPhotoChooser.isImageRequest(null));}
}
