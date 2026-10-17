package com.adib.maintenance;

import android.app.Activity;
import android.app.DatePickerDialog;
import android.app.TimePickerDialog;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.GridLayout;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;
import android.widget.TimePicker;
import android.widget.Toast;
import java.lang.ref.WeakReference;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Locale;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public final class TaskReminderActivity extends Activity {
    static final String COMPLETE = "com.adib.maintenance.REMINDER_COMPLETE";
    static final String OPEN = "com.adib.maintenance.REMINDER_OPEN";
    static final String SNOOZE = "com.adib.maintenance.REMINDER_SNOOZE";
    static final String START = "com.adib.maintenance.REMINDER_START";
    boolean busy;
    Button complete;
    LinearLayout content;
    boolean dark;
    boolean done;
    String page;
    Intent queuedIntent;
    LinearLayout root;
    Button snooze;
    Button start;
    TextView status;
    JSONObject task;
    TaskReminderActions.Transport transport;
    static WeakReference<TaskReminderActivity> visible = new WeakReference<>(null);

    /* JADX INFO: renamed from: IO */
    static final ExecutorService f30IO = Executors.newSingleThreadExecutor();

    interface Each {
        void apply(View view);
    }

    public TaskReminderActivity() {
        this.transport = Boolean.getBoolean("adib.testing") ? new TaskReminderActions.Transport() { // from class: com.adib.maintenance.TaskReminderActivity$$ExternalSyntheticLambda6
            @Override // com.adib.maintenance.TaskReminderActions.Transport
            public final JSONObject request(String str, String str2, JSONObject jSONObject) {
                return TaskReminderActivity.lambda$new$0(str, str2, jSONObject);
            }
        } : new TaskCalendarActivity$$ExternalSyntheticLambda1();
        this.busy = false;
        this.done = false;
        this.page = "card";
    }

    static boolean cardVisible() {
        TaskReminderActivity taskReminderActivity = visible.get();
        return (taskReminderActivity == null || taskReminderActivity.isFinishing() || taskReminderActivity.isDestroyed() || LockscreenReminder.locked(taskReminderActivity)) ? false : true;
    }

    static boolean handles(Context context, String str) {
        JSONObject jSONObject;
        TaskReminderActivity taskReminderActivity = visible.get();
        if (cardVisible() && taskReminderActivity.hasWindowFocus() && (jSONObject = taskReminderActivity.task) != null && str.equals(jSONObject.optString("id"))) {
            return !taskReminderActivity.task.has("scope") || DirectConfig.scope(context).equals(taskReminderActivity.task.optString("scope"));
        }
        return false;
    }

    @Override // android.app.Activity
    protected void onResume() {
        super.onResume();
        visible = new WeakReference<>(this);
    }

    @Override // android.app.Activity
    protected void onPause() {
        if (visible.get() == this) {
            visible = new WeakReference<>(null);
        }
        super.onPause();
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public void onWindowFocusChanged(boolean z) {
        super.onWindowFocusChanged(z);
        if (!z || this.task == null || LockscreenReminder.locked(this)) {
            return;
        }
        PendingReminderPopups.consume(this, this.task.optString("id"));
        ReminderPopupService.resumePending(this);
    }

    @Override // android.app.Activity
    protected void onDestroy() {
        if (visible.get() == this) {
            visible = new WeakReference<>(null);
        }
        ReminderPopupService.resumePending(getApplicationContext());
        super.onDestroy();
    }

    static /* synthetic */ JSONObject lambda$new$0(String str, String str2, JSONObject jSONObject) throws Exception {
        throw new IllegalStateException("Use a fixture transport");
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$button$1(Runnable runnable, View view) {
        if (this.busy) {
            return;
        }
        runnable.run();
    }

    Button button(String str, boolean z, final Runnable runnable) {
        Button button = new Button(this);
        button.setText(str);
        HybridUi.button(button, this.dark, z);
        button.setOnClickListener(new View.OnClickListener() { // from class: com.adib.maintenance.TaskReminderActivity$$ExternalSyntheticLambda15
            @Override // android.view.View.OnClickListener
            public final void onClick(View view) {
                this.f$0.lambda$button$1(runnable, view);
            }
        });
        return button;
    }

    /* JADX INFO: renamed from: dp */
    int m19dp(int i) {
        return NativeImageSupport.m8dp(this, i);
    }

    TextView text(String str, int i) {
        TextView textView = new TextView(this);
        textView.setText(str);
        textView.setTextSize(i);
        textView.setTextColor(HybridUi.text(this.dark));
        return textView;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$onCreate$2() {
        perform(false);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$onCreate$3() {
        perform(true);
    }

    @Override // android.app.Activity
    public void onCreate(Bundle bundle) {
        boolean z = getSharedPreferences(TaskManagementActivity.mainPreferencesName(this), 0).getBoolean("dark_theme", false);
        this.dark = z;
        setTheme(z ? C0031R.style.QuickPopupDark : C0031R.style.QuickPopupLight);
        super.onCreate(bundle);
        configureLockscreen(getIntent());
        getWindow().setBackgroundDrawableResource(android.R.color.transparent);
        getWindow().setSoftInputMode(16);
        setFinishOnTouchOutside(false);
        this.task = TaskReminderReceiver.reference(this, getIntent().getStringExtra("task_id"));
        if (getIntent().getBooleanExtra("test_popup", false)) {
            this.task = TaskReminderReceiver.testTask();
        }
        JSONObject jSONObject = this.task;
        if (jSONObject != null) {
            ReminderPopupService.dismissMatching(jSONObject.optString("id"));
        }
        if (bundle != null) {
            this.page = bundle.getString("page", "card");
            this.done = bundle.getBoolean("done", false);
        }
        render();
        fitWindow();
        if (bundle != null || this.task == null) {
            return;
        }
        String action = getIntent().getAction();
        if (SNOOZE.equals(action)) {
            this.page = "snooze";
            render();
        } else if (START.equals(action)) {
            getWindow().getDecorView().post(new Runnable() { // from class: com.adib.maintenance.TaskReminderActivity$$ExternalSyntheticLambda7
                @Override // java.lang.Runnable
                public final void run() {
                    this.f$0.lambda$onCreate$2();
                }
            });
        } else if (COMPLETE.equals(action)) {
            getWindow().getDecorView().post(new Runnable() { // from class: com.adib.maintenance.TaskReminderActivity$$ExternalSyntheticLambda8
                @Override // java.lang.Runnable
                public final void run() {
                    this.f$0.lambda$onCreate$3();
                }
            });
        }
    }

    @Override // android.app.Activity
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        if (this.busy) {
            this.queuedIntent = new Intent(intent);
        } else {
            receive(intent);
        }
    }

    void receive(Intent intent) {
        this.busy = false;
        setIntent(intent);
        configureLockscreen(intent);
        this.task = TaskReminderReceiver.reference(this, intent.getStringExtra("task_id"));
        if (intent.getBooleanExtra("test_popup", false)) {
            this.task = TaskReminderReceiver.testTask();
        }
        JSONObject jSONObject = this.task;
        if (jSONObject != null) {
            ReminderPopupService.dismissMatching(jSONObject.optString("id"));
        }
        this.done = false;
        this.page = SNOOZE.equals(intent.getAction()) ? "snooze" : "card";
        render();
        if (this.task != null) {
            if (START.equals(intent.getAction())) {
                perform(false);
            } else if (COMPLETE.equals(intent.getAction())) {
                perform(true);
            }
        }
    }

    void processQueued() {
        Intent intent = this.queuedIntent;
        if (intent != null) {
            this.queuedIntent = null;
            receive(intent);
        }
    }

    @Override // android.app.Activity
    protected void onSaveInstanceState(Bundle bundle) {
        super.onSaveInstanceState(bundle);
        bundle.putString("page", this.page);
        bundle.putBoolean("done", this.done);
    }

    void configureLockscreen(Intent intent) {
        boolean z = false;
        if (intent != null && intent.getBooleanExtra("lockscreen_reminder", false) && LockscreenReminder.enabled(this) && LockscreenReminder.allowed(this)) {
            z = true;
        }
        if (Build.VERSION.SDK_INT >= 27) {
            setShowWhenLocked(z);
            setTurnScreenOn(z);
        } else {
            Window window = getWindow();
            if (z) {
                window.addFlags(2621440);
            } else {
                window.clearFlags(2621440);
            }
        }
        if (z) {
            TaskReminderReceiver.event(this, "Карточка полноэкранного напоминания открыта");
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$render$4() {
        this.page = "card";
        render();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$render$5() {
        JSONObject jSONObject = this.task;
        if (jSONObject != null) {
            TaskReminderReceiver.dismiss(this, jSONObject.optString("id"));
        }
        finish();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$render$6() {
        TaskReminderReceiver.openExactSettings(this);
    }

    void render() {
        if (this.task != null && !"snooze".equals(this.page)) {
            renderCompact();
            return;
        }
        LinearLayout linearLayout = new LinearLayout(this);
        this.root = linearLayout;
        linearLayout.setOrientation(1);
        this.root.setPadding(m19dp(18), m19dp(16), m19dp(18), m19dp(18));
        this.root.setBackground(HybridUi.rounded(HybridUi.surface(this.dark), m19dp(22), HybridUi.border(this.dark), m19dp(1)));
        LinearLayout linearLayout2 = new LinearLayout(this);
        linearLayout2.setGravity(16);
        Button button = button("←", false, new Runnable() { // from class: com.adib.maintenance.TaskReminderActivity$$ExternalSyntheticLambda18
            @Override // java.lang.Runnable
            public final void run() {
                this.f$0.lambda$render$4();
            }
        });
        if ("snooze".equals(this.page)) {
            linearLayout2.addView(button, new LinearLayout.LayoutParams(m19dp(44), m19dp(48)));
        }
        linearLayout2.addView(text("snooze".equals(this.page) ? "Отсрочка" : "Напоминание · ADIB", 16), new LinearLayout.LayoutParams(0, -2, 1.0f));
        Button button2 = button("×", false, new Runnable() { // from class: com.adib.maintenance.TaskReminderActivity$$ExternalSyntheticLambda19
            @Override // java.lang.Runnable
            public final void run() {
                this.f$0.lambda$render$5();
            }
        });
        button2.setContentDescription("Закрыть напоминание");
        button2.setTag("reminder-close");
        linearLayout2.addView(button2, new LinearLayout.LayoutParams(m19dp(44), m19dp(48)));
        this.root.addView(linearLayout2);
        ScrollView scrollView = new ScrollView(this);
        LinearLayout linearLayout3 = new LinearLayout(this);
        this.content = linearLayout3;
        linearLayout3.setOrientation(1);
        scrollView.addView(this.content);
        this.root.addView(scrollView, new LinearLayout.LayoutParams(-1, 0, 1.0f));
        JSONObject jSONObject = this.task;
        if (jSONObject == null) {
            this.content.addView(text("Напоминание больше недоступно. Откройте задачу в ADIB.", 16));
            setContentView(this.root);
            return;
        }
        TextView textViewText = text(jSONObject.optString("title", "Задача"), 25);
        textViewText.setTypeface(null, 1);
        textViewText.setPadding(0, m19dp(12), 0, m19dp(12));
        textViewText.setTag("reminder-title");
        this.content.addView(textViewText);
        String strOptString = this.task.optString("date", "");
        TextView textViewText2 = text(strOptString.isEmpty() ? "Локальное напоминание" : "Дата задачи: " + strOptString.replace('T', ' '), 13);
        textViewText2.setTextColor(HybridUi.muted(this.dark));
        this.content.addView(textViewText2);
        if (!TaskReminderReceiver.exactAllowed(this)) {
            Button button3 = button("Разрешить точные напоминания", false, new Runnable() { // from class: com.adib.maintenance.TaskReminderActivity$$ExternalSyntheticLambda20
                @Override // java.lang.Runnable
                public final void run() {
                    this.f$0.lambda$render$6();
                }
            });
            button3.setTextSize(11.0f);
            this.content.addView(button3);
        }
        TextView textViewText3 = text(this.done ? "Задача завершена" : "", 13);
        this.status = textViewText3;
        textViewText3.setTag("reminder-status");
        this.status.setPadding(0, m19dp(12), 0, m19dp(8));
        this.status.setAccessibilityLiveRegion(1);
        this.content.addView(this.status);
        if (this.task.optBoolean("test")) {
            this.content.addView(text("Тест окна. Задачи не изменяются.", 14));
            this.content.addView(button("Закрыть тест", true, new Runnable() { // from class: com.adib.maintenance.TaskReminderActivity$$ExternalSyntheticLambda21
                @Override // java.lang.Runnable
                public final void run() {
                    this.f$0.finish();
                }
            }));
            setContentView(this.root);
            fitWindow();
            return;
        }
        if ("snooze".equals(this.page)) {
            GridLayout gridLayout = new GridLayout(this);
            gridLayout.setColumnCount(2);
            String[] strArr = {"15 мин.", "30 мин.", "1 час", "3 часа", "Завтра, 09:00", "Сегодня вечером", "Следующий час", "Выбрать время…"};
            for (final int i = 0; i < 8; i++) {
                Button button4 = button(strArr[i], false, new Runnable() { // from class: com.adib.maintenance.TaskReminderActivity$$ExternalSyntheticLambda1
                    @Override // java.lang.Runnable
                    public final void run() {
                        this.f$0.lambda$render$7(i);
                    }
                });
                button4.setTag("snooze:" + i);
                button4.setTextSize(12.0f);
                GridLayout.LayoutParams layoutParams = new GridLayout.LayoutParams(GridLayout.spec(i / 2), GridLayout.spec(i % 2, 1.0f));
                layoutParams.width = 0;
                layoutParams.setMargins(m19dp(3), m19dp(3), m19dp(3), m19dp(3));
                gridLayout.addView(button4, layoutParams);
            }
            this.content.addView(gridLayout);
            Button button5 = button("Изменить дату задачи…", false, new Runnable() { // from class: com.adib.maintenance.TaskReminderActivity$$ExternalSyntheticLambda2
                @Override // java.lang.Runnable
                public final void run() {
                    this.f$0.lambda$render$8();
                }
            });
            button5.setTag("reminder-change-date");
            this.content.addView(button5);
        } else {
            LinearLayout linearLayout4 = new LinearLayout(this);
            Button button6 = button("Отсрочка", false, new Runnable() { // from class: com.adib.maintenance.TaskReminderActivity$$ExternalSyntheticLambda3
                @Override // java.lang.Runnable
                public final void run() {
                    this.f$0.lambda$render$9();
                }
            });
            this.snooze = button6;
            button6.setTag("reminder-snooze");
            Button button7 = button("Завершить", false, new Runnable() { // from class: com.adib.maintenance.TaskReminderActivity$$ExternalSyntheticLambda4
                @Override // java.lang.Runnable
                public final void run() {
                    this.f$0.lambda$render$10();
                }
            });
            this.complete = button7;
            button7.setTag("reminder-complete");
            linearLayout4.addView(this.snooze, new LinearLayout.LayoutParams(0, -2, 1.0f));
            LinearLayout.LayoutParams layoutParams2 = new LinearLayout.LayoutParams(0, -2, 1.0f);
            layoutParams2.leftMargin = m19dp(8);
            linearLayout4.addView(this.complete, layoutParams2);
            this.content.addView(linearLayout4);
            Button button8 = button("▶ Начать Помидор", true, new Runnable() { // from class: com.adib.maintenance.TaskReminderActivity$$ExternalSyntheticLambda5
                @Override // java.lang.Runnable
                public final void run() {
                    this.f$0.lambda$render$11();
                }
            });
            this.start = button8;
            button8.setTag("reminder-start");
            LinearLayout.LayoutParams layoutParams3 = new LinearLayout.LayoutParams(-1, -2);
            layoutParams3.topMargin = m19dp(10);
            this.content.addView(this.start, layoutParams3);
            if (this.done) {
                this.complete.setEnabled(false);
                this.start.setEnabled(false);
                this.snooze.setEnabled(false);
            }
        }
        setContentView(this.root);
        lock(this.busy);
        fitWindow();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$render$7(int i) {
        if (i == 7) {
            pickTime(false);
        } else {
            snoozeAt(preset(i, System.currentTimeMillis()));
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$render$8() {
        pickTime(true);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$render$10() {
        perform(true);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$render$11() {
        perform(false);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$render$9() {
        this.page = "snooze";
        render();
    }

    void renderCompact() {
        String str;
        LinearLayout linearLayoutCreate = ReminderCardView.create(this, this.task, this.dark, "reminder-", new ReminderCardView.Actions() { // from class: com.adib.maintenance.TaskReminderActivity.1
            @Override // com.adib.maintenance.ReminderCardView.Actions
            public void close() {
                TaskReminderActivity taskReminderActivity = TaskReminderActivity.this;
                TaskReminderReceiver.dismiss(taskReminderActivity, taskReminderActivity.task.optString("id"));
                TaskReminderActivity.this.finish();
            }

            @Override // com.adib.maintenance.ReminderCardView.Actions
            public void complete() {
                TaskReminderActivity.this.perform(true);
            }

            @Override // com.adib.maintenance.ReminderCardView.Actions
            public void snooze() {
                TaskReminderActivity.this.page = "snooze";
                TaskReminderActivity.this.render();
            }

            @Override // com.adib.maintenance.ReminderCardView.Actions
            public void start() {
                TaskReminderActivity.this.perform(false);
            }
        });
        this.root = linearLayoutCreate;
        this.content = linearLayoutCreate;
        TextView textView = (TextView) linearLayoutCreate.findViewWithTag("reminder-status");
        this.status = textView;
        if (this.done) {
            str = "Задача завершена";
        } else {
            str = this.task.optBoolean("test") ? "ADIB · тест окна, без изменения задач" : "";
        }
        textView.setText(str);
        this.complete = (Button) this.root.findViewWithTag("reminder-complete");
        this.snooze = (Button) this.root.findViewWithTag("reminder-snooze");
        this.start = (Button) this.root.findViewWithTag("reminder-start");
        setContentView(this.root);
        lock(this.busy);
        fitWindow();
    }

    void fitWindow() {
        int iMin;
        boolean zEquals = "snooze".equals(this.page);
        if (zEquals) {
            iMin = Math.min(getResources().getDisplayMetrics().heightPixels - m19dp(64), m19dp(530));
        } else {
            JSONObject jSONObject = this.task;
            iMin = ReminderCardView.height(this, jSONObject != null && jSONObject.optBoolean("test"));
        }
        getWindow().setLayout(ReminderCardView.width(this), Math.max(m19dp(220), iMin));
        getWindow().setGravity(!zEquals ? 81 : 17);
        WindowManager.LayoutParams attributes = getWindow().getAttributes();
        attributes.y = zEquals ? 0 : m19dp(18);
        getWindow().setAttributes(attributes);
        getWindow().setDimAmount(0.92f);
    }

    static long preset(int i, long j) {
        if (i < 4) {
            return j + (new long[]{15, 30, 60, 180}[i] * 60000);
        }
        Calendar calendar = Calendar.getInstance();
        calendar.setTimeInMillis(j);
        calendar.set(13, 0);
        calendar.set(14, 0);
        if (i != 4) {
            if (i == 5) {
                calendar.set(11, 20);
                calendar.set(12, 0);
                if (calendar.getTimeInMillis() <= j) {
                    calendar.add(5, 1);
                }
            } else {
                calendar.add(11, 1);
            }
            return calendar.getTimeInMillis();
        }
        calendar.add(5, 1);
        calendar.set(11, 9);
        calendar.set(12, 0);
        return calendar.getTimeInMillis();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$lock$12(boolean z, View view) {
        if (view instanceof Button) {
            view.setEnabled(!z && (!this.done || "reminder-close".equals(view.getTag())));
        }
    }

    void lock(final boolean z) {
        this.busy = z;
        walk(this.root, new Each() { // from class: com.adib.maintenance.TaskReminderActivity$$ExternalSyntheticLambda9
            @Override // com.adib.maintenance.TaskReminderActivity.Each
            public final void apply(View view) {
                this.f$0.lambda$lock$12(z, view);
            }
        });
    }

    void walk(View view, Each each) {
        each.apply(view);
        if (!(view instanceof ViewGroup)) {
            return;
        }
        int i = 0;
        while (true) {
            ViewGroup viewGroup = (ViewGroup) view;
            if (i >= viewGroup.getChildCount()) {
                return;
            }
            walk(viewGroup.getChildAt(i), each);
            i++;
        }
    }

    boolean currentScope() {
        try {
            TaskReminderActions.requireScope(this, this.task);
            return true;
        } catch (Exception e) {
            this.status.setText(e.getMessage());
            return false;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$perform$13(boolean z, JSONObject jSONObject) {
        if (isDestroyed()) {
            return;
        }
        lock(false);
        if (z) {
            this.done = true;
            render();
        } else {
            this.status.setText(jSONObject.optBoolean("syncPending") ? "Помидор идёт. Синхронизация с Notion в очереди." : "Помидор запущен для этой задачи");
            this.start.setEnabled(false);
            TaskReminderReceiver.dismiss(this, this.task.optString("id"));
        }
        processQueued();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$perform$14(Exception exc) {
        if (isDestroyed()) {
            return;
        }
        lock(false);
        this.status.setText("Не удалось подтвердить действие. " + exc.getMessage());
        this.status.setTextColor(this.dark ? -21321 : -4828063);
        processQueued();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$perform$15(final boolean z) {
        try {
            final JSONObject jSONObjectComplete = z ? TaskReminderActions.complete(this.task, this.transport) : TaskReminderActions.start(this, this.task, this.transport);
            if (!z) {
                AdibFloatingTimerService.applyConfirmedListTimer(getApplicationContext(), jSONObjectComplete);
            }
            if (z) {
                TaskReminderSync.enabled(getApplicationContext(), this.task.optString("id"), false);
                TaskReminderReceiver.cancel(getApplicationContext(), this.task.optString("id"));
                PlannerCache.invalidate(getApplicationContext());
            }
            runOnUiThread(new Runnable() { // from class: com.adib.maintenance.TaskReminderActivity$$ExternalSyntheticLambda10
                @Override // java.lang.Runnable
                public final void run() {
                    this.f$0.lambda$perform$13(z, jSONObjectComplete);
                }
            });
        } catch (Exception e) {
            runOnUiThread(new Runnable() { // from class: com.adib.maintenance.TaskReminderActivity$$ExternalSyntheticLambda14
                @Override // java.lang.Runnable
                public final void run() {
                    this.f$0.lambda$perform$14(e);
                }
            });
        }
    }

    void perform(final boolean z) {
        JSONObject jSONObject;
        if (this.busy || this.done || (jSONObject = this.task) == null || jSONObject.optBoolean("test") || !currentScope()) {
            return;
        }
        lock(true);
        this.status.setText(z ? "Сохраняю выполнение…" : "Запускаю Помидор…");
        f30IO.execute(new Runnable() { // from class: com.adib.maintenance.TaskReminderActivity$$ExternalSyntheticLambda13
            @Override // java.lang.Runnable
            public final void run() {
                this.f$0.lambda$perform$15(z);
            }
        });
    }

    void snoozeAt(long j) {
        if (this.task == null || j <= System.currentTimeMillis() || !currentScope()) {
            return;
        }
        TaskReminderReceiver.schedule(this, this.task, j);
        Toast.makeText(this, "Напоминание отложено", 0).show();
        if (this.queuedIntent == null) {
            finish();
        } else {
            lock(false);
            processQueued();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$pickTime$16(String str, long j) {
        try {
            this.task.put("date", str);
        } catch (Exception unused) {
        }
        PlannerCache.invalidate(this);
        snoozeAt(j);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$pickTime$17(Exception exc) {
        lock(false);
        this.status.setText("Дата не изменена: " + exc.getMessage());
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$pickTime$18(final String str, final long j) {
        try {
            TaskReminderActions.requireScope(this, this.task);
            TaskReminderActions.changeDate(this.task, str, this.transport);
            runOnUiThread(new Runnable() { // from class: com.adib.maintenance.TaskReminderActivity$$ExternalSyntheticLambda11
                @Override // java.lang.Runnable
                public final void run() {
                    this.f$0.lambda$pickTime$16(str, j);
                }
            });
        } catch (Exception e) {
            runOnUiThread(new Runnable() { // from class: com.adib.maintenance.TaskReminderActivity$$ExternalSyntheticLambda12
                @Override // java.lang.Runnable
                public final void run() {
                    this.f$0.lambda$pickTime$17(e);
                }
            });
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$pickTime$19(Calendar calendar, JSONObject jSONObject, boolean z, TimePicker timePicker, int i, int i2) {
        calendar.set(11, i);
        calendar.set(12, i2);
        calendar.set(13, 0);
        calendar.set(14, 0);
        final long timeInMillis = calendar.getTimeInMillis();
        if (this.task != jSONObject) {
            this.status.setText("Напоминание изменилось. Выберите время заново.");
            return;
        }
        if (timeInMillis <= System.currentTimeMillis()) {
            this.status.setText("Выберите время в будущем");
        } else {
            if (!z) {
                snoozeAt(timeInMillis);
                return;
            }
            lock(true);
            final String str = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssXXX", Locale.ROOT).format(calendar.getTime());
            f30IO.execute(new Runnable() { // from class: com.adib.maintenance.TaskReminderActivity$$ExternalSyntheticLambda0
                @Override // java.lang.Runnable
                public final void run() {
                    this.f$0.lambda$pickTime$18(str, timeInMillis);
                }
            });
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public /* synthetic */ void lambda$pickTime$20(final Calendar calendar, final JSONObject jSONObject, final boolean z, DatePicker datePicker, int i, int i2, int i3) {
        calendar.set(i, i2, i3);
        new TimePickerDialog(this, new TimePickerDialog.OnTimeSetListener() { // from class: com.adib.maintenance.TaskReminderActivity$$ExternalSyntheticLambda17
            @Override // android.app.TimePickerDialog.OnTimeSetListener
            public final void onTimeSet(TimePicker timePicker, int i4, int i5) {
                this.f$0.lambda$pickTime$19(calendar, jSONObject, z, timePicker, i4, i5);
            }
        }, calendar.get(11), calendar.get(12), true).show();
    }

    void pickTime(final boolean z) {
        if (currentScope()) {
            final JSONObject jSONObject = this.task;
            final Calendar calendar = Calendar.getInstance();
            new DatePickerDialog(this, new DatePickerDialog.OnDateSetListener() { // from class: com.adib.maintenance.TaskReminderActivity$$ExternalSyntheticLambda16
                @Override // android.app.DatePickerDialog.OnDateSetListener
                public final void onDateSet(DatePicker datePicker, int i, int i2, int i3) {
                    this.f$0.lambda$pickTime$20(calendar, jSONObject, z, datePicker, i, i2, i3);
                }
            }, calendar.get(1), calendar.get(2), calendar.get(5)).show();
        }
    }

    @Override // android.app.Activity
    public void onBackPressed() {
        if (this.busy) {
            return;
        }
        if ("snooze".equals(this.page)) {
            this.page = "card";
            render();
        } else {
            JSONObject jSONObject = this.task;
            if (jSONObject != null) {
                PendingReminderPopups.consume(this, jSONObject.optString("id"));
            }
            super.onBackPressed();
        }
    }
}
