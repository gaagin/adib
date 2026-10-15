package com.adib.maintenance;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.graphics.Typeface;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.util.TypedValue;
import android.view.Gravity;
import android.view.View;
import android.view.WindowInsets;
import android.view.WindowInsetsController;
import android.view.WindowManager;
import android.widget.FrameLayout;
import android.widget.TextView;
import android.widget.Toast;
import java.util.Locale;

/** Full-screen presentation of the current Pomodoro. The existing service owns completion. */
public final class PomodoroFocusActivity extends Activity {
    static final String EXTRA_WIDGET="focus_from_widget";
    static final String ACTION="com.adib.maintenance.POMODORO_BLACK_SCREEN";
    private final Handler handler=new Handler(Looper.getMainLooper());
    private TextView clock;
    java.util.function.LongSupplier now=System::currentTimeMillis;
    private boolean widget,observing;
    private String taskId,sessionId,mode;
    private SharedPreferences timerPrefs,widgetPrefs;
    private final SharedPreferences.OnSharedPreferenceChangeListener listener=(prefs,key)->handler.post(this::refresh);
    private final Runnable tick=this::refresh;
    static Intent widgetIntent(Context c){return new Intent(c,PomodoroFocusActivity.class).setAction(ACTION).putExtra(EXTRA_WIDGET,true).addFlags(Intent.FLAG_ACTIVITY_NEW_TASK|Intent.FLAG_ACTIVITY_SINGLE_TOP);}
    static Intent floatingIntent(Context c){return new Intent(c,PomodoroFocusActivity.class).setAction(ACTION).addFlags(Intent.FLAG_ACTIVITY_NEW_TASK|Intent.FLAG_ACTIVITY_SINGLE_TOP);}
    @Override public void onCreate(Bundle saved){
        super.onCreate(saved);widget=getIntent().getBooleanExtra(EXTRA_WIDGET,false);
        timerPrefs=getSharedPreferences(AdibFloatingTimerService.PREFS,MODE_PRIVATE);widgetPrefs=getSharedPreferences(AdibWidgetData.PREFS,MODE_PRIVATE);
        PomodoroFocusState.Snapshot initial=PomodoroFocusState.read(this,widget);
        if(saved!=null){taskId=saved.getString("focus_task","");sessionId=saved.getString("focus_session","");mode=saved.getString("focus_mode","work");}
        else{taskId=initial.taskId;sessionId=initial.sessionId;mode=initial.mode;if(!initial.valid||!initial.running||initial.left(now.getAsLong())<=0){Toast.makeText(this,"Əvvəlcə Pomodoronu başladın və ya davam etdirin",Toast.LENGTH_SHORT).show();finish();return;}}
        getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON|WindowManager.LayoutParams.FLAG_FULLSCREEN);
        getWindow().setStatusBarColor(Color.BLACK);getWindow().setNavigationBarColor(Color.BLACK);
        if(Build.VERSION.SDK_INT>=29){getWindow().setNavigationBarContrastEnforced(false);getWindow().setStatusBarContrastEnforced(false);}
        if(Build.VERSION.SDK_INT>=28){WindowManager.LayoutParams attrs=getWindow().getAttributes();attrs.layoutInDisplayCutoutMode=WindowManager.LayoutParams.LAYOUT_IN_DISPLAY_CUTOUT_MODE_SHORT_EDGES;getWindow().setAttributes(attrs);}
        FrameLayout screen=new FrameLayout(this);screen.setBackgroundColor(Color.BLACK);
        clock=new TextView(this);clock.setTextColor(Color.rgb(198,198,198));clock.setTextSize(TypedValue.COMPLEX_UNIT_DIP,32);clock.setTypeface(Typeface.MONOSPACE,Typeface.NORMAL);clock.setIncludeFontPadding(false);clock.setGravity(Gravity.CENTER);clock.setImportantForAccessibility(View.IMPORTANT_FOR_ACCESSIBILITY_YES);
        screen.addView(clock,new FrameLayout.LayoutParams(-2,-2,Gravity.CENTER));setContentView(screen);hideSystemBars();refresh();
    }
    private void hideSystemBars(){
        if(Build.VERSION.SDK_INT>=30){getWindow().setDecorFitsSystemWindows(false);WindowInsetsController controller=getWindow().getInsetsController();if(controller!=null){controller.hide(WindowInsets.Type.systemBars());controller.setSystemBarsBehavior(WindowInsetsController.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE);}}
        else getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_FULLSCREEN|View.SYSTEM_UI_FLAG_HIDE_NAVIGATION|View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY|View.SYSTEM_UI_FLAG_LAYOUT_STABLE|View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN|View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION);
    }
    void refresh(){
        handler.removeCallbacks(tick);if(isFinishing()||isDestroyed()||clock==null)return;
        PomodoroFocusState.Snapshot state=PomodoroFocusState.read(this,widget);
        if(!state.valid||!taskId.equals(state.taskId)||!mode.equals(state.mode)||!sessionId.isEmpty()&&!state.sessionId.isEmpty()&&!sessionId.equals(state.sessionId)){finish();return;}
        if(sessionId.isEmpty()&&!state.sessionId.isEmpty())sessionId=state.sessionId;
        long left=state.left(now.getAsLong());if(left<=0){finish();return;}
        long seconds=(left+999)/1000;String value=String.format(Locale.ROOT,"%02d:%02d",seconds/60,seconds%60);
        if(!value.contentEquals(clock.getText())){clock.setText(value);clock.setContentDescription("Pomodoro: "+value);}
        if(observing)handler.postDelayed(tick,state.running?Math.max(1,Math.min(1000,left%1000==0?1000:left%1000)):1000);
    }
    @Override protected void onResume(){super.onResume();if(isFinishing())return;observing=true;timerPrefs.registerOnSharedPreferenceChangeListener(listener);widgetPrefs.registerOnSharedPreferenceChangeListener(listener);AdibFloatingTimerService.focusVisibilityChanged(true);hideSystemBars();refresh();}
    @Override protected void onPause(){observing=false;handler.removeCallbacksAndMessages(null);if(timerPrefs!=null)timerPrefs.unregisterOnSharedPreferenceChangeListener(listener);if(widgetPrefs!=null)widgetPrefs.unregisterOnSharedPreferenceChangeListener(listener);AdibFloatingTimerService.focusVisibilityChanged(false);super.onPause();}
    @Override protected void onDestroy(){handler.removeCallbacksAndMessages(null);super.onDestroy();}
    @Override protected void onSaveInstanceState(Bundle saved){saved.putString("focus_task",taskId);saved.putString("focus_session",sessionId);saved.putString("focus_mode",mode);super.onSaveInstanceState(saved);}
    @Override public void onWindowFocusChanged(boolean focused){super.onWindowFocusChanged(focused);if(focused&&!isFinishing())hideSystemBars();}
    @Override public void onBackPressed(){finish();}
}
