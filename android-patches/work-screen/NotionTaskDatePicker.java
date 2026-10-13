package com.adib.maintenance;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.DatePickerDialog;
import android.app.TimePickerDialog;
import android.graphics.Color;
import android.view.Gravity;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

/** Unified, theme-aware Notion-style date/time range selector for every task form. */
final class NotionTaskDatePicker {
    private static final class Range { String start="", end=""; boolean includeTime; }
    private NotionTaskDatePicker() {}

    static EditText add(Activity activity, LinearLayout form, String label, String start, String end, boolean dark) {
        TextView heading=new TextView(activity);heading.setText(label);heading.setTextSize(13);heading.setTextColor(HybridUi.text(dark));heading.setPadding(0,dp(activity,10),0,dp(activity,4));form.addView(heading);
        Range range=new Range();range.start=wall(start);range.end=wall(end);range.includeTime=range.start.length()>10&&range.start.charAt(10)=='T';
        EditText field=new EditText(activity);field.setSingleLine(true);field.setFocusable(false);field.setClickable(true);field.setInputType(0);field.setHint("Tarixsiz");field.setContentDescription("Notion üslubunda tarix və vaxt seçin");HybridUi.edit(field,dark,false);field.setTag(range);paint(field,range);
        LinearLayout.LayoutParams lp=new LinearLayout.LayoutParams(-1,-2);form.addView(field,lp);field.setOnClickListener(v->open(activity,field,range,dark));return field;
    }
    static String start(EditText field){Object value=field==null?null:field.getTag();return value instanceof Range?((Range)value).start:"";}
    static String end(EditText field){Object value=field==null?null:field.getTag();return value instanceof Range?((Range)value).end:"";}
    private static int dp(Activity a,int x){return (int)(a.getResources().getDisplayMetrics().density*x+.5f);}
    private static String wall(String raw){return TaskDateTime.display(raw);}

    private static void paint(EditText field,Range range){String s=range.start;if(s.isEmpty()){field.setText("");return;}String text=display(s);if(!range.end.isEmpty())text+="  →  "+display(range.end);field.setText(text);}
    private static String display(String value){if(value.length()<10)return value;try{String day=new SimpleDateFormat("d MMM yyyy",new Locale("az")).format(new SimpleDateFormat("yyyy-MM-dd",Locale.US).parse(value.substring(0,10)));return day+(value.length()>10?" · "+value.substring(11,16):"");}catch(Exception e){return value;}}
    private static void open(Activity a,EditText field,Range range,boolean dark){
        Range draft=new Range();draft.start=range.start;draft.end=range.end;draft.includeTime=range.includeTime;
        LinearLayout root=new LinearLayout(a);root.setOrientation(LinearLayout.VERTICAL);root.setPadding(dp(a,18),dp(a,12),dp(a,18),dp(a,8));root.setBackgroundColor(HybridUi.bg(dark));
        TextView title=new TextView(a);title.setText("Tarix");title.setTextSize(20);title.setGravity(Gravity.CENTER);title.setTextColor(HybridUi.text(dark));root.addView(title,new LinearLayout.LayoutParams(-1,dp(a,42)));
        LinearLayout startRow=new LinearLayout(a);startRow.setGravity(Gravity.CENTER_VERTICAL);startRow.setPadding(dp(a,8),0,dp(a,8),0);startRow.setBackground(HybridUi.rounded(HybridUi.soft(dark),dp(a,10),HybridUi.border(dark),dp(a,1)));
        Button startDate=new Button(a);Button startTime=new Button(a);style(a,startDate,dark);style(a,startTime,dark);startDate.setText(dateLabel(draft.start,"Başlama tarixi"));startDate.setTag("notion-date-start");startTime.setText(timeLabel(draft.start));startTime.setTag("notion-time-start");startRow.addView(startDate,new LinearLayout.LayoutParams(0,dp(a,48),1));startRow.addView(startTime,new LinearLayout.LayoutParams(dp(a,94),dp(a,48)));root.addView(startRow,new LinearLayout.LayoutParams(-1,-2));
        CheckBox include=new CheckBox(a);include.setText("Vaxtı daxil edin");include.setTag("notion-date-include-time");include.setTextColor(HybridUi.text(dark));include.setChecked(draft.includeTime);root.addView(include);
        CheckBox hasEnd=new CheckBox(a);hasEnd.setText("Bitmə tarixi");hasEnd.setTag("notion-date-has-end");hasEnd.setTextColor(HybridUi.text(dark));hasEnd.setChecked(!draft.end.isEmpty());root.addView(hasEnd);
        LinearLayout endRow=new LinearLayout(a);endRow.setGravity(Gravity.CENTER_VERTICAL);endRow.setPadding(dp(a,8),0,dp(a,8),0);endRow.setBackground(HybridUi.rounded(HybridUi.soft(dark),dp(a,10),HybridUi.border(dark),dp(a,1)));Button endDate=new Button(a);Button endTime=new Button(a);style(a,endDate,dark);style(a,endTime,dark);endDate.setText(dateLabel(draft.end,"Bitmə tarixi"));endDate.setTag("notion-date-end");endTime.setText(timeLabel(draft.end));endTime.setTag("notion-time-end");endRow.addView(endDate,new LinearLayout.LayoutParams(0,dp(a,48),1));endRow.addView(endTime,new LinearLayout.LayoutParams(dp(a,94),dp(a,48)));root.addView(endRow,new LinearLayout.LayoutParams(-1,-2));
        TextView format=new TextView(a);format.setText("Tarix formatı · dd.MM.yyyy       Vaxt formatı · 24 saat\nSaat qurşağı · "+java.util.TimeZone.getDefault().getID());format.setTextSize(12);format.setTextColor(HybridUi.muted(dark));format.setPadding(dp(a,4),dp(a,12),0,dp(a,4));root.addView(format);
        Runnable update=()->{startDate.setText(dateLabel(draft.start,"Başlama tarixi"));startTime.setText(timeLabel(draft.start));endDate.setText(dateLabel(draft.end,"Bitmə tarixi"));endTime.setText(timeLabel(draft.end));startTime.setVisibility(include.isChecked()?View.VISIBLE:View.GONE);endRow.setVisibility(hasEnd.isChecked()?View.VISIBLE:View.GONE);endTime.setVisibility(include.isChecked()?View.VISIBLE:View.GONE);};
        include.setOnCheckedChangeListener((button,checked)->{draft.includeTime=checked;if(checked){if(draft.start.length()==10)draft.start+="T09:00";if(draft.end.length()==10)draft.end+="T09:00";}else{draft.start=day(draft.start);draft.end=day(draft.end);}update.run();});
        hasEnd.setOnCheckedChangeListener((button,checked)->{if(checked){if(draft.start.isEmpty())draft.start=dayToday();if(draft.end.isEmpty())draft.end=draft.start;}else draft.end="";update.run();});
        startDate.setOnClickListener(v->chooseDate(a,draft.start,next->{draft.start=next;if(hasEnd.isChecked()&&draft.end.isEmpty())draft.end=next;update.run();}));startTime.setOnClickListener(v->chooseTime(a,draft.start,next->{draft.start=next;update.run();}));endDate.setOnClickListener(v->chooseDate(a,draft.end.isEmpty()?draft.start:draft.end,next->{draft.end=next;update.run();}));endTime.setOnClickListener(v->chooseTime(a,draft.end.isEmpty()?draft.start:draft.end,next->{draft.end=next;update.run();}));update.run();
        TextView error=new TextView(a);error.setTag("notion-date-error");error.setTextColor(Color.rgb(210,60,60));error.setTextSize(13);error.setVisibility(View.GONE);root.addView(error);
        AlertDialog dialog=new AlertDialog.Builder(a).setView(root).setNegativeButton("Ləğv et",null).setNeutralButton("Təmizlə",null).setPositiveButton("Hazırdır",null).create();dialog.setOnShowListener(x->{dialog.getButton(AlertDialog.BUTTON_NEUTRAL).setOnClickListener(v->{draft.start="";draft.end="";draft.includeTime=false;field.setText("");range.start="";range.end="";range.includeTime=false;field.setTag(range);field.sendAccessibilityEvent(1);dialog.dismiss();});dialog.getButton(AlertDialog.BUTTON_POSITIVE).setOnClickListener(v->{if(hasEnd.isChecked()&&!draft.start.isEmpty()&&draft.end.isEmpty())draft.end=draft.start;String nextStart=normalize(draft.start,include.isChecked()),nextEnd=hasEnd.isChecked()?normalize(draft.end,include.isChecked()):"";if(!nextEnd.isEmpty()&&(nextStart.isEmpty()||nextEnd.compareTo(nextStart)<0)){error.setText("Bitmə tarixi başlanğıcdan əvvəl ola bilməz");error.setVisibility(View.VISIBLE);return;}range.start=nextStart;range.end=nextEnd;range.includeTime=include.isChecked();field.setTag(range);paint(field,range);field.sendAccessibilityEvent(android.view.accessibility.AccessibilityEvent.TYPE_VIEW_TEXT_CHANGED);dialog.dismiss();});});dialog.show();
    }
    private static String normalize(String value,boolean include){if(value==null||value.isEmpty())return "";String d=value.substring(0,Math.min(10,value.length()));return include?d+"T"+(value.length()>=16?value.substring(11,16):"09:00"):d;}
    private interface Pick { void done(String value); }
    private static void chooseDate(Activity a,String value,Pick pick){Calendar c=Calendar.getInstance();try{String d=day(value);c.set(Integer.parseInt(d.substring(0,4)),Integer.parseInt(d.substring(5,7))-1,Integer.parseInt(d.substring(8,10)));}catch(Exception ignored){}new DatePickerDialog(a,(view,y,m,d)->{String result=String.format(Locale.US,"%04d-%02d-%02d",y,m+1,d);if(value.length()>10&&value.charAt(10)=='T')result+=value.substring(10,16);pick.done(result);},c.get(Calendar.YEAR),c.get(Calendar.MONTH),c.get(Calendar.DAY_OF_MONTH)).show();}
    private static void chooseTime(Activity a,String value,Pick pick){int h=9,m=0;try{h=Integer.parseInt(value.substring(11,13));m=Integer.parseInt(value.substring(14,16));}catch(Exception ignored){}String base=value.isEmpty()?dayToday():day(value);new TimePickerDialog(a,(view,hour,minute)->pick.done(base+String.format(Locale.US,"T%02d:%02d",hour,minute)),h,m,true).show();}
    private static String dateLabel(String value,String fallback){return value.length()>=10?display(value).split(" · ")[0]:fallback;}
    private static String timeLabel(String value){return value.length()>=16?value.substring(11,16):"09:00";}
    private static String day(String value){return value==null||value.length()<10?dayToday():value.substring(0,10);}
    private static String dayToday(){return new SimpleDateFormat("yyyy-MM-dd",Locale.US).format(new Date());}
    private static void style(Activity a,Button b,boolean dark){HybridUi.button(b,dark,false);b.setAllCaps(false);b.setTextSize(14);b.setMinHeight(dp(a,44));}
}
