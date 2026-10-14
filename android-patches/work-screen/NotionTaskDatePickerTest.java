package com.adib.maintenance;

import android.widget.EditText;
import android.widget.LinearLayout;
import org.junit.Test;
import org.junit.Before;
import org.junit.After;
import android.app.AlertDialog;
import android.widget.CheckBox;
import org.robolectric.shadows.ShadowAlertDialog;
import java.util.TimeZone;
import org.junit.runner.RunWith;
import org.robolectric.Robolectric;
import org.robolectric.RobolectricTestRunner;
import org.robolectric.annotation.Config;
import static org.junit.Assert.*;

@RunWith(RobolectricTestRunner.class)
@Config(sdk={28,35})
public class NotionTaskDatePickerTest {
 TimeZone original;
 @Before public void zone(){original=TimeZone.getDefault();TimeZone.setDefault(TimeZone.getTimeZone("Asia/Baku"));}
 @After public void restore(){TimeZone.setDefault(original);}
 @Test public void keepsDateAndRangeValuesSeparateFromLocalizedDisplay(){
  MainActivity activity=Robolectric.buildActivity(MainActivity.class).get();
  LinearLayout form=new LinearLayout(activity);
  EditText field=NotionTaskDatePicker.add(activity,form,"Tarix və vaxt","2026-10-13T09:00:00+04:00","2026-10-13T10:30:00+04:00",false);
  assertEquals("2026-10-13T09:00",NotionTaskDatePicker.start(field));
  assertEquals("2026-10-13T10:30",NotionTaskDatePicker.end(field));
  assertTrue(field.getText().toString().contains("09:00"));
  assertTrue(field.getText().toString().contains("10:30"));
 }
 @Test public void blankAndDateOnlyValuesRemainValid(){
  MainActivity activity=Robolectric.buildActivity(MainActivity.class).get();
  EditText blank=NotionTaskDatePicker.add(activity,new LinearLayout(activity),"Tarix və vaxt","","",false);
  EditText day=NotionTaskDatePicker.add(activity,new LinearLayout(activity),"Tarix və vaxt","2026-10-13","",false);
  assertEquals("",NotionTaskDatePicker.start(blank));assertEquals("",NotionTaskDatePicker.end(blank));
  assertEquals("2026-10-13",NotionTaskDatePicker.start(day));assertEquals("",NotionTaskDatePicker.end(day));
 }
 @Test public void applyingDraftCommitsTimeAndEndDate(){
  MainActivity a=Robolectric.buildActivity(MainActivity.class).get();EditText field=NotionTaskDatePicker.add(a,new LinearLayout(a),"Tarix və vaxt","2026-10-13","",false);field.performClick();org.robolectric.Shadows.shadowOf(android.os.Looper.getMainLooper()).idle();AlertDialog d=ShadowAlertDialog.getLatestAlertDialog();((CheckBox)d.getWindow().getDecorView().findViewWithTag("notion-date-include-time")).setChecked(true);((CheckBox)d.getWindow().getDecorView().findViewWithTag("notion-date-has-end")).setChecked(true);d.getButton(AlertDialog.BUTTON_POSITIVE).performClick();assertEquals("2026-10-13T09:00",NotionTaskDatePicker.start(field));assertEquals("2026-10-13T09:00",NotionTaskDatePicker.end(field));assertFalse(d.isShowing());
 }
 @Test public void cancellingDraftDoesNotChangeValues(){MainActivity a=Robolectric.buildActivity(MainActivity.class).get();EditText field=NotionTaskDatePicker.add(a,new LinearLayout(a),"Tarix və vaxt","2026-10-13","",true);field.performClick();org.robolectric.Shadows.shadowOf(android.os.Looper.getMainLooper()).idle();AlertDialog d=ShadowAlertDialog.getLatestAlertDialog();((CheckBox)d.getWindow().getDecorView().findViewWithTag("notion-date-include-time")).setChecked(true);d.getButton(AlertDialog.BUTTON_NEGATIVE).performClick();assertEquals("2026-10-13",NotionTaskDatePicker.start(field));}
 @Test public void convertsAnInstantIntoLocalWallTime(){MainActivity a=Robolectric.buildActivity(MainActivity.class).get();EditText field=NotionTaskDatePicker.add(a,new LinearLayout(a),"Tarix və vaxt","2026-10-13T05:00:00Z","",false);assertEquals("2026-10-13T09:00",NotionTaskDatePicker.start(field));}

}
