package com.adib.maintenance;

import android.widget.EditText;
import android.widget.LinearLayout;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.robolectric.Robolectric;
import org.robolectric.RobolectricTestRunner;
import org.robolectric.annotation.Config;
import static org.junit.Assert.*;

@RunWith(RobolectricTestRunner.class)
@Config(sdk={28,35})
public class NotionTaskDatePickerTest {
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
}
