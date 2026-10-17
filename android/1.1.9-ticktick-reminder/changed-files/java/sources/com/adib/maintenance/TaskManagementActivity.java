package com.adib.maintenance;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.DatePickerDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.res.ColorStateList;
import android.graphics.Color;
import android.graphics.Typeface;
import android.graphics.drawable.GradientDrawable;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewTreeObserver;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ProgressBar;
import android.widget.ScrollView;
import android.widget.Spinner;
import android.widget.SpinnerAdapter;
import android.widget.TextView;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.TimeZone;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.atomic.AtomicLong;
import java.util.function.Consumer;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class TaskManagementActivity extends Activity {
    private static final int BLUE = HybridUi.BLUE;
    LinearLayout content;
    TextView feedback;
    LinearLayout list;
    LinearLayout root;
    private ScrollView scroll;
    JSONObject state;
    Transport transport = new Transport() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda47
        @Override // com.adib.maintenance.TaskManagementActivity.Transport
        public final JSONObject request(String str, String str2, JSONObject jSONObject) {
            return TaskManagementActivity.http(str, str2, jSONObject);
        }
    };

    /* JADX INFO: renamed from: io */
    private final ExecutorService f29io = Executors.newSingleThreadExecutor();
    private final ExecutorService fetchIO = Executors.newFixedThreadPool(2);
    boolean refreshing = false;
    boolean fresh = false;
    boolean havePersonalCache = false;
    private long generation = 0;
    private String statusText = "";
    private boolean statusError = false;
    JSONArray tasks = new JSONArray();
    JSONArray containers = new JSONArray();
    String day = today();
    String tab = "day";
    String review = "incoming";
    String query = "";
    int shown = 20;
    boolean busy = false;
    boolean dark = false;
    boolean writeConfirmed = false;

    interface Operation {
        JSONObject run() throws Exception;
    }

    interface Transport {
        JSONObject request(String str, String str2, JSONObject jSONObject) throws Exception;
    }

    static /* synthetic */ void lambda$reviewForm$24() {
    }

    static class ApiError extends Exception {
        final String code;
        final int status;

        ApiError(String str, String str2, int i) {
            super(str);
            this.code = str2;
            this.status = i;
        }
    }

    static String mainPreferencesName(Context context) {
        String name = MainActivity.class.getName();
        String str = context.getPackageName() + ".";
        return name.startsWith(str) ? name.substring(str.length()) : name;
    }

    static String today() {
        return new SimpleDateFormat("yyyy-MM-dd", Locale.ROOT).format(new Date());
    }

    static String nextDate() {
        Calendar calendar = Calendar.getInstance();
        calendar.add(5, 7);
        return new SimpleDateFormat("yyyy-MM-dd", Locale.ROOT).format(calendar.getTime());
    }

    static boolean working(JSONObject jSONObject) {
        return !jSONObject.optBoolean("completed") && "in progress".equalsIgnoreCase(jSONObject.optString("status").trim());
    }

    static JSONObject object(JSONObject jSONObject, String str) {
        JSONObject jSONObjectOptJSONObject = jSONObject == null ? null : jSONObject.optJSONObject(str);
        return jSONObjectOptJSONObject == null ? new JSONObject() : jSONObjectOptJSONObject;
    }

    static JSONArray array(JSONObject jSONObject, String str) {
        JSONArray jSONArrayOptJSONArray = jSONObject == null ? null : jSONObject.optJSONArray(str);
        return jSONArrayOptJSONArray == null ? new JSONArray() : jSONArrayOptJSONArray;
    }

    static JSONObject command(String str, String str2, String str3) {
        JSONObject jSONObject = new JSONObject();
        try {
            jSONObject.put("type", str);
            if (str2 != null) {
                jSONObject.put("id", str2);
            }
            if (str3 != null) {
                jSONObject.put("day", str3);
            }
        } catch (JSONException unused) {
        }
        return jSONObject;
    }

    static boolean contains(JSONArray jSONArray, String str) {
        for (int i = 0; i < jSONArray.length(); i++) {
            if (str.equals(jSONArray.optString(i))) {
                return true;
            }
        }
        return false;
    }

    JSONObject meta(String str) {
        return object(object(this.state, "tasks"), str);
    }

    JSONObject plan() {
        return object(object(this.state, "days"), this.day);
    }

    JSONObject settings() {
        return object(this.state, "settings");
    }

    JSONObject find(String str) {
        for (int i = 0; i < this.tasks.length(); i++) {
            JSONObject jSONObjectOptJSONObject = this.tasks.optJSONObject(i);
            if (jSONObjectOptJSONObject != null && str.equals(jSONObjectOptJSONObject.optString("id")) && !OfflineDeletes.hidden(this, str)) {
                return jSONObjectOptJSONObject;
            }
        }
        return null;
    }

    int estimate(String str) {
        return meta(str).optInt("estimateMinutes", 25);
    }

    static int budget(JSONArray jSONArray, JSONObject jSONObject) {
        int iOptInt = 0;
        for (int i = 0; i < jSONArray.length(); i++) {
            iOptInt += object(jSONObject, jSONArray.optString(i)).optInt("estimateMinutes", 25);
        }
        return iOptInt;
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: dp */
    public int m18dp(float f) {
        return (int) ((f * getResources().getDisplayMetrics().density) + 0.5f);
    }

    /* JADX INFO: renamed from: bg */
    private int m17bg() {
        return HybridUi.m4bg(this.dark);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public int panel() {
        return HybridUi.surface(this.dark);
    }

    private int ink() {
        return HybridUi.text(this.dark);
    }

    private int muted() {
        return HybridUi.muted(this.dark);
    }

    private int accent() {
        return HybridUi.accent(this.dark);
    }

    private GradientDrawable shape(int i, int i2) {
        GradientDrawable gradientDrawable = new GradientDrawable();
        gradientDrawable.setColor(i);
        gradientDrawable.setCornerRadius(m18dp(12.0f));
        gradientDrawable.setStroke(m18dp(1.0f), i2);
        return gradientDrawable;
    }

    @Override // android.app.Activity
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        this.dark = getSharedPreferences(mainPreferencesName(this), 0).getBoolean("dark_theme", false);
        this.tab = getIntent().getStringExtra("tab") == null ? "day" : getIntent().getStringExtra("tab");
        if (bundle != null) {
            this.day = bundle.getString("day", today());
            this.tab = bundle.getString("tab", "day");
            this.review = bundle.getString("review", "incoming");
            this.query = bundle.getString("query", "");
        }
        getWindow().setStatusBarColor(m17bg());
        getWindow().setNavigationBarColor(m17bg());
        getWindow().getDecorView().setSystemUiVisibility(this.dark ? 0 : 8192);
        restorePlannerCache();
        render();
        reload(false);
    }

    @Override // android.app.Activity
    protected void onSaveInstanceState(Bundle bundle) {
        super.onSaveInstanceState(bundle);
        bundle.putString("day", this.day);
        bundle.putString("tab", this.tab);
        bundle.putString("review", this.review);
        bundle.putString("query", this.query);
    }

    @Override // android.app.Activity
    protected void onResume() {
        super.onResume();
        ChatNotifications.foreground = true;
        OfflineDeletes.kick(this);
        if (this.root != null) {
            renderList();
            updateFeedback();
        }
    }

    @Override // android.app.Activity
    protected void onPause() {
        ChatNotifications.foreground = false;
        super.onPause();
    }

    @Override // android.app.Activity
    protected void onDestroy() {
        ChatNotifications.foreground = false;
        this.generation++;
        this.fetchIO.shutdownNow();
        this.f29io.shutdownNow();
        super.onDestroy();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean alive() {
        return (isFinishing() || isDestroyed()) ? false : true;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public TextView label(String str, int i, boolean z) {
        TextView textView = new TextView(this);
        textView.setText(str);
        textView.setTextSize(i);
        textView.setTextColor(ink());
        if (z) {
            textView.setTypeface(Typeface.DEFAULT, 1);
        }
        textView.setPadding(0, m18dp(5.0f), 0, m18dp(5.0f));
        return textView;
    }

    private LinearLayout column() {
        LinearLayout linearLayout = new LinearLayout(this);
        linearLayout.setOrientation(1);
        return linearLayout;
    }

    private Button button(String str, final String str2, final Runnable runnable) {
        Button button = new Button(this);
        button.setText(str);
        button.setTag(str2);
        button.setAllCaps(false);
        button.setTextSize(14.0f);
        button.setMinHeight(m18dp(48.0f));
        button.setMinimumHeight(m18dp(48.0f));
        button.setPadding(m18dp(10.0f), m18dp(8.0f), m18dp(10.0f), m18dp(8.0f));
        button.setTextColor(accent());
        button.setBackground(shape(panel(), HybridUi.border(this.dark)));
        HybridUi.button(button, this.dark, false);
        button.setOnClickListener(new View.OnClickListener() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda44
            @Override // android.view.View.OnClickListener
            public final void onClick(View view) {
                this.f$0.lambda$button$0(str2, runnable, view);
            }
        });
        button.setEnabled(allowed(str2));
        button.setAlpha(button.isEnabled() ? 1.0f : 0.45f);
        LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(-1, -2);
        layoutParams.topMargin = m18dp(5.0f);
        layoutParams.bottomMargin = m18dp(5.0f);
        button.setLayoutParams(layoutParams);
        return button;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$button$0(String str, Runnable runnable, View view) {
        if (allowed(str)) {
            runnable.run();
        }
    }

    private LinearLayout card(LinearLayout linearLayout, boolean z) {
        LinearLayout linearLayoutColumn = column();
        linearLayoutColumn.setPadding(m18dp(14.0f), m18dp(12.0f), m18dp(14.0f), m18dp(12.0f));
        linearLayoutColumn.setBackground(shape(z ? HybridUi.outgoing(this.dark) : panel(), z ? BLUE : HybridUi.border(this.dark)));
        LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(-1, -2);
        layoutParams.topMargin = m18dp(9.0f);
        layoutParams.bottomMargin = m18dp(4.0f);
        linearLayout.addView(linearLayoutColumn, layoutParams);
        return linearLayoutColumn;
    }

    private void pair(LinearLayout linearLayout, Button button, Button button2) {
        if (!String.valueOf(button.getTag()).startsWith("tab:") && !"refresh".equals(button2.getTag()) && (getResources().getConfiguration().fontScale > 1.25f || getResources().getConfiguration().screenWidthDp < 300)) {
            linearLayout.addView(button);
            linearLayout.addView(button2);
            return;
        }
        LinearLayout linearLayout2 = new LinearLayout(this);
        linearLayout2.setOrientation(0);
        LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(0, -2, 1.0f);
        LinearLayout.LayoutParams layoutParams2 = new LinearLayout.LayoutParams(0, -2, 1.0f);
        layoutParams.rightMargin = m18dp(4.0f);
        layoutParams2.leftMargin = m18dp(4.0f);
        int iM18dp = m18dp(5.0f);
        layoutParams2.topMargin = iM18dp;
        layoutParams.topMargin = iM18dp;
        int iM18dp2 = m18dp(5.0f);
        layoutParams2.bottomMargin = iM18dp2;
        layoutParams.bottomMargin = iM18dp2;
        linearLayout2.addView(button, layoutParams);
        linearLayout2.addView(button2, layoutParams2);
        linearLayout.addView(linearLayout2);
    }

    private EditText field(LinearLayout linearLayout, String str, String str2, boolean z) {
        linearLayout.addView(label(str, 14, false));
        EditText editText = new EditText(this);
        editText.setText(str2);
        editText.setTextColor(ink());
        editText.setHintTextColor(muted());
        editText.setTextSize(16.0f);
        editText.setMinHeight(m18dp(48.0f));
        editText.setSingleLine(true);
        editText.setInputType(z ? 2 : 1);
        editText.setPadding(m18dp(12.0f), m18dp(8.0f), m18dp(12.0f), m18dp(8.0f));
        editText.setBackground(shape(panel(), HybridUi.border(this.dark)));
        HybridUi.edit(editText, this.dark, false);
        linearLayout.addView(editText, new LinearLayout.LayoutParams(-1, -2));
        return editText;
    }

    private AlertDialog.Builder dialog() {
        return new AlertDialog.Builder(this, this.dark ? C0031R.style.AdibDialogDark : C0031R.style.AdibDialogLight);
    }

    private void chooseDate(String str, final Consumer<String> consumer) {
        Calendar calendar = Calendar.getInstance();
        try {
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd", Locale.ROOT);
            simpleDateFormat.setLenient(false);
            calendar.setTime(simpleDateFormat.parse(str));
        } catch (Exception unused) {
        }
        new DatePickerDialog(this, this.dark ? C0031R.style.AdibDialogDark : C0031R.style.AdibDialogLight, new DatePickerDialog.OnDateSetListener() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda4
            @Override // android.app.DatePickerDialog.OnDateSetListener
            public final void onDateSet(DatePicker datePicker, int i, int i2, int i3) {
                consumer.accept(String.format(Locale.ROOT, "%04d-%02d-%02d", Integer.valueOf(i), Integer.valueOf(i2 + 1), Integer.valueOf(i3)));
            }
        }, calendar.get(1), calendar.get(2), calendar.get(5)).show();
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r12v21 */
    /* JADX WARN: Type inference failed for: r12v7 */
    /* JADX WARN: Type inference failed for: r12v8, types: [boolean, int] */
    void render() {
        ?? r12;
        LinearLayout linearLayoutColumn = column();
        this.root = linearLayoutColumn;
        linearLayoutColumn.setPadding(m18dp(12.0f), m18dp(6.0f), m18dp(12.0f), 0);
        this.root.setBackgroundColor(m17bg());
        setContentView(this.root);
        LinearLayout linearLayout = new LinearLayout(this);
        linearLayout.setGravity(16);
        Button button = button("‹", "back", new Runnable() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda35
            @Override // java.lang.Runnable
            public final void run() {
                this.f$0.finish();
            }
        });
        button.setEnabled(true);
        button.setOnClickListener(new View.OnClickListener() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda36
            @Override // android.view.View.OnClickListener
            public final void onClick(View view) {
                this.f$0.lambda$render$2(view);
            }
        });
        linearLayout.addView(button, new LinearLayout.LayoutParams(m18dp(48.0f), m18dp(48.0f)));
        TextView textViewLabel = label("План дня", 22, true);
        textViewLabel.setPadding(m18dp(12.0f), 0, 0, 0);
        linearLayout.addView(textViewLabel, new LinearLayout.LayoutParams(0, -2, 1.0f));
        this.root.addView(linearLayout);
        final LinearLayout linearLayoutColumn2 = column();
        linearLayoutColumn2.setVisibility(8);
        Button button2 = button("⋯", "planner-more", new Runnable() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda37
            @Override // java.lang.Runnable
            public final void run() {
                LinearLayout linearLayout2 = linearLayoutColumn2;
                linearLayout2.setVisibility(linearLayout2.getVisibility() == 8 ? 0 : 8);
            }
        });
        button2.setContentDescription("Дополнительные разделы плана");
        linearLayout.addView(button2, new LinearLayout.LayoutParams(m18dp(48.0f), m18dp(48.0f)));
        pair(linearLayoutColumn2, button("План дня", "tab:day", new Runnable() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda38
            @Override // java.lang.Runnable
            public final void run() {
                this.f$0.lambda$render$4();
            }
        }), button("Разбор", "tab:review", new Runnable() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda39
            @Override // java.lang.Runnable
            public final void run() {
                this.f$0.lambda$render$5();
            }
        }));
        this.root.addView(linearLayoutColumn2);
        ScrollView scrollView = new ScrollView(this);
        this.scroll = scrollView;
        scrollView.setFillViewport(true);
        this.root.addView(this.scroll, new LinearLayout.LayoutParams(-1, 0, 1.0f));
        LinearLayout linearLayoutColumn3 = column();
        this.content = linearLayoutColumn3;
        linearLayoutColumn3.setPadding(m18dp(4.0f), 0, m18dp(4.0f), m18dp(20.0f));
        this.scroll.addView(this.content);
        pair(this.content, button("Настройки", "tab:settings", new Runnable() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda40
            @Override // java.lang.Runnable
            public final void run() {
                this.f$0.lambda$render$6();
            }
        }), button("Обновить", "refresh", new Runnable() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda41
            @Override // java.lang.Runnable
            public final void run() {
                this.f$0.reload();
            }
        }));
        TextView textViewLabel2 = label(this.busy ? "Загружаю…" : "", 14, false);
        this.feedback = textViewLabel2;
        textViewLabel2.setTextColor(muted());
        this.feedback.setAccessibilityLiveRegion(1);
        this.content.addView(this.feedback);
        updateFeedback();
        if (this.state == null) {
            this.content.addView(label("Загружаю план и настройки…", 16, false));
            if (this.havePersonalCache) {
                this.content.addView(label("Последний сохранённый список задач", 16, true));
                for (int i = 0; i < Math.min(this.tasks.length(), 20); i++) {
                    JSONObject jSONObjectOptJSONObject = this.tasks.optJSONObject(i);
                    if (jSONObjectOptJSONObject != null) {
                        taskTitle(card(this.content, false), jSONObjectOptJSONObject);
                    }
                }
                return;
            }
            return;
        }
        LinearLayout linearLayoutCard = card(this.content, false);
        linearLayoutCard.addView(button("День: " + this.day, "day", new Runnable() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda42
            @Override // java.lang.Runnable
            public final void run() {
                this.f$0.lambda$render$8();
            }
        }));
        JSONArray jSONArrayArray = array(plan(), "ids");
        int iBudget = budget(jSONArrayArray, object(this.state, "tasks"));
        int iOptInt = settings().optInt("budgetMinutes", 120);
        int i2 = 0;
        for (int i3 = 0; i3 < this.tasks.length(); i3++) {
            if (this.tasks.optJSONObject(i3) != null && working(this.tasks.optJSONObject(i3))) {
                i2++;
            }
        }
        if ("day".equals(this.tab)) {
            linearLayoutCard.addView(label(jSONArrayArray.length() + " / " + settings().optInt("dailyTaskLimit", 4) + " задач · " + iBudget + " / " + iOptInt + " мин", 18, true));
        }
        if ("day".equals(this.tab)) {
            ProgressBar progressBar = new ProgressBar(this, null, android.R.attr.progressBarStyleHorizontal);
            progressBar.setMax(Math.max(1, iOptInt));
            progressBar.setProgress(iBudget);
            progressBar.setProgressTintList(ColorStateList.valueOf(BLUE));
            progressBar.setContentDescription("Бюджет дня: " + iBudget + " из " + iOptInt + " минут");
            linearLayoutCard.addView(progressBar, new LinearLayout.LayoutParams(-1, m18dp(8.0f)));
            r12 = 0;
            linearLayoutCard.addView(label("Осталось " + Math.max(0, iOptInt - iBudget) + " мин", 13, false));
        } else {
            r12 = 0;
        }
        if ("day".equals(this.tab) && iBudget > iOptInt) {
            TextView textViewLabel3 = label("План превышает бюджет времени", 14, r12);
            textViewLabel3.setTextColor(this.dark ? Color.rgb(255, 188, 106) : Color.rgb(152, 79, (int) r12));
            linearLayoutCard.addView(textViewLabel3);
        }
        linearLayoutCard.addView(label("В работе: " + i2 + " / " + settings().optInt("wipLimit", 2) + " · только Мои задачи", 14, false));
        if ("settings".equals(this.tab)) {
            settingsForm();
            return;
        }
        if ("day".equals(this.tab)) {
            this.content.addView(label("Главная задача и до " + Math.max(0, settings().optInt("dailyTaskLimit", 4) - 1) + " дополнительных", 18, true));
            if (jSONArrayArray.length() == 0) {
                this.content.addView(label("План пуст. Выберите задачи ниже. Просроченные автоматически не добавляются.", 16, false));
            }
            for (int i4 = 0; i4 < jSONArrayArray.length(); i4++) {
                dayCard(jSONArrayArray.optString(i4));
            }
            this.content.addView(label("Добавить в план", 18, true));
        } else {
            this.content.addView(label("Разбирайте по одной задаче", 18, true));
            final String[] strArr = {"incoming", "overdue", "stale", "waiting"};
            Spinner spinner = new Spinner(this);
            spinner.setTag("review-filter");
            spinner.setBackground(shape(panel(), HybridUi.border(this.dark)));
            spinner.setAdapter((SpinnerAdapter) new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, new String[]{"Входящие", "Просроченные", "Давно без обновления", "Проверить делегированные"}) { // from class: com.adib.maintenance.TaskManagementActivity.1
                @Override // android.widget.ArrayAdapter, android.widget.BaseAdapter, android.widget.SpinnerAdapter
                public View getDropDownView(int i5, View view, ViewGroup viewGroup) {
                    TextView textViewLabel4 = TaskManagementActivity.this.label(getItem(i5), 14, false);
                    textViewLabel4.setMinHeight(TaskManagementActivity.this.m18dp(48.0f));
                    textViewLabel4.setPadding(TaskManagementActivity.this.m18dp(12.0f), TaskManagementActivity.this.m18dp(8.0f), TaskManagementActivity.this.m18dp(12.0f), TaskManagementActivity.this.m18dp(8.0f));
                    textViewLabel4.setBackgroundColor(TaskManagementActivity.this.panel());
                    return textViewLabel4;
                }

                @Override // android.widget.ArrayAdapter, android.widget.Adapter
                public View getView(int i5, View view, ViewGroup viewGroup) {
                    TextView textViewLabel4 = TaskManagementActivity.this.label(getItem(i5) + " ▾", 14, false);
                    textViewLabel4.setMinHeight(TaskManagementActivity.this.m18dp(48.0f));
                    textViewLabel4.setGravity(16);
                    textViewLabel4.setPadding(TaskManagementActivity.this.m18dp(12.0f), TaskManagementActivity.this.m18dp(8.0f), TaskManagementActivity.this.m18dp(12.0f), TaskManagementActivity.this.m18dp(8.0f));
                    return textViewLabel4;
                }
            });
            int i5 = 0;
            for (int i6 = 0; i6 < 4; i6++) {
                if (strArr[i6].equals(this.review)) {
                    i5 = i6;
                }
            }
            spinner.setSelection(i5);
            spinner.setEnabled(!this.busy);
            spinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() { // from class: com.adib.maintenance.TaskManagementActivity.2
                @Override // android.widget.AdapterView.OnItemSelectedListener
                public void onNothingSelected(AdapterView<?> adapterView) {
                }

                @Override // android.widget.AdapterView.OnItemSelectedListener
                public void onItemSelected(AdapterView<?> adapterView, View view, int i7, long j) {
                    TaskManagementActivity.this.review = strArr[i7];
                    TaskManagementActivity.this.shown = 20;
                    TaskManagementActivity.this.renderList();
                }
            });
            this.content.addView(spinner, new LinearLayout.LayoutParams(-1, -2));
        }
        EditText editTextField = field(this.content, "Поиск", this.query, false);
        editTextField.setTag("search");
        LinearLayout linearLayoutColumn4 = column();
        this.list = linearLayoutColumn4;
        this.content.addView(linearLayoutColumn4);
        editTextField.addTextChangedListener(new TextWatcher() { // from class: com.adib.maintenance.TaskManagementActivity.3
            @Override // android.text.TextWatcher
            public void afterTextChanged(Editable editable) {
            }

            @Override // android.text.TextWatcher
            public void beforeTextChanged(CharSequence charSequence, int i7, int i8, int i9) {
            }

            @Override // android.text.TextWatcher
            public void onTextChanged(CharSequence charSequence, int i7, int i8, int i9) {
                TaskManagementActivity.this.query = charSequence.toString();
                TaskManagementActivity.this.shown = 20;
                TaskManagementActivity.this.renderList();
            }
        });
        renderList();
        syncControls(this.content);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$render$2(View view) {
        finish();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$render$4() {
        switchTab("day");
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$render$5() {
        switchTab("review");
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$render$6() {
        switchTab("settings");
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$render$7(String str) {
        this.day = str;
        this.query = "";
        render();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$render$8() {
        chooseDate(this.day, new Consumer() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda9
            @Override // java.util.function.Consumer
            public final void accept(Object obj) {
                this.f$0.lambda$render$7((String) obj);
            }
        });
    }

    private void switchTab(String str) {
        this.tab = str;
        this.query = "";
        this.shown = 20;
        render();
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: openTask, reason: merged with bridge method [inline-methods] */
    public void lambda$taskTitle$9(JSONObject jSONObject) {
        setResult(-1);
        startActivity(new Intent(this, (Class<?>) MainActivity.class).setAction(MainActivity.ACTION_WIDGET_TASK).putExtra("widget_id", jSONObject.optString("id")).putExtra("plannerEstimateKnown", this.fresh).putExtra("plannerEstimateMinutes", meta(jSONObject.optString("id")).optInt("estimateMinutes", -1)).addFlags(603979776));
        finish();
    }

    private void taskTitle(LinearLayout linearLayout, final JSONObject jSONObject) {
        Button button = button(jSONObject.optString("title", "Без названия"), "open:" + jSONObject.optString("id"), new Runnable() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda11
            @Override // java.lang.Runnable
            public final void run() {
                this.f$0.lambda$taskTitle$9(jSONObject);
            }
        });
        button.setTextColor(ink());
        button.setTypeface(Typeface.DEFAULT, 1);
        button.setGravity(8388627);
        button.setBackgroundColor(0);
        linearLayout.addView(button);
    }

    private void dayCard(final String str) {
        JSONObject jSONObjectFind = find(str);
        boolean zEquals = str.equals(plan().optString("mainId"));
        LinearLayout linearLayoutCard = card(this.content, zEquals);
        linearLayoutCard.setTag("task:" + str);
        if (zEquals) {
            linearLayoutCard.addView(label("★ Главный результат", 14, true));
        }
        if (jSONObjectFind == null) {
            linearLayoutCard.addView(label("Задача недоступна", 16, true));
            linearLayoutCard.addView(button("Убрать из дня", "remove:" + str, new Runnable() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda15
                @Override // java.lang.Runnable
                public final void run() {
                    this.f$0.lambda$dayCard$10(str);
                }
            }));
            return;
        }
        taskTitle(linearLayoutCard, jSONObjectFind);
        linearLayoutCard.addView(label(jSONObjectFind.optString("status") + " · 🍅 " + jSONObjectFind.optInt("pomodoroTotalCount", jSONObjectFind.optInt("pomodoroCount")) + " · " + Math.round(jSONObjectFind.optDouble("pomodoroTotalMinutes", jSONObjectFind.optDouble("pomodoroMinutes"))) + " мин", 14, false));
        linearLayoutCard.addView(button("Оценка: " + estimate(str) + " мин" + (meta(str).has("estimateMinutes") ? "" : " (по умолчанию)"), "estimate:" + str, new Runnable() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda16
            @Override // java.lang.Runnable
            public final void run() {
                this.f$0.lambda$dayCard$11(str);
            }
        }));
        pair(linearLayoutCard, button("★ Главная", "main:" + str, new Runnable() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda17
            @Override // java.lang.Runnable
            public final void run() {
                this.f$0.lambda$dayCard$12(str);
            }
        }), button("В работу", "start:" + str, new Runnable() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda18
            @Override // java.lang.Runnable
            public final void run() {
                this.f$0.lambda$dayCard$13(str);
            }
        }));
        pair(linearLayoutCard, button("✓ Выполнено", "finish:" + str, new Runnable() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda19
            @Override // java.lang.Runnable
            public final void run() {
                this.f$0.lambda$dayCard$14(str);
            }
        }), button("Убрать из дня", "remove:" + str, new Runnable() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda20
            @Override // java.lang.Runnable
            public final void run() {
                this.f$0.lambda$dayCard$15(str);
            }
        }));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$dayCard$10(String str) {
        update(command("day-remove", str, this.day));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$dayCard$12(String str) {
        update(command("main", str, this.day));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$dayCard$13(String str) {
        startTask(str, false);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$dayCard$15(String str) {
        update(command("day-remove", str, this.day));
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: editEstimate, reason: merged with bridge method [inline-methods] */
    public void lambda$dayCard$11(final String str) {
        LinearLayout linearLayoutColumn = column();
        linearLayoutColumn.setPadding(m18dp(16.0f), m18dp(6.0f), m18dp(16.0f), 0);
        final EditText editTextField = field(linearLayoutColumn, "Минуты, целое число 1–43200", String.valueOf(estimate(str)), true);
        final AlertDialog alertDialogCreate = dialog().setTitle("Оценка времени").setView(linearLayoutColumn).setNegativeButton("Отмена", (DialogInterface.OnClickListener) null).setPositiveButton("Сохранить", (DialogInterface.OnClickListener) null).create();
        alertDialogCreate.setOnShowListener(new DialogInterface.OnShowListener() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda45
            @Override // android.content.DialogInterface.OnShowListener
            public final void onShow(DialogInterface dialogInterface) {
                this.f$0.lambda$editEstimate$17(alertDialogCreate, editTextField, str, dialogInterface);
            }
        });
        alertDialogCreate.show();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$editEstimate$16(EditText editText, String str, AlertDialog alertDialog, View view) {
        try {
            int i = Integer.parseInt(editText.getText().toString());
            if (i < 1 || i > 43200) {
                throw new Exception();
            }
            JSONObject jSONObjectPut = command("estimate", str, null).put("minutes", i);
            alertDialog.dismiss();
            update(jSONObjectPut);
        } catch (Exception unused) {
            editText.setError("Введите целое число от 1 до 43200");
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$editEstimate$17(final AlertDialog alertDialog, final EditText editText, final String str, DialogInterface dialogInterface) {
        alertDialog.getButton(-1).setOnClickListener(new View.OnClickListener() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda7
            @Override // android.view.View.OnClickListener
            public final void onClick(View view) {
                this.f$0.lambda$editEstimate$16(editText, str, alertDialog, view);
            }
        });
    }

    static boolean eligible(JSONObject jSONObject, JSONObject jSONObject2, JSONArray jSONArray, String str, String str2, int i) {
        if (jSONObject != null && !jSONObject.optBoolean("completed")) {
            String strOptString = jSONObject2.optString("checkDate");
            if (!strOptString.isEmpty() && strOptString.compareTo(str2) > 0) {
                return false;
            }
            if ("waiting".equals(str)) {
                return "waiting".equals(jSONObject2.optString("disposition")) && !strOptString.isEmpty() && strOptString.compareTo(str2) <= 0;
            }
            if ("overdue".equals(str)) {
                String strOptString2 = jSONObject.optString("date");
                return !strOptString2.isEmpty() && strOptString2.substring(0, Math.min(10, strOptString2.length())).compareTo(str2) < 0;
            }
            if ("stale".equals(str)) {
                String strOptString3 = jSONObject2.optString("reviewedAt", jSONObject.optString("updatedAt"));
                try {
                    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss", Locale.ROOT);
                    simpleDateFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
                    simpleDateFormat.setLenient(false);
                    return simpleDateFormat.parse(strOptString3.substring(0, 19)).getTime() < System.currentTimeMillis() - (((long) i) * 86400000);
                } catch (Exception unused) {
                }
            } else {
                String strOptString4 = jSONObject.optString("containerId");
                boolean zIsEmpty = strOptString4.isEmpty();
                for (int i2 = 0; i2 < jSONArray.length(); i2++) {
                    JSONObject jSONObjectOptJSONObject = jSONArray.optJSONObject(i2);
                    if (jSONObjectOptJSONObject != null && strOptString4.equals(jSONObjectOptJSONObject.optString("id")) && "inbox".equalsIgnoreCase(jSONObjectOptJSONObject.optString("name").trim())) {
                        zIsEmpty = true;
                    }
                }
                if (zIsEmpty && !working(jSONObject) && !"Delegate".equalsIgnoreCase(jSONObject.optString("status")) && !"waiting".equals(jSONObject2.optString("disposition")) && (!"later".equals(jSONObject2.optString("disposition")) || (!strOptString.isEmpty() && strOptString.compareTo(str2) <= 0))) {
                    return true;
                }
            }
        }
        return false;
    }

    /* JADX WARN: Code duplicated, block: B:23:0x0092  */
    /* JADX WARN: Code duplicated, block: B:26:0x009a  */
    /* JADX WARN: Code duplicated, block: B:28:0x00d0  */
    /* JADX WARN: Code duplicated, block: B:29:0x00d3  */
    /* JADX WARN: Code duplicated, block: B:32:0x0123  */
    /* JADX WARN: Code duplicated, block: B:46:0x0177 A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:50:0x0177 A[SYNTHETIC] */
    void renderList() {
        LinearLayout linearLayoutCard;
        String str;
        this.tasks = OfflineDeletes.filterTasks(this, this.tasks);
        this.state = OfflineDeletes.filterState(this, this.state);
        LinearLayout linearLayout = this.list;
        if (linearLayout == null) {
            return;
        }
        linearLayout.removeAllViews();
        JSONArray jSONArrayArray = array(plan(), "ids");
        int i = 0;
        for (int i2 = 0; i2 < this.tasks.length(); i2++) {
            final JSONObject jSONObjectOptJSONObject = this.tasks.optJSONObject(i2);
            if (jSONObjectOptJSONObject != null && !jSONObjectOptJSONObject.optBoolean("completed") && jSONObjectOptJSONObject.optString("title").toLowerCase(Locale.ROOT).contains(this.query.toLowerCase(Locale.ROOT))) {
                final String strOptString = jSONObjectOptJSONObject.optString("id");
                if ("day".equals(this.tab)) {
                    if (!contains(jSONArrayArray, strOptString)) {
                        i++;
                        if (i > this.shown) {
                            linearLayoutCard = card(this.list, false);
                            linearLayoutCard.setTag("candidate:" + strOptString);
                            taskTitle(linearLayoutCard, jSONObjectOptJSONObject);
                            StringBuilder sbAppend = new StringBuilder().append(jSONObjectOptJSONObject.optString("status"));
                            if (jSONObjectOptJSONObject.optString("date").isEmpty()) {
                                str = "";
                            } else {
                                str = " · " + jSONObjectOptJSONObject.optString("date");
                            }
                            TextView textViewLabel = label(sbAppend.append(str).toString(), 14, false);
                            textViewLabel.setTextColor(muted());
                            linearLayoutCard.addView(textViewLabel);
                            linearLayoutCard.addView(button("На выбранный день", "add:" + strOptString, new Runnable() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda26
                                @Override // java.lang.Runnable
                                public final void run() {
                                    this.f$0.lambda$renderList$18(strOptString);
                                }
                            }));
                            if ("review".equals(this.tab)) {
                                pair(linearLayoutCard, button("Позже", "later:" + strOptString, new Runnable() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda27
                                    @Override // java.lang.Runnable
                                    public final void run() {
                                        this.f$0.lambda$renderList$19(strOptString);
                                    }
                                }), button("Делегировать", "delegate:" + strOptString, new Runnable() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda28
                                    @Override // java.lang.Runnable
                                    public final void run() {
                                        this.f$0.lambda$renderList$20(strOptString);
                                    }
                                }));
                                linearLayoutCard.addView(button("Удалить", "delete:" + strOptString, new Runnable() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda29
                                    @Override // java.lang.Runnable
                                    public final void run() {
                                        this.f$0.lambda$renderList$21(jSONObjectOptJSONObject);
                                    }
                                }));
                            }
                        }
                    }
                } else if (eligible(jSONObjectOptJSONObject, meta(strOptString), this.containers, this.review, today(), settings().optInt("staleDays", 14))) {
                    i++;
                    if (i > this.shown) {
                        linearLayoutCard = card(this.list, false);
                        linearLayoutCard.setTag("candidate:" + strOptString);
                        taskTitle(linearLayoutCard, jSONObjectOptJSONObject);
                        StringBuilder sbAppend2 = new StringBuilder().append(jSONObjectOptJSONObject.optString("status"));
                        if (jSONObjectOptJSONObject.optString("date").isEmpty()) {
                            str = "";
                        } else {
                            str = " · " + jSONObjectOptJSONObject.optString("date");
                        }
                        TextView textViewLabel2 = label(sbAppend2.append(str).toString(), 14, false);
                        textViewLabel2.setTextColor(muted());
                        linearLayoutCard.addView(textViewLabel2);
                        linearLayoutCard.addView(button("На выбранный день", "add:" + strOptString, new Runnable() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda26
                            @Override // java.lang.Runnable
                            public final void run() {
                                this.f$0.lambda$renderList$18(strOptString);
                            }
                        }));
                        if ("review".equals(this.tab)) {
                            pair(linearLayoutCard, button("Позже", "later:" + strOptString, new Runnable() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda27
                                @Override // java.lang.Runnable
                                public final void run() {
                                    this.f$0.lambda$renderList$19(strOptString);
                                }
                            }), button("Делегировать", "delegate:" + strOptString, new Runnable() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda28
                                @Override // java.lang.Runnable
                                public final void run() {
                                    this.f$0.lambda$renderList$20(strOptString);
                                }
                            }));
                            linearLayoutCard.addView(button("Удалить", "delete:" + strOptString, new Runnable() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda29
                                @Override // java.lang.Runnable
                                public final void run() {
                                    this.f$0.lambda$renderList$21(jSONObjectOptJSONObject);
                                }
                            }));
                        }
                    }
                }
            }
        }
        this.list.addView(label(i == 0 ? "Нет задач для этого фильтра" : "Показано " + Math.min(i, this.shown) + " из " + i, 14, false));
        if (i > this.shown) {
            this.list.addView(button("Показать ещё 20", "more", new Runnable() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda30
                @Override // java.lang.Runnable
                public final void run() {
                    this.f$0.lambda$renderList$22();
                }
            }));
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$renderList$18(String str) {
        update(command("day-add", str, this.day));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$renderList$19(String str) {
        reviewForm(str, false);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$renderList$20(String str) {
        reviewForm(str, true);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$renderList$22() {
        this.shown += 20;
        renderList();
    }

    private void settingsForm() {
        this.content.addView(label("Лимиты общие для сервиса", 18, true));
        this.content.addView(label("По умолчанию: 4 задачи в день, WIP 2, бюджет 120 минут, залеживание 14 дней.", 14, false));
        final String[] strArr = {"dailyTaskLimit", "wipLimit", "budgetMinutes", "staleDays"};
        String[] strArr2 = {"Задач в плане (1–12)", "Одновременно в работе (1–10)", "Бюджет, минут (15–1440)", "Без обновления, дней (1–180)"};
        final int[] iArr = {1, 1, 15, 1};
        final int[] iArr2 = {12, 10, 1440, 180};
        final EditText[] editTextArr = new EditText[4];
        for (int i = 0; i < 4; i++) {
            EditText editTextField = field(this.content, strArr2[i], String.valueOf(settings().optInt(strArr[i])), true);
            editTextArr[i] = editTextField;
            editTextField.setTag(strArr[i]);
        }
        this.content.addView(button("Сохранить настройки", "save-settings", new Runnable() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda8
            @Override // java.lang.Runnable
            public final void run() {
                this.f$0.lambda$settingsForm$23(editTextArr, iArr, iArr2, strArr);
            }
        }));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$settingsForm$23(EditText[] editTextArr, int[] iArr, int[] iArr2, String[] strArr) {
        JSONObject jSONObjectCommand = command("settings", null, null);
        for (int i = 0; i < 4; i++) {
            try {
                int i2 = Integer.parseInt(editTextArr[i].getText().toString());
                if (i2 < iArr[i] || i2 > iArr2[i]) {
                    throw new Exception();
                }
                jSONObjectCommand.put(strArr[i], i2);
            } catch (Exception unused) {
                editTextArr[i].setError("Введите число от " + iArr[i] + " до " + iArr2[i]);
                return;
            }
        }
        update(jSONObjectCommand);
    }

    static /* synthetic */ void lambda$reviewForm$25(String[] strArr, Button button, String str) {
        strArr[0] = str;
        button.setText("Проверить: " + str);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$reviewForm$26(final String[] strArr, final Button button, View view) {
        chooseDate(strArr[0], new Consumer() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda48
            @Override // java.util.function.Consumer
            public final void accept(Object obj) {
                TaskManagementActivity.lambda$reviewForm$25(strArr, button, (String) obj);
            }
        });
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ JSONObject lambda$reviewForm$27(JSONObject jSONObject, JSONObject jSONObject2) throws Exception {
        this.transport.request("PATCH", "/api/personal-task", jSONObject);
        this.writeConfirmed = true;
        return this.transport.request("POST", "/api/task-management", withRevision(jSONObject2));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$reviewForm$28(EditText editText, boolean z, String[] strArr, Button button, AlertDialog alertDialog, String str, View view) {
        String strTrim = editText == null ? "" : editText.getText().toString().trim();
        if (z && (strTrim.isEmpty() || strTrim.length() > 200)) {
            editText.setError("Укажите ответственного, до 200 символов");
            return;
        }
        if (strArr[0].compareTo(today()) < 0) {
            button.setError("Выберите сегодня или будущую дату");
            return;
        }
        alertDialog.dismiss();
        try {
            final JSONObject jSONObjectPut = command("review", str, null).put("disposition", z ? "waiting" : "later").put("checkDate", strArr[0]).put("owner", strTrim);
            if (!z) {
                update(jSONObjectPut);
            } else {
                final JSONObject jSONObjectPut2 = new JSONObject().put("id", str).put("status", "Delegate").put("assignees", new JSONArray().put(strTrim));
                perform(new Operation() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda46
                    @Override // com.adib.maintenance.TaskManagementActivity.Operation
                    public final JSONObject run() {
                        return this.f$0.lambda$reviewForm$27(jSONObjectPut2, jSONObjectPut);
                    }
                }, null);
            }
        } catch (Exception e) {
            error(e.getMessage());
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$reviewForm$29(final AlertDialog alertDialog, final EditText editText, final boolean z, final String[] strArr, final Button button, final String str, DialogInterface dialogInterface) {
        alertDialog.getButton(-1).setOnClickListener(new View.OnClickListener() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda0
            @Override // android.view.View.OnClickListener
            public final void onClick(View view) {
                this.f$0.lambda$reviewForm$28(editText, z, strArr, button, alertDialog, str, view);
            }
        });
    }

    private void reviewForm(final String str, final boolean z) {
        LinearLayout linearLayoutColumn = column();
        linearLayoutColumn.setPadding(m18dp(16.0f), m18dp(6.0f), m18dp(16.0f), 0);
        final EditText editTextField = z ? field(linearLayoutColumn, "Ответственный", "", false) : null;
        final String[] strArr = {nextDate()};
        final Button button = button("Проверить: " + strArr[0], "check-date", new Runnable() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda22
            @Override // java.lang.Runnable
            public final void run() {
                TaskManagementActivity.lambda$reviewForm$24();
            }
        });
        button.setOnClickListener(new View.OnClickListener() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda33
            @Override // android.view.View.OnClickListener
            public final void onClick(View view) {
                this.f$0.lambda$reviewForm$26(strArr, button, view);
            }
        });
        linearLayoutColumn.addView(button);
        final AlertDialog alertDialogCreate = dialog().setTitle(z ? "Делегировать" : "Отложить до разбора").setView(linearLayoutColumn).setNegativeButton("Отмена", (DialogInterface.OnClickListener) null).setPositiveButton("Сохранить", (DialogInterface.OnClickListener) null).create();
        alertDialogCreate.setOnShowListener(new DialogInterface.OnShowListener() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda43
            @Override // android.content.DialogInterface.OnShowListener
            public final void onShow(DialogInterface dialogInterface) {
                this.f$0.lambda$reviewForm$29(alertDialogCreate, editTextField, z, strArr, button, str, dialogInterface);
            }
        });
        alertDialogCreate.show();
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: confirmDelete, reason: merged with bridge method [inline-methods] */
    public void lambda$renderList$21(final JSONObject jSONObject) {
        dialog().setTitle("Удалить задачу?").setMessage(jSONObject.optString("title") + "\nЗадача исчезнет на устройстве. Удаление в Notion будет отправлено при появлении связи.").setNegativeButton("Отмена", (DialogInterface.OnClickListener) null).setPositiveButton("Удалить", new DialogInterface.OnClickListener() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda25
            @Override // android.content.DialogInterface.OnClickListener
            public final void onClick(DialogInterface dialogInterface, int i) {
                this.f$0.lambda$confirmDelete$30(jSONObject, dialogInterface, i);
            }
        }).show();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$confirmDelete$30(JSONObject jSONObject, DialogInterface dialogInterface, int i) {
        try {
            OfflineDeletes.enqueue(this, jSONObject, true, "");
            this.tasks = OfflineDeletes.filterTasks(this, this.tasks);
            this.state = OfflineDeletes.filterState(this, this.state);
            setResult(-1);
            render();
            status("Удалено на устройстве", false);
        } catch (Exception e) {
            error(e.getMessage());
        }
    }

    private JSONObject withRevision(JSONObject jSONObject) throws JSONException {
        return jSONObject.put("expectedRevision", this.state.optInt("revision"));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ JSONObject lambda$update$31(JSONObject jSONObject) throws Exception {
        return this.transport.request("POST", "/api/task-management", jSONObject);
    }

    void update(final JSONObject jSONObject) {
        try {
            withRevision(jSONObject);
            perform(new Operation() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda2
                @Override // com.adib.maintenance.TaskManagementActivity.Operation
                public final JSONObject run() {
                    return this.f$0.lambda$update$31(jSONObject);
                }
            }, null);
        } catch (Exception e) {
            error(e.getMessage());
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ JSONObject lambda$startTask$32(JSONObject jSONObject) throws Exception {
        return this.transport.request("PATCH", "/api/personal-task", jSONObject);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$startTask$33(String str) {
        startTask(str, true);
    }

    void startTask(final String str, boolean z) {
        try {
            final JSONObject jSONObjectPut = new JSONObject().put("id", str).put("status", "In progress");
            if (z) {
                jSONObjectPut.put("wipOverride", true);
            }
            perform(new Operation() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda10
                @Override // com.adib.maintenance.TaskManagementActivity.Operation
                public final JSONObject run() {
                    return this.f$0.lambda$startTask$32(jSONObjectPut);
                }
            }, new Runnable() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda12
                @Override // java.lang.Runnable
                public final void run() {
                    this.f$0.lambda$startTask$33(str);
                }
            });
        } catch (Exception e) {
            error(e.getMessage());
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: finishTask, reason: merged with bridge method [inline-methods] */
    public void lambda$dayCard$14(String str) {
        try {
            final JSONObject jSONObjectPut = new JSONObject().put("id", str).put("status", "Done").put("completed", true);
            perform(new Operation() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda31
                @Override // com.adib.maintenance.TaskManagementActivity.Operation
                public final JSONObject run() {
                    return this.f$0.lambda$finishTask$34(jSONObjectPut);
                }
            }, null);
        } catch (Exception e) {
            error(e.getMessage());
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ JSONObject lambda$finishTask$34(JSONObject jSONObject) throws Exception {
        return this.transport.request("PATCH", "/api/personal-task", jSONObject);
    }

    private void restorePlannerCache() {
        JSONObject jSONObject = PlannerCache.read(this);
        JSONObject jSONObjectOptJSONObject = jSONObject.optJSONObject("personal");
        JSONObject jSONObjectOptJSONObject2 = jSONObject.optJSONObject("state");
        if (jSONObjectOptJSONObject == null || jSONObjectOptJSONObject.optJSONArray("tasks") == null) {
            return;
        }
        this.havePersonalCache = true;
        this.tasks = array(jSONObjectOptJSONObject, "tasks");
        this.containers = array(jSONObjectOptJSONObject, "containers");
        try {
            validate(jSONObjectOptJSONObject2, jSONObjectOptJSONObject);
            this.state = jSONObjectOptJSONObject2;
        } catch (Exception unused) {
        }
    }

    private void updateFeedback() {
        int iMuted;
        int i;
        int i2;
        if (this.feedback == null) {
            return;
        }
        String strSummary = OfflineDeletes.summary(this);
        this.feedback.setText(this.statusText + (strSummary.isEmpty() ? "" : " · " + strSummary));
        TextView textView = this.feedback;
        if (this.statusError) {
            if (this.dark) {
                i = 255;
                i2 = 148;
            } else {
                i = 184;
                i2 = 30;
            }
            iMuted = Color.rgb(i, i2, i2);
        } else {
            iMuted = muted();
        }
        textView.setTextColor(iMuted);
        this.feedback.setVisibility((this.statusText.isEmpty() && strSummary.isEmpty()) ? 8 : 0);
    }

    private void status(String str, boolean z) {
        this.statusText = str;
        this.statusError = z;
        updateFeedback();
    }

    private boolean mutationTag(String str) {
        return str.equals("save-settings") || str.matches("^(add|main|start|finish|remove|estimate|later|delegate|delete):.*");
    }

    private boolean allowed(String str) {
        if (str.startsWith("delete:")) {
            return !this.busy && this.havePersonalCache;
        }
        return !this.busy && !(str.equals("refresh") && this.refreshing) && (!mutationTag(str) || (this.fresh && !this.refreshing));
    }

    private void syncControls(View view) {
        if (view instanceof Button) {
            view.setEnabled(allowed(String.valueOf(view.getTag())));
            view.setAlpha(view.isEnabled() ? 1.0f : 0.45f);
        } else if ((view instanceof EditText) || (view instanceof Spinner)) {
            view.setEnabled(!this.busy);
        }
        if (!(view instanceof ViewGroup)) {
            return;
        }
        int i = 0;
        while (true) {
            ViewGroup viewGroup = (ViewGroup) view;
            if (i >= viewGroup.getChildCount()) {
                return;
            }
            syncControls(viewGroup.getChildAt(i));
            i++;
        }
    }

    private View findTag(View view, String str) {
        if (str.equals(view.getTag())) {
            return view;
        }
        if (!(view instanceof ViewGroup)) {
            return null;
        }
        int i = 0;
        while (true) {
            ViewGroup viewGroup = (ViewGroup) view;
            if (i >= viewGroup.getChildCount()) {
                return null;
            }
            View viewFindTag = findTag(viewGroup.getChildAt(i), str);
            if (viewFindTag != null) {
                return viewFindTag;
            }
            i++;
        }
    }

    private void applyPair(Pair pair) {
        View viewFindTag;
        ScrollView scrollView = this.scroll;
        final int scrollY = scrollView == null ? 0 : scrollView.getScrollY();
        LinearLayout linearLayout = this.root;
        View viewFindTag2 = linearLayout == null ? null : findTag(linearLayout, "search");
        boolean z = viewFindTag2 != null && viewFindTag2.hasFocus();
        int selectionStart = viewFindTag2 instanceof EditText ? ((EditText) viewFindTag2).getSelectionStart() : 0;
        HashMap map = new HashMap();
        String[] strArr = {"dailyTaskLimit", "wipLimit", "budgetMinutes", "staleDays"};
        String str = "";
        int i = 0;
        for (int i2 = 4; i < i2; i2 = 4) {
            String str2 = strArr[i];
            LinearLayout linearLayout2 = this.root;
            View viewFindTag3 = linearLayout2 == null ? null : findTag(linearLayout2, str2);
            if (viewFindTag3 instanceof EditText) {
                String string = ((EditText) viewFindTag3).getText().toString();
                if (!string.equals(String.valueOf(settings().optInt(str2)))) {
                    map.put(str2, string);
                }
                if (viewFindTag3.hasFocus()) {
                    str = str2;
                }
            }
            i++;
        }
        this.state = OfflineDeletes.filterState(this, pair.state);
        this.tasks = OfflineDeletes.filterTasks(this, array(pair.personal, "tasks"));
        this.containers = array(pair.personal, "containers");
        this.havePersonalCache = true;
        this.fresh = true;
        this.refreshing = false;
        this.busy = false;
        this.statusText = "Обновлено";
        this.statusError = false;
        render();
        for (Map.Entry entry : map.entrySet()) {
            View viewFindTag4 = findTag(this.root, (String) entry.getKey());
            if (viewFindTag4 instanceof EditText) {
                ((EditText) viewFindTag4).setText((CharSequence) entry.getValue());
            }
        }
        if (z) {
            EditText editText = (EditText) findTag(this.root, "search");
            if (editText != null) {
                editText.requestFocus();
                editText.setSelection(Math.max(0, Math.min(selectionStart, editText.length())));
            }
        } else if (!str.isEmpty() && (viewFindTag = findTag(this.root, str)) != null) {
            viewFindTag.requestFocus();
        }
        final ScrollView scrollView2 = this.scroll;
        if (scrollView2 != null) {
            scrollView2.getViewTreeObserver().addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() { // from class: com.adib.maintenance.TaskManagementActivity.4
                @Override // android.view.ViewTreeObserver.OnGlobalLayoutListener
                public void onGlobalLayout() {
                    scrollView2.getViewTreeObserver().removeOnGlobalLayoutListener(this);
                    if (TaskManagementActivity.this.alive()) {
                        ScrollView scrollView3 = TaskManagementActivity.this.scroll;
                        ScrollView scrollView4 = scrollView2;
                        if (scrollView3 == scrollView4) {
                            scrollView4.scrollTo(0, scrollY);
                        }
                    }
                }
            });
        }
    }

    static final class Pair {
        final JSONObject personal;
        final long personalFetchedAt;
        final JSONObject state;

        Pair(JSONObject jSONObject, JSONObject jSONObject2, long j) {
            this.state = jSONObject;
            this.personal = jSONObject2;
            this.personalFetchedAt = j;
        }
    }

    static void validate(JSONObject jSONObject, JSONObject jSONObject2) throws ApiError {
        if (jSONObject == null || jSONObject.optInt("version") != 1 || jSONObject.optJSONObject("settings") == null || jSONObject.optJSONObject("tasks") == null || jSONObject.optJSONObject("days") == null || jSONObject2 == null || jSONObject2.optJSONArray("tasks") == null) {
            throw new ApiError("Нужен обновлённый сервер ADIB.", "INVALID_SNAPSHOT", 502);
        }
    }

    private Pair fetchPair(final long j, final boolean z, boolean z2) throws Exception {
        JSONObject jSONObject = z2 ? PlannerCache.read(this) : new JSONObject();
        long jOptLong = jSONObject.optLong("personalFetchedAt");
        long jCurrentTimeMillis = System.currentTimeMillis() - jOptLong;
        final JSONObject jSONObjectOptJSONObject = jSONObject.optJSONObject("personal");
        final boolean z3 = z2 && jOptLong > 0 && jCurrentTimeMillis >= 0 && jCurrentTimeMillis <= 15000 && jSONObjectOptJSONObject != null && jSONObjectOptJSONObject.optJSONArray("tasks") != null;
        if (!z3) {
            jOptLong = 0;
        }
        final AtomicLong atomicLong = new AtomicLong(jOptLong);
        Future futureSubmit = this.fetchIO.submit(new Callable() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda5
            @Override // java.util.concurrent.Callable
            public final Object call() {
                return this.f$0.lambda$fetchPair$36(z, j);
            }
        });
        Future futureSubmit2 = this.fetchIO.submit(new Callable() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda6
            @Override // java.util.concurrent.Callable
            public final Object call() {
                return this.f$0.lambda$fetchPair$37(z3, jSONObjectOptJSONObject, atomicLong);
            }
        });
        try {
            JSONObject jSONObject2 = (JSONObject) futureSubmit.get();
            JSONObject jSONObject3 = (JSONObject) futureSubmit2.get();
            validate(jSONObject2, jSONObject3);
            return new Pair(jSONObject2, jSONObject3, atomicLong.get());
        } catch (Exception e) {
            futureSubmit.cancel(true);
            futureSubmit2.cancel(true);
            Throwable cause = e instanceof ExecutionException ? e.getCause() : e;
            if (cause instanceof Exception) {
                throw ((Exception) cause);
            }
            throw e;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$fetchPair$35(long j, JSONObject jSONObject) {
        if (alive() && j == this.generation && this.state == null && this.havePersonalCache) {
            try {
                validate(jSONObject, new JSONObject().put("tasks", this.tasks));
                this.state = jSONObject;
                this.statusText = "Обновляю… Показан сохранённый список задач.";
                render();
            } catch (Exception unused) {
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ JSONObject lambda$fetchPair$36(boolean z, final long j) throws Exception {
        final JSONObject jSONObjectRequest = this.transport.request("GET", "/api/task-management", null);
        if (z) {
            runOnUiThread(new Runnable() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda1
                @Override // java.lang.Runnable
                public final void run() {
                    this.f$0.lambda$fetchPair$35(j, jSONObjectRequest);
                }
            });
        }
        return jSONObjectRequest;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ JSONObject lambda$fetchPair$37(boolean z, JSONObject jSONObject, AtomicLong atomicLong) throws Exception {
        if (z) {
            return jSONObject;
        }
        JSONObject jSONObjectRequest = this.transport.request("GET", "/api/personal-snapshot", null);
        atomicLong.set(System.currentTimeMillis());
        return jSONObjectRequest;
    }

    private void error(String str) {
        boolean z;
        if (OfflineNetwork.error(str)) {
            str = OfflineNetwork.message();
            z = false;
        } else {
            if (str == null) {
                str = "Не удалось загрузить или сохранить. Нажмите «Обновить».";
            }
            z = true;
        }
        status(str, z);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$perform$38(long j, Pair pair) {
        if (alive() && j == this.generation) {
            applyPair(pair);
            setResult(-1);
            status("Сохранено", false);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$perform$39(DialogInterface dialogInterface, int i) {
        status("Изменение отменено", false);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$perform$41(long j, Exception exc, final Runnable runnable) {
        String message;
        if (alive() && j == this.generation) {
            this.busy = false;
            if ((exc instanceof ApiError) && "WIP_LIMIT".equals(((ApiError) exc).code) && runnable != null) {
                syncControls(this.content);
                dialog().setTitle("Лимит задач в работе").setMessage(exc.getMessage() + "\nВсё равно начать?").setNegativeButton("Отмена", new DialogInterface.OnClickListener() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda13
                    @Override // android.content.DialogInterface.OnClickListener
                    public final void onClick(DialogInterface dialogInterface, int i) {
                        this.f$0.lambda$perform$39(dialogInterface, i);
                    }
                }).setPositiveButton("Начать всё равно", new DialogInterface.OnClickListener() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda14
                    @Override // android.content.DialogInterface.OnClickListener
                    public final void onClick(DialogInterface dialogInterface, int i) {
                        runnable.run();
                    }
                }).show();
                return;
            }
            if (this.writeConfirmed) {
                this.fresh = false;
                PlannerCache.invalidate(this);
                setResult(-1);
                message = "Часть изменений уже сохранена. Нажмите «Обновить», чтобы проверить состояние. " + exc.getMessage();
            } else {
                message = exc.getMessage();
            }
            error(message);
            syncControls(this.content);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$perform$42(Operation operation, final long j, final Runnable runnable) {
        try {
            operation.run();
            this.writeConfirmed = true;
            PlannerCache.invalidate(this);
            final Pair pairFetchPair = fetchPair(j, false, false);
            PlannerCache.rememberPair(this, pairFetchPair.state, pairFetchPair.personal, pairFetchPair.personalFetchedAt);
            runOnUiThread(new Runnable() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda32
                @Override // java.lang.Runnable
                public final void run() {
                    this.f$0.lambda$perform$38(j, pairFetchPair);
                }
            });
        } catch (Exception e) {
            runOnUiThread(new Runnable() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda34
                @Override // java.lang.Runnable
                public final void run() {
                    this.f$0.lambda$perform$41(j, e, runnable);
                }
            });
        }
    }

    private void perform(final Operation operation, final Runnable runnable) {
        if (this.busy || this.refreshing || !this.fresh || this.state == null) {
            return;
        }
        this.busy = true;
        this.writeConfirmed = false;
        final long j = this.generation + 1;
        this.generation = j;
        syncControls(this.content);
        status("Сохраняю…", false);
        this.f29io.execute(new Runnable() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda3
            @Override // java.lang.Runnable
            public final void run() {
                this.f$0.lambda$perform$42(operation, j, runnable);
            }
        });
    }

    void reload() {
        reload(true);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$reload$43(long j, Pair pair) {
        if (alive() && j == this.generation) {
            applyPair(pair);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$reload$44(long j, Exception exc) {
        if (alive() && j == this.generation) {
            this.refreshing = false;
            this.fresh = false;
            error(((this.state != null || this.havePersonalCache) ? "Не удалось обновить. Сохранённые данные оставлены на экране. Изменения пока недоступны. " : "Не удалось загрузить. Проверьте интернет и обновление сервера. ") + exc.getMessage());
            syncControls(this.content);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$reload$45(final long j, boolean z) {
        try {
            final Pair pairFetchPair = fetchPair(j, true, !z);
            PlannerCache.rememberPair(this, pairFetchPair.state, pairFetchPair.personal, pairFetchPair.personalFetchedAt);
            runOnUiThread(new Runnable() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda21
                @Override // java.lang.Runnable
                public final void run() {
                    this.f$0.lambda$reload$43(j, pairFetchPair);
                }
            });
        } catch (Exception e) {
            runOnUiThread(new Runnable() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda23
                @Override // java.lang.Runnable
                public final void run() {
                    this.f$0.lambda$reload$44(j, e);
                }
            });
        }
    }

    private void reload(final boolean z) {
        if (this.busy || this.refreshing) {
            return;
        }
        this.refreshing = true;
        final long j = this.generation + 1;
        this.generation = j;
        syncControls(this.content);
        status(this.state != null ? "Обновляю… Показаны сохранённые данные." : "Загружаю план…", false);
        this.f29io.execute(new Runnable() { // from class: com.adib.maintenance.TaskManagementActivity$$ExternalSyntheticLambda24
            @Override // java.lang.Runnable
            public final void run() {
                this.f$0.lambda$reload$45(j, z);
            }
        });
    }

    static JSONObject http(String str, String str2, JSONObject jSONObject) throws Exception {
        return httpWithTimeout(str, str2, jSONObject, 15000);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static JSONObject httpWithTimeout(String str, String str2, JSONObject jSONObject, int i) throws Exception {
        if (DirectRuntime.enabled()) {
            return DirectRuntime.request(str, str2, jSONObject);
        }
        HttpURLConnection httpURLConnection = null;
        try {
            HttpURLConnection httpURLConnection2 = (HttpURLConnection) new URL(BuildConfig.APP_BASE_URL.replaceAll("/$", "") + str2).openConnection();
            try {
                httpURLConnection2.setRequestMethod(str);
                httpURLConnection2.setConnectTimeout(15000);
                httpURLConnection2.setReadTimeout(i);
                httpURLConnection2.setRequestProperty("Accept", "application/json");
                if (jSONObject != null) {
                    httpURLConnection2.setDoOutput(true);
                    httpURLConnection2.setRequestProperty("Content-Type", "application/json; charset=utf-8");
                    OutputStream outputStream = httpURLConnection2.getOutputStream();
                    try {
                        outputStream.write(jSONObject.toString().getBytes(StandardCharsets.UTF_8));
                        if (outputStream != null) {
                            outputStream.close();
                        }
                    } catch (Throwable th) {
                        if (outputStream != null) {
                            try {
                                outputStream.close();
                            } catch (Throwable th2) {
                                th.addSuppressed(th2);
                            }
                        }
                        throw th;
                    }
                }
                int responseCode = httpURLConnection2.getResponseCode();
                InputStream errorStream = responseCode >= 400 ? httpURLConnection2.getErrorStream() : httpURLConnection2.getInputStream();
                if (errorStream != null) {
                    StringBuilder sb = new StringBuilder();
                    BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(errorStream, StandardCharsets.UTF_8));
                    while (true) {
                        try {
                            String line = bufferedReader.readLine();
                            if (line == null) {
                                break;
                            }
                            sb.append(line);
                        } catch (Throwable th3) {
                            try {
                                bufferedReader.close();
                            } catch (Throwable th4) {
                                th3.addSuppressed(th4);
                            }
                            throw th3;
                        }
                        th = th;
                        httpURLConnection = httpURLConnection2;
                        if (httpURLConnection != null) {
                            httpURLConnection.disconnect();
                        }
                        throw th;
                    }
                    bufferedReader.close();
                    try {
                        JSONObject jSONObject2 = new JSONObject(sb.toString());
                        if (responseCode >= 400) {
                            throw new ApiError(jSONObject2.optString("error", "HTTP " + responseCode), jSONObject2.optString("code"), responseCode);
                        }
                        if (httpURLConnection2 != null) {
                            httpURLConnection2.disconnect();
                        }
                        return jSONObject2;
                    } catch (Exception unused) {
                        throw new ApiError("Ответ сервера не распознан. Нужен обновлённый сервер ADIB.", "", responseCode);
                    }
                }
                throw new ApiError("Сервер вернул пустой ответ", "", responseCode);
            } catch (Throwable th5) {
                th = th5;
                httpURLConnection = httpURLConnection2;
            }
        } catch (Throwable th6) {
            th = th6;
        }
    }
}
