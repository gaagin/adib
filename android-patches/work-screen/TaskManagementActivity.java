package com.adib.maintenance;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.DatePickerDialog;
import android.content.Intent;
import android.graphics.Color;
import android.graphics.Typeface;
import android.graphics.drawable.GradientDrawable;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.text.InputType;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.*;
import org.json.*;
import java.io.*;
import java.net.*;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.*;

/** Native, phone-sized companion to the shared server planner. No embedded website. */
public class TaskManagementActivity extends Activity {@Override protected void attachBaseContext(android.content.Context base){super.attachBaseContext(AzLocale.wrap(base));}
    interface Transport { JSONObject request(String method,String path,JSONObject body) throws Exception; }
    static class ApiError extends Exception {
        final String code; final int status;
        ApiError(String message,String code,int status){super(message);this.code=code;this.status=status;}
    }
    Transport transport=TaskManagementActivity::http;
    private final ExecutorService io=Executors.newSingleThreadExecutor();
    private final ExecutorService fetchIO=Executors.newFixedThreadPool(2);
    boolean refreshing=false,fresh=false,havePersonalCache=false;private long generation=0;private ScrollView scroll;private String statusText="";private boolean statusError=false;
    JSONObject state; JSONArray tasks=new JSONArray(),containers=new JSONArray();
    String day=today(),tab="day",review="incoming",query="";
    int shown=20; boolean busy=false,dark=false,writeConfirmed=false;
    LinearLayout root,content,list; TextView feedback;
    private static final int BLUE=HybridUi.BLUE;
    static String mainPreferencesName(android.content.Context c){String name=MainActivity.class.getName(),prefix=c.getPackageName()+".";return name.startsWith(prefix)?name.substring(prefix.length()):name;}
    static String today(){return new SimpleDateFormat("yyyy-MM-dd",Locale.ROOT).format(new Date());}
    static String nextDate(){Calendar c=Calendar.getInstance();c.add(Calendar.DAY_OF_MONTH,7);return new SimpleDateFormat("yyyy-MM-dd",Locale.ROOT).format(c.getTime());}
    static boolean working(JSONObject t){return !t.optBoolean("completed")&&"in progress".equalsIgnoreCase(t.optString("status").trim());}
    static JSONObject object(JSONObject o,String key){JSONObject v=o==null?null:o.optJSONObject(key);return v==null?new JSONObject():v;}
    static JSONArray array(JSONObject o,String key){JSONArray v=o==null?null:o.optJSONArray(key);return v==null?new JSONArray():v;}
    static JSONObject command(String type,String id,String day){JSONObject b=new JSONObject();try{b.put("type",type);if(id!=null)b.put("id",id);if(day!=null)b.put("day",day);}catch(JSONException ignored){}return b;}
    static boolean contains(JSONArray a,String id){for(int i=0;i<a.length();i++)if(id.equals(a.optString(i)))return true;return false;}
    JSONObject meta(String id){return object(object(state,"tasks"),id);}
    JSONObject plan(){return object(object(state,"days"),day);}
    JSONObject settings(){return object(state,"settings");}
    JSONObject find(String id){for(int i=0;i<tasks.length();i++){JSONObject t=tasks.optJSONObject(i);if(t!=null&&id.equals(t.optString("id"))&&!OfflineDeletes.hidden(this,id))return t;}return null;}
    int estimate(String id){return meta(id).optInt("estimateMinutes",25);}
    static int budget(JSONArray ids,JSONObject metadata){int total=0;for(int i=0;i<ids.length();i++)total+=object(metadata,ids.optString(i)).optInt("estimateMinutes",25);return total;}
    private int dp(float n){return (int)(n*getResources().getDisplayMetrics().density+.5f);}
    private int bg(){return HybridUi.bg(dark);}
    private int panel(){return HybridUi.surface(dark);}
    private int ink(){return HybridUi.text(dark);}
    private int muted(){return HybridUi.muted(dark);}
    private int accent(){return HybridUi.accent(dark);}
    private GradientDrawable shape(int fill,int border){GradientDrawable d=new GradientDrawable();d.setColor(fill);d.setCornerRadius(dp(12));d.setStroke(dp(1),border);return d;}
    @Override public void onCreate(Bundle b){
        super.onCreate(b);dark=getSharedPreferences(mainPreferencesName(this),MODE_PRIVATE).getBoolean("dark_theme",false);
        tab=getIntent().getStringExtra("tab")==null?"day":getIntent().getStringExtra("tab");
        restoreDisplayFilters();
        if(b!=null){day=b.getString("day",today());tab=b.getString("tab","day");review=b.getString("review","incoming");query=b.getString("query","");}
        getWindow().setStatusBarColor(bg());getWindow().setNavigationBarColor(bg());getWindow().getDecorView().setSystemUiVisibility(dark?0:View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
        restorePlannerCache();render();reload(false);
    }
    @Override protected void onSaveInstanceState(Bundle b){super.onSaveInstanceState(b);b.putString("day",day);b.putString("tab",tab);b.putString("review",review);b.putString("query",query);}

    private RealtimeSync realtimeSync;private final Map<String,JSONObject> realtimePending=new HashMap<>();private final android.os.Handler realtimeHandler=new android.os.Handler(android.os.Looper.getMainLooper());
    private final Runnable realtimeApply=new Runnable(){public void run(){if(!alive())return;if(!hasWindowFocus()||busy||refreshing){realtimeHandler.postDelayed(this,500);return;}
      JSONObject personal=realtimePending.remove("personal"),management=realtimePending.remove("management");
      if(personal!=null){tasks=OfflineDeletes.filterTasks(TaskManagementActivity.this,array(personal,"tasks"));containers=array(personal,"containers");PlannerCache.rememberPersonal(TaskManagementActivity.this,personal);havePersonalCache=true;}
      if(management!=null){if(state==null||management.optLong("revision")>=state.optLong("revision"))state=OfflineDeletes.filterState(TaskManagementActivity.this,management);PlannerCache.rememberPair(TaskManagementActivity.this,state,personal);}
      if(root!=null){renderList();updateFeedback();}
    }};
    private void startRealtime(){if(realtimeSync==null)realtimeSync=new RealtimeSync((scope,data)->{realtimePending.put(scope,data);realtimeHandler.removeCallbacks(realtimeApply);realtimeHandler.postDelayed(realtimeApply,150);},"personal","management");realtimeSync.start();}
    private void stopRealtime(){if(realtimeSync!=null)realtimeSync.stop();realtimeHandler.removeCallbacksAndMessages(null);realtimePending.clear();}
    @Override public void onWindowFocusChanged(boolean focus){super.onWindowFocusChanged(focus);if(focus&&!realtimePending.isEmpty()){realtimeHandler.removeCallbacks(realtimeApply);realtimeHandler.post(realtimeApply);}}
    @Override protected void onPause(){stopRealtime();super.onPause();}

    @Override protected void onResume(){super.onResume();startRealtime();OfflineDeletes.kick(this);if(root!=null){renderList();updateFeedback();}}
    @Override protected void onDestroy(){stopRealtime();generation++;fetchIO.shutdownNow();io.shutdownNow();super.onDestroy();}
    private boolean alive(){return !isFinishing()&&!isDestroyed();}
    private TextView label(String value,int size,boolean strong){TextView t=new TextView(this);t.setText(value);t.setTextSize(size);t.setTextColor(ink());if(strong)t.setTypeface(Typeface.DEFAULT,Typeface.BOLD);t.setPadding(0,dp(5),0,dp(5));return t;}
    private LinearLayout column(){LinearLayout l=new LinearLayout(this);l.setOrientation(LinearLayout.VERTICAL);return l;}
    private Button button(String text,String tag,Runnable action){Button b=new Button(this);b.setText(text);b.setTag(tag);b.setAllCaps(false);b.setTextSize(14);b.setMinHeight(dp(48));b.setMinimumHeight(dp(48));b.setPadding(dp(10),dp(8),dp(10),dp(8));b.setTextColor(accent());b.setBackground(shape(panel(),HybridUi.border(dark)));HybridUi.button(b,dark,false);b.setOnClickListener(v->{if(allowed(tag))action.run();});b.setEnabled(allowed(tag));b.setAlpha(b.isEnabled()?1f:.45f);LinearLayout.LayoutParams p=new LinearLayout.LayoutParams(-1,-2);p.topMargin=dp(5);p.bottomMargin=dp(5);b.setLayoutParams(p);return b;}
    private LinearLayout card(LinearLayout parent,boolean main){LinearLayout c=column();c.setPadding(dp(14),dp(12),dp(14),dp(12));c.setBackground(shape(main?(HybridUi.outgoing(dark)):panel(),main?BLUE:(HybridUi.border(dark))));LinearLayout.LayoutParams p=new LinearLayout.LayoutParams(-1,-2);p.topMargin=dp(9);p.bottomMargin=dp(4);parent.addView(c,p);return c;}
    private void pair(LinearLayout parent,Button a,Button b){if(!(String.valueOf(a.getTag()).startsWith("tab:")||"refresh".equals(b.getTag()))&&(getResources().getConfiguration().fontScale>1.25f||getResources().getConfiguration().screenWidthDp<300)){parent.addView(a);parent.addView(b);return;}LinearLayout row=new LinearLayout(this);row.setOrientation(LinearLayout.HORIZONTAL);LinearLayout.LayoutParams ap=new LinearLayout.LayoutParams(0,-2,1),bp=new LinearLayout.LayoutParams(0,-2,1);ap.rightMargin=dp(4);bp.leftMargin=dp(4);ap.topMargin=bp.topMargin=dp(5);ap.bottomMargin=bp.bottomMargin=dp(5);row.addView(a,ap);row.addView(b,bp);parent.addView(row);}
    private EditText field(LinearLayout parent,String title,String value,boolean number){parent.addView(label(title,14,false));EditText e=new EditText(this);e.setText(value);e.setTextColor(ink());e.setHintTextColor(muted());e.setTextSize(16);e.setMinHeight(dp(48));e.setSingleLine(true);e.setInputType(number?InputType.TYPE_CLASS_NUMBER:InputType.TYPE_CLASS_TEXT);e.setPadding(dp(12),dp(8),dp(12),dp(8));e.setBackground(shape(panel(),HybridUi.border(dark)));HybridUi.edit(e,dark,false);parent.addView(e,new LinearLayout.LayoutParams(-1,-2));return e;}
    private AlertDialog.Builder dialog(){return new AlertDialog.Builder(this,dark?R.style.AdibDialogDark:R.style.AdibDialogLight);}
    private void chooseDate(String value,java.util.function.Consumer<String> result){Calendar c=Calendar.getInstance();try{SimpleDateFormat f=new SimpleDateFormat("yyyy-MM-dd",Locale.ROOT);f.setLenient(false);c.setTime(f.parse(value));}catch(Exception ignored){}new DatePickerDialog(this,dark?R.style.AdibDialogDark:R.style.AdibDialogLight,(v,y,m,n)->result.accept(String.format(Locale.ROOT,"%04d-%02d-%02d",y,m+1,n)),c.get(Calendar.YEAR),c.get(Calendar.MONTH),c.get(Calendar.DAY_OF_MONTH)).show();}
    void render(){
        root=column();root.setPadding(dp(12),dp(6),dp(12),0);root.setBackgroundColor(bg());FrameLayout frame=new FrameLayout(this);frame.addView(root,new FrameLayout.LayoutParams(-1,-1));setContentView(frame);if(!tab.equals("settings")&&AccountSession.section("personal")){Button add=CompactDesign.fab(this,dark);add.setTag("task-management-add");FrameLayout.LayoutParams addParams=new FrameLayout.LayoutParams(dp(56),dp(56),Gravity.BOTTOM|Gravity.RIGHT);addParams.setMargins(0,0,dp(16),dp(16));frame.addView(add,addParams);add.setOnClickListener(v->{startActivity(new Intent(this,MainActivity.class).setAction(MainActivity.ACTION_QUICK_ADD).addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP|Intent.FLAG_ACTIVITY_SINGLE_TOP));finish();});}
        LinearLayout header=new LinearLayout(this);header.setGravity(Gravity.CENTER_VERTICAL);Button back=button("‹", "back",this::finish);back.setEnabled(true);back.setOnClickListener(v->finish());header.addView(back,new LinearLayout.LayoutParams(dp(48),dp(48)));TextView title=label("Gün planı",22,true);title.setPadding(dp(12),0,0,0);header.addView(title,new LinearLayout.LayoutParams(0,-2,1));root.addView(header);
        final LinearLayout extra=column();extra.setVisibility(View.GONE);Button more=button("⋯","planner-more",()->extra.setVisibility(extra.getVisibility()==View.GONE?View.VISIBLE:View.GONE));more.setContentDescription("Əlavə plan bölmələri");header.addView(more,new LinearLayout.LayoutParams(dp(48),dp(48)));pair(extra,button("Gün planı","tab:day",()->switchTab("day")),button("Təhlil","tab:review",()->switchTab("review")));root.addView(extra);
        scroll=new ScrollView(this);scroll.setFillViewport(true);root.addView(scroll,new LinearLayout.LayoutParams(-1,0,1));content=column();content.setPadding(dp(4),0,dp(4),dp(20));scroll.addView(content);
        
        pair(content,button("Ayarlar","tab:settings",()->switchTab("settings")),button("Yenilə","refresh",this::reload));
        feedback=label(busy?"Yüklənir…":"",14,false);feedback.setTextColor(muted());feedback.setAccessibilityLiveRegion(View.ACCESSIBILITY_LIVE_REGION_POLITE);content.addView(feedback);updateFeedback();
        if(state==null){content.addView(label("Yükləmə planı və parametrlər…",16,false));if(havePersonalCache){content.addView(label("Son saxlanmış tapşırıq siyahısı",16,true));for(int i=0;i<Math.min(tasks.length(),20);i++){JSONObject t=tasks.optJSONObject(i);if(t!=null)taskTitle(card(content,false),t);}}return;}
        LinearLayout summary=card(content,false);summary.addView(button("Gün: "+day,"day",()->chooseDate(day,v->{day=v;query="";render();})));
        JSONArray ids=array(plan(),"ids");int total=budget(ids,object(state,"tasks")),cap=settings().optInt("budgetMinutes",120),active=0;for(int i=0;i<tasks.length();i++)if(tasks.optJSONObject(i)!=null&&working(tasks.optJSONObject(i)))active++;
        if("day".equals(tab))summary.addView(label(ids.length()+" / "+settings().optInt("dailyTaskLimit",4)+" tapşırıqlar · "+total+" / "+cap+" dəq",18,true));
        if("day".equals(tab)){ProgressBar progress=new ProgressBar(this,null,android.R.attr.progressBarStyleHorizontal);progress.setMax(Math.max(1,cap));progress.setProgress(total);progress.setProgressTintList(android.content.res.ColorStateList.valueOf(BLUE));progress.setContentDescription("Gündəlik büdcə: "+total+" -dan "+cap+" dəqiqə");summary.addView(progress,new LinearLayout.LayoutParams(-1,dp(8)));summary.addView(label("Qalan "+Math.max(0,cap-total)+" dəq",13,false));}
        if("day".equals(tab)&&total>cap){TextView warn=label("Plan vaxt büdcəsini aşır",14,false);warn.setTextColor(dark?Color.rgb(255,188,106):Color.rgb(152,79,0));summary.addView(warn);}
        summary.addView(label("İşləyir: "+active+" / "+settings().optInt("wipLimit",2)+" · yalnız Mənim tapşırıqlarım",14,false));
        if("settings".equals(tab)){settingsForm();return;}
        if("day".equals(tab)){
            content.addView(label("Əsas vəzifə və ondan əvvəl "+Math.max(0,settings().optInt("dailyTaskLimit",4)-1)+" əlavə",18,true));
            if(ids.length()==0)content.addView(label("Plan boşdur. Aşağıdakı tapşırıqları seçin. Vaxtı keçmişlər avtomatik əlavə edilmir.",16,false));
            for(int i=0;i<ids.length();i++){JSONObject task=null;for(int j=0;j<tasks.length();j++){JSONObject t=tasks.optJSONObject(j);if(t!=null&&t.optString("id").equals(ids.optString(i))){task=t;break;}}if(task==null||TaskFilterDialog.matches(task,displayFilter()))dayCard(ids.optString(i));}
            content.addView(label("Plana əlavə edin",18,true));
        }else{
            content.addView(label("Hər dəfə bir tapşırığı sökün",18,true));
            String[] keys={"incoming","overdue","stale","waiting"},names={"Daxil olanlar","Vaxtı keçib","Uzun müddət yeniləməsiz","Yoxlama həvalə edilib"};

        }
        content.addView(button("Filtr","plan-filter",this::showDisplayFilter));list=column();content.addView(list);renderList();syncControls(content);
    }
    private JSONObject displayFilter(){JSONObject seed=new JSONObject();try{seed.put("query",query).put("review",review);}catch(Exception ignored){}return TaskFilterDialog.read(this,"plan-"+tab,seed);}
    private void showDisplayFilter(){ArrayList<String> fields=new ArrayList<>(java.util.Arrays.asList(TaskFilterDialog.PERSONAL));fields.remove("completion");if("review".equals(tab))fields.add("review");TaskFilterDialog.show(this,dark,"plan-"+tab,"day".equals(tab)?"Gün planı":"Tapşırığın təhlili",tasks,containers,fields.toArray(new String[0]),displayFilter(),f->{query=f.optString("query");review=f.optString("review",review);rememberDisplayFilters();shown=20;render();});}

    private void restoreDisplayFilters(){JSONObject saved=FilterMemory.read(this,"plan-search-"+tab);query=saved.optString("query","");review=FilterMemory.choice(FilterMemory.read(this,"plan-review").optString("review"),"incoming","incoming","overdue","stale","waiting");}
    private void rememberDisplayFilters(){try{FilterMemory.write(this,"plan-search-"+tab,new JSONObject().put("query",query));FilterMemory.write(this,"plan-review",new JSONObject().put("review",review));}catch(Exception ignored){}}
    private void switchTab(String value){rememberDisplayFilters();tab=value;restoreDisplayFilters();shown=20;render();}
    private void openTask(JSONObject t){setResult(RESULT_OK);startActivity(new Intent(this,MainActivity.class).setAction(MainActivity.ACTION_WIDGET_TASK).putExtra("widget_id",t.optString("id")).putExtra("plannerEstimateKnown",fresh).putExtra("plannerEstimateMinutes",meta(t.optString("id")).optInt("estimateMinutes",-1)).addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP|Intent.FLAG_ACTIVITY_SINGLE_TOP));finish();}
    private void taskTitle(LinearLayout c,JSONObject t){Button title=button(t.optString("title","Adsız"),"open:"+t.optString("id"),()->openTask(t));title.setTextColor(ink());title.setTypeface(Typeface.DEFAULT,Typeface.BOLD);title.setGravity(Gravity.START|Gravity.CENTER_VERTICAL);title.setBackgroundColor(Color.TRANSPARENT);c.addView(title);}
    private void dayCard(String id){JSONObject t=find(id);boolean main=id.equals(plan().optString("mainId"));LinearLayout c=card(content,main);c.setTag("task:"+id);
        if(main)c.addView(label("★ Əsas nəticə",14,true));
        if(t==null){c.addView(label("Tapşırıq mövcud deyil",16,true));c.addView(button("Gündən çıxarın","remove:"+id,()->update(command("day-remove",id,day))));return;}
        taskTitle(c,t);c.addView(label(t.optString("status")+" · 🍅 "+t.optInt("pomodoroTotalCount",t.optInt("pomodoroCount"))+" · "+Math.round(t.optDouble("pomodoroTotalMinutes",t.optDouble("pomodoroMinutes")))+" dəq",14,false));
        c.addView(button("Reytinq: "+estimate(id)+" dəq"+(meta(id).has("estimateMinutes")?"":" (standart olaraq)"),"estimate:"+id,()->editEstimate(id)));
        pair(c,button("★ Əsas səhifə","main:"+id,()->update(command("main",id,day))),button("İşləmək üçün","start:"+id,()->startTask(id,false)));
        pair(c,button("✓ Tamamlanıb","finish:"+id,()->finishTask(id)),button("Gündən çıxarın","remove:"+id,()->update(command("day-remove",id,day))));
    }
    private void editEstimate(String id){LinearLayout box=column();box.setPadding(dp(16),dp(6),dp(16),0);EditText input=field(box,"Dəqiqələr, tam 1–43200",String.valueOf(estimate(id)),true);AlertDialog d=dialog().setTitle("Vaxt təxmini").setView(box).setNegativeButton("Ləğv et",null).setPositiveButton("Saxla",null).create();d.setOnShowListener(v->d.getButton(-1).setOnClickListener(b->{try{int n=Integer.parseInt(input.getText().toString());if(n<1||n>43200)throw new Exception();JSONObject command=command("estimate",id,null).put("minutes",n);d.dismiss();update(command);}catch(Exception e){input.setError("1-dən 43200-ə qədər tam ədəd daxil edin");}}));d.show();}
    static boolean eligible(JSONObject t,JSONObject meta,JSONArray containers,String filter,String today,int staleDays){
        if(t==null||t.optBoolean("completed"))return false;String check=meta.optString("checkDate");if(!check.isEmpty()&&check.compareTo(today)>0)return false;
        if("waiting".equals(filter))return "waiting".equals(meta.optString("disposition"))&&!check.isEmpty()&&check.compareTo(today)<=0;
        if("overdue".equals(filter)){String date=t.optString("date");return !date.isEmpty()&&date.substring(0,Math.min(10,date.length())).compareTo(today)<0;}
        if("stale".equals(filter)){String date=meta.optString("reviewedAt",t.optString("updatedAt"));try{SimpleDateFormat f=new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss",Locale.ROOT);f.setTimeZone(TimeZone.getTimeZone("UTC"));f.setLenient(false);return f.parse(date.substring(0,19)).getTime()<System.currentTimeMillis()-staleDays*86400000L;}catch(Exception e){return false;}}
        String container=t.optString("containerId");boolean incoming=container.isEmpty();for(int i=0;i<containers.length();i++){JSONObject c=containers.optJSONObject(i);if(c!=null&&container.equals(c.optString("id"))&&"inbox".equalsIgnoreCase(c.optString("name").trim()))incoming=true;}
        return incoming&&!working(t)&&!"Delegate".equalsIgnoreCase(t.optString("status"))&&!"waiting".equals(meta.optString("disposition"))&&(!"later".equals(meta.optString("disposition"))||!check.isEmpty()&&check.compareTo(today)<=0);
    }
    void renderList(){tasks=OfflineDeletes.filterTasks(this,tasks);state=OfflineDeletes.filterState(this,state);if(list==null)return;list.removeAllViews();int count=0;JSONArray ids=array(plan(),"ids");for(int i=0;i<tasks.length();i++){JSONObject t=tasks.optJSONObject(i);if(t==null||!TaskFilterDialog.matches(t,displayFilter())||t.optBoolean("completed")||!t.optString("title").toLowerCase(Locale.ROOT).contains(query.toLowerCase(Locale.ROOT)))continue;String id=t.optString("id");if("day".equals(tab)?contains(ids,id):!eligible(t,meta(id),containers,review,today(),settings().optInt("staleDays",14)))continue;count++;if(count>shown)continue;
            LinearLayout c=card(list,false);c.setTag("candidate:"+id);taskTitle(c,t);TextView status=label(t.optString("status")+(t.optString("date").isEmpty()?"":" · "+t.optString("date")),14,false);status.setTextColor(muted());c.addView(status);
            c.addView(button("Seçilmiş gün üçün","add:"+id,()->update(command("day-add",id,day))));
            if("review".equals(tab)){pair(c,button("Daha sonra","later:"+id,()->reviewForm(id,false)),button("Nümayəndə","delegate:"+id,()->reviewForm(id,true)));c.addView(button("Sil","delete:"+id,()->confirmDelete(t)));}
        }
        list.addView(label(count==0?"Bu filtr üçün tapşırıq yoxdur":"Göstərildi "+Math.min(count,shown)+" -dan "+count,14,false));if(count>shown)list.addView(button("Daha 20 göstər","more",()->{shown+=20;renderList();}));
    }
    private void settingsForm(){content.addView(label("Xidmət üçün ümumi məhdudiyyətlər",18,true));content.addView(label("Defolt: gündə 4 tapşırıq, WIP 2, büdcə 120 dəqiqə, saxlama müddəti 14 gün.",14,false));String[] keys={"dailyTaskLimit","wipLimit","budgetMinutes","staleDays"},names={"Plandakı tapşırıqlar (1–12)","Eyni vaxtda istismarda (1–10)","Büdcə, dəqiqə (15–1440)","Yeniləmə yoxdur, günlər (1–180)"};int[] min={1,1,15,1},max={12,10,1440,180};EditText[] inputs=new EditText[4];for(int i=0;i<4;i++){inputs[i]=field(content,names[i],String.valueOf(settings().optInt(keys[i])),true);inputs[i].setTag(keys[i]);}
        content.addView(button("Parametrləri yadda saxlayın","save-settings",()->{JSONObject b=command("settings",null,null);for(int i=0;i<4;i++)try{int n=Integer.parseInt(inputs[i].getText().toString());if(n<min[i]||n>max[i])throw new Exception();b.put(keys[i],n);}catch(Exception e){inputs[i].setError("Nömrəni daxil edin "+min[i]+" üçün "+max[i]);return;}update(b);}));
    }
    private void reviewForm(String id,boolean delegate){LinearLayout box=column();box.setPadding(dp(16),dp(6),dp(16),0);EditText owner=delegate?field(box,"Məsul şəxs","",false):null;final String[] date={nextDate()};Button dateButton=button("Yoxlayın: "+date[0],"check-date",()->{});dateButton.setOnClickListener(v->chooseDate(date[0],d->{date[0]=d;dateButton.setText("Yoxlayın: "+d);}));box.addView(dateButton);AlertDialog d=dialog().setTitle(delegate?"Nümayəndə":"Təhlil olunana qədər təxirə salın").setView(box).setNegativeButton("Ləğv et",null).setPositiveButton("Saxla",null).create();d.setOnShowListener(v->d.getButton(-1).setOnClickListener(vv->{String name=owner==null?"":owner.getText().toString().trim();if(delegate&&(name.isEmpty()||name.length()>200)){owner.setError("Məsul şəxsi göstərin, 200 simvola qədər");return;}if(date[0].compareTo(today())<0){dateButton.setError("Bu gün və ya gələcək tarixi seçin");return;}d.dismiss();try{JSONObject b=command("review",id,null).put("disposition",delegate?"waiting":"later").put("checkDate",date[0]).put("owner",name);if(delegate){JSONObject patch=new JSONObject().put("id",id).put("status","Delegate").put("assignees",new JSONArray().put(name));perform(()->{transport.request("PATCH","/api/personal-task",patch);writeConfirmed=true;return transport.request("POST","/api/task-management",withRevision(b));},null);}else update(b);}catch(Exception e){error(e.getMessage());}}));d.show();}
    private void confirmDelete(JSONObject t){dialog().setTitle("Tapşırıq silinsin?").setMessage(t.optString("title")+"\nTapşırıq cihazda yox olacaq. Yapışdır Notion əlaqə qurulduqda göndəriləcək.").setNegativeButton("Ləğv et",null).setPositiveButton("Sil",(d,w)->{try{OfflineDeletes.enqueue(this,t,true,"");tasks=OfflineDeletes.filterTasks(this,tasks);state=OfflineDeletes.filterState(this,state);setResult(RESULT_OK);render();status("Cihazda silindi",false);}catch(Exception e){error(e.getMessage());}}).show();}
    private JSONObject withRevision(JSONObject b)throws JSONException{return b.put("expectedRevision",state.optInt("revision"));}
    void update(JSONObject b){try{withRevision(b);}catch(Exception e){error(e.getMessage());return;}perform(()->transport.request("POST","/api/task-management",b),null);}
    void startTask(String id,boolean override){try{JSONObject b=new JSONObject().put("id",id).put("status","In progress");if(override)b.put("wipOverride",true);perform(()->transport.request("PATCH","/api/personal-task",b),()->startTask(id,true));}catch(Exception e){error(e.getMessage());}}
    private void finishTask(String id){CompletionUndo.schedule(this,id,()->commitFinishTask(id));}
    private void commitFinishTask(String id){try{JSONObject b=new JSONObject().put("id",id).put("status","Done").put("completed",true);perform(()->transport.request("PATCH","/api/personal-task",b),null);}catch(Exception e){error(e.getMessage());}}
    interface Operation { JSONObject run()throws Exception; }
    
    private void restorePlannerCache(){JSONObject saved=PlannerCache.read(this);JSONObject personal=saved.optJSONObject("personal"),metadata=saved.optJSONObject("state");if(personal!=null&&personal.optJSONArray("tasks")!=null){havePersonalCache=true;tasks=array(personal,"tasks");containers=array(personal,"containers");try{validate(metadata,personal);state=metadata;}catch(Exception ignored){}}}
    private void updateFeedback(){if(feedback==null)return;String q=OfflineDeletes.summary(this);feedback.setText(statusText+(q.isEmpty()?"":" · "+q));feedback.setTextColor(statusError?(dark?Color.rgb(255,148,148):Color.rgb(184,30,30)):muted());feedback.setVisibility(statusText.isEmpty()&&q.isEmpty()?View.GONE:View.VISIBLE);}
    private void status(String text,boolean error){statusText=text;statusError=error;updateFeedback();}
    private boolean mutationTag(String tag){return tag.equals("save-settings")||tag.matches("^(add|main|start|finish|remove|estimate|later|delegate|delete):.*");}
    private boolean allowed(String tag){if(tag.startsWith("delete:"))return !busy&&havePersonalCache;return !busy&&(!tag.equals("refresh")||!refreshing)&&(!mutationTag(tag)||fresh&&!refreshing);}
    private void syncControls(View v){if(v instanceof Button){String tag=String.valueOf(v.getTag());v.setEnabled(allowed(tag));v.setAlpha(v.isEnabled()?1f:.45f);}else if(v instanceof EditText||v instanceof Spinner)v.setEnabled(!busy);if(v instanceof ViewGroup)for(int i=0;i<((ViewGroup)v).getChildCount();i++)syncControls(((ViewGroup)v).getChildAt(i));}
    private View findTag(View v,String tag){if(tag.equals(v.getTag()))return v;if(v instanceof ViewGroup)for(int i=0;i<((ViewGroup)v).getChildCount();i++){View result=findTag(((ViewGroup)v).getChildAt(i),tag);if(result!=null)return result;}return null;}
    private void applyPair(Pair pair){int scrollY=scroll==null?0:scroll.getScrollY();View oldSearch=root==null?null:findTag(root,"search");boolean searchFocused=oldSearch!=null&&oldSearch.hasFocus();int caret=oldSearch instanceof EditText?((EditText)oldSearch).getSelectionStart():0;Map<String,String> drafts=new HashMap<>();String focusTag="";for(String key:new String[]{"dailyTaskLimit","wipLimit","budgetMinutes","staleDays"}){View input=root==null?null:findTag(root,key);if(input instanceof EditText){String value=((EditText)input).getText().toString();if(!value.equals(String.valueOf(settings().optInt(key))))drafts.put(key,value);if(input.hasFocus())focusTag=key;}}
        state=OfflineDeletes.filterState(this,pair.state);tasks=OfflineDeletes.filterTasks(this,array(pair.personal,"tasks"));containers=array(pair.personal,"containers");havePersonalCache=true;fresh=true;refreshing=false;busy=false;statusText="Yenilənib";statusError=false;render();for(Map.Entry<String,String> entry:drafts.entrySet()){View input=findTag(root,entry.getKey());if(input instanceof EditText)((EditText)input).setText(entry.getValue());}if(searchFocused){EditText input=(EditText)findTag(root,"search");if(input!=null){input.requestFocus();input.setSelection(Math.max(0,Math.min(caret,input.length())));}}else if(!focusTag.isEmpty()){View input=findTag(root,focusTag);if(input!=null)input.requestFocus();}final ScrollView current=scroll;if(current!=null)current.getViewTreeObserver().addOnGlobalLayoutListener(new android.view.ViewTreeObserver.OnGlobalLayoutListener(){public void onGlobalLayout(){current.getViewTreeObserver().removeOnGlobalLayoutListener(this);if(alive()&&scroll==current)current.scrollTo(0,scrollY);}});}
    static final class Pair {final JSONObject state,personal;final long personalFetchedAt;Pair(JSONObject state,JSONObject personal,long fetchedAt){this.state=state;this.personal=personal;this.personalFetchedAt=fetchedAt;}}
    static void validate(JSONObject state,JSONObject personal)throws ApiError{if(state==null||state.optInt("version")!=1||state.optJSONObject("settings")==null||state.optJSONObject("tasks")==null||state.optJSONObject("days")==null||personal==null||personal.optJSONArray("tasks")==null)throw new ApiError("Yenilənmiş server lazımdır ADIB.","INVALID_SNAPSHOT",502);}
    private Pair fetchPair(long token,boolean partial,boolean preferRecent)throws Exception{JSONObject cache=preferRecent?PlannerCache.read(this):new JSONObject();long cachedAt=cache.optLong("personalFetchedAt"),age=System.currentTimeMillis()-cachedAt;JSONObject cachedPersonal=cache.optJSONObject("personal");boolean recent=preferRecent&&cachedAt>0&&age>=0&&age<=15000&&cachedPersonal!=null&&cachedPersonal.optJSONArray("tasks")!=null;java.util.concurrent.atomic.AtomicLong fetchedAt=new java.util.concurrent.atomic.AtomicLong(recent?cachedAt:0);Future<JSONObject> metadata=fetchIO.submit(()->{JSONObject next=transport.request("GET","/api/task-management",null);if(partial)runOnUiThread(()->{if(alive()&&token==generation&&state==null&&havePersonalCache){try{validate(next,new JSONObject().put("tasks",tasks));state=next;statusText="Yenilənir… Tapşırıqların saxlanmış siyahısı göstərilir.";render();}catch(Exception ignored){}}});return next;});Future<JSONObject> personal=fetchIO.submit(()->{if(recent)return cachedPersonal;JSONObject result=transport.request("GET","/api/personal-snapshot",null);fetchedAt.set(System.currentTimeMillis());return result;});try{JSONObject next=metadata.get(),snapshot=personal.get();validate(next,snapshot);return new Pair(next,snapshot,fetchedAt.get());}catch(Exception e){metadata.cancel(true);personal.cancel(true);Throwable cause=e instanceof ExecutionException?e.getCause():e;if(cause instanceof Exception)throw (Exception)cause;throw e;}}
    private void error(String message){if(OfflineNetwork.error(message)){status(OfflineNetwork.message(),false);return;}status(message==null?"Yükləmək və ya saxlamaq uğursuz oldu. Yeniləmə klikləyin.":message,true);}
    private void perform(Operation op,Runnable override){if(busy||refreshing||!fresh||state==null)return;busy=true;writeConfirmed=false;final long token=++generation;syncControls(content);status("Qənaət…",false);io.execute(()->{try{op.run();writeConfirmed=true;PlannerCache.invalidate(this);Pair pair=fetchPair(token,false,false);PlannerCache.rememberPair(this,pair.state,pair.personal,pair.personalFetchedAt);runOnUiThread(()->{if(!alive()||token!=generation)return;applyPair(pair);setResult(RESULT_OK);status("Saxlandı",false);});}catch(Exception e){runOnUiThread(()->{if(!alive()||token!=generation)return;busy=false;if(e instanceof ApiError&&"WIP_LIMIT".equals(((ApiError)e).code)&&override!=null){syncControls(content);dialog().setTitle("İşdəki tapşırıqların həddi").setMessage(e.getMessage()+"\nHər halda başlasın?").setNegativeButton("Ləğv et",(d,w)->status("Dəyişiklik ləğv edildi",false)).setPositiveButton("Hər halda başlayın",(d,w)->override.run()).show();}else{if(writeConfirmed){fresh=false;PlannerCache.invalidate(this);setResult(RESULT_OK);error("Bəzi dəyişikliklər artıq saxlanılıb. Vəziyyəti yoxlamaq üçün Yenilə üzərinə klikləyin. "+e.getMessage());}else error(e.getMessage());syncControls(content);}});}});}
    void reload(){reload(true);}
    private void reload(boolean force){if(busy||refreshing)return;refreshing=true;final long token=++generation;syncControls(content);status(state!=null?"Yenilənir… Saxlanmış məlumatlar göstərilir.":"Yükləmə planı…",false);io.execute(()->{try{Pair pair=fetchPair(token,true,!force);PlannerCache.rememberPair(this,pair.state,pair.personal,pair.personalFetchedAt);runOnUiThread(()->{if(alive()&&token==generation)applyPair(pair);});}catch(Exception e){runOnUiThread(()->{if(!alive()||token!=generation)return;refreshing=false;fresh=false;error((state!=null||havePersonalCache?"Yeniləmə uğursuz oldu. Saxlanılan məlumatlar ekranda qalır. Dəyişikliklər hələ mövcud deyil. ":"Yükləmə uğursuz oldu. İnternet və server yeniləmələrini yoxlayın. ")+e.getMessage());syncControls(content);});}});}
    static JSONObject http(String method,String path,JSONObject body)throws Exception{return httpWithTimeout(method,path,body,15000);}
    static JSONObject httpWithTimeout(String method,String path,JSONObject body,int timeout)throws Exception{if(DirectRuntime.enabled())return DirectRuntime.request(method,path,body);HttpURLConnection c=null;try{String base=BuildConfig.APP_BASE_URL;c=(HttpURLConnection)new URL(base.replaceAll("/$","")+path).openConnection();AccountSession.authorize(c);c.setRequestMethod(method);c.setConnectTimeout(15000);c.setReadTimeout(timeout);c.setRequestProperty("Accept","application/json");if(body!=null){c.setDoOutput(true);c.setRequestProperty("Content-Type","application/json; charset=utf-8");try(OutputStream out=c.getOutputStream()){out.write(body.toString().getBytes(StandardCharsets.UTF_8));}}int status=AccountSession.response(c);InputStream stream=status>=400?c.getErrorStream():c.getInputStream();if(stream==null)throw new ApiError("Server boş cavab qaytardı","",status);StringBuilder s=new StringBuilder();try(BufferedReader in=new BufferedReader(new InputStreamReader(stream,StandardCharsets.UTF_8))){String line;while((line=in.readLine())!=null)s.append(line);}JSONObject data;try{data=new JSONObject(s.toString());}catch(Exception e){throw new ApiError("Server cavabı tanınmadı. Yenilənmiş server lazımdır ADIB.","",status);}if(status>=400)throw new ApiError(data.optString("error","HTTP "+status),data.optString("code"),status);return data;}finally{if(c!=null)c.disconnect();}}
}