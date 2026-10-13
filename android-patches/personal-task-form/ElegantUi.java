package com.adib.maintenance;
import android.graphics.Typeface;import android.view.View;import android.widget.*;
/** Visual-only form polish. No controls are removed, reparented, or reordered. */
final class ElegantUi {
 static void decorate(LinearLayout form,boolean dark){float d=form.getResources().getDisplayMetrics().density;form.setPadding(Math.round(20*d),Math.round(4*d),Math.round(20*d),Math.round(20*d));form.setBackgroundColor(HybridUi.surface(dark));form.setTag("elegant-task-form");for(int i=0;i<form.getChildCount();i++){View v=form.getChildAt(i);if(v instanceof EditText){EditText edit=(EditText)v;HybridUi.edit(edit,dark,false);if(i==1){edit.setTextSize(20);edit.setTypeface(null,Typeface.BOLD);edit.setMinHeight(Math.round(58*d));}}if(v instanceof Spinner){v.setMinimumHeight(Math.round(52*d));}if(v instanceof TextView&&!(v instanceof EditText)&&!(v instanceof Button)&&!(v instanceof CheckBox)){((TextView)v).setLineSpacing(2*d,1.04f);}if(v.getLayoutParams() instanceof LinearLayout.LayoutParams){LinearLayout.LayoutParams p=(LinearLayout.LayoutParams)v.getLayoutParams();if(v instanceof EditText||v instanceof Spinner)p.bottomMargin=Math.round(4*d);}}}
}
