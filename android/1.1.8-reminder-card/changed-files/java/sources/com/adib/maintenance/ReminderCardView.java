package com.adib.maintenance;

import android.content.Context;
import android.text.TextUtils;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;
import java.util.Calendar;
import java.util.Objects;
import org.json.JSONArray;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
final class ReminderCardView {

    interface Actions {
        void close();

        void complete();

        void snooze();

        void start();
    }

    ReminderCardView() {
    }

    /* JADX INFO: renamed from: dp */
    static int m13dp(Context context, int i) {
        return NativeImageSupport.m8dp(context, i);
    }

    static int width(Context context) {
        return Math.max(m13dp(context, 180), Math.min(context.getResources().getDisplayMetrics().widthPixels - m13dp(context, 20), m13dp(context, 520)));
    }

    static int height(Context context, boolean z) {
        return Math.max(m13dp(context, 180), Math.min(context.getResources().getDisplayMetrics().heightPixels - m13dp(context, 96), m13dp(context, z ? 240 : 270)));
    }

    static TextView text(Context context, String str, int i, int i2) {
        TextView textView = new TextView(context);
        textView.setText(str);
        textView.setTextSize(i);
        textView.setTextColor(i2);
        return textView;
    }

    static String due(JSONObject jSONObject) {
        String strDisplay = TaskDateTime.display(jSONObject.optString("date", ""));
        if (strDisplay.isEmpty()) {
            return jSONObject.optBoolean("test") ? "Тест напоминания" : "Напоминание";
        }
        String strSubstring = strDisplay.substring(0, Math.min(10, strDisplay.length()));
        String strSubstring2 = strDisplay.length() >= 16 ? strDisplay.substring(11, 16) : "";
        Calendar calendar = Calendar.getInstance();
        calendar.add(5, 1);
        if (strSubstring.equals(TaskCalendarModel.today())) {
            strSubstring = "Сегодня";
        } else if (strSubstring.equals(TaskCalendarModel.key(calendar.getTime()))) {
            strSubstring = "Завтра";
        }
        return strSubstring + (strSubstring2.isEmpty() ? "" : ", " + strSubstring2);
    }

    static String container(Context context, JSONObject jSONObject) {
        JSONObject jSONObjectOptJSONObject = PlannerCache.read(context).optJSONObject("personal");
        JSONArray jSONArrayOptJSONArray = jSONObjectOptJSONObject == null ? null : jSONObjectOptJSONObject.optJSONArray("containers");
        if (jSONArrayOptJSONArray != null) {
            for (int i = 0; i < jSONArrayOptJSONArray.length(); i++) {
                JSONObject jSONObjectOptJSONObject2 = jSONArrayOptJSONArray.optJSONObject(i);
                if (jSONObjectOptJSONObject2 != null && jSONObjectOptJSONObject2.optString("id").equals(jSONObject.optString("containerId"))) {
                    String strOptString = jSONObjectOptJSONObject2.optString("name", "Мои задачи");
                    return "INBOX".equalsIgnoreCase(strOptString) ? "Входящие" : strOptString;
                }
            }
        }
        return "Мои задачи";
    }

    static Button button(Context context, String str, String str2, int i, int i2, int i3, final Runnable runnable) {
        Button button = new Button(context);
        button.setText(str);
        button.setTag(str2);
        button.setAllCaps(false);
        button.setTextSize(i3);
        button.setTypeface(null, 1);
        button.setTextColor(i2);
        button.setMinWidth(0);
        button.setMinimumWidth(0);
        button.setMinHeight(m13dp(context, 40));
        button.setMinimumHeight(m13dp(context, 40));
        button.setPadding(m13dp(context, 6), m13dp(context, 4), m13dp(context, 6), m13dp(context, 4));
        button.setBackground(HybridUi.rounded(i, m13dp(context, 10), 0, 0));
        button.setOnClickListener(new View.OnClickListener() { // from class: com.adib.maintenance.ReminderCardView$$ExternalSyntheticLambda0
            @Override // android.view.View.OnClickListener
            public final void onClick(View view) {
                runnable.run();
            }
        });
        return button;
    }

    private static void addSwipeHandle(Context context, LinearLayout card, JSONObject task) {
        if (task.optBoolean("test") || TextUtils.isEmpty(task.optString("id"))) return;
        View handle = new View(context);
        handle.setTag("reminder-swipe-handle");
        handle.setBackgroundColor(0x00000000);
        handle.setOnTouchListener(new ReminderCardSwipeOpen(context, task.optString("id")));
        card.addView(handle, 0, new LinearLayout.LayoutParams(-1, m13dp(context, 12)));
    }

    static LinearLayout create(Context context, JSONObject jSONObject, boolean z, String str, final Actions actions) {
        int i = z ? -5718529 : -11241500;
        int i2 = z ? -854790 : -14408668;
        int i3 = z ? -5196351 : -6710887;
        LinearLayout linearLayout = new LinearLayout(context);
        linearLayout.setOrientation(1);
        linearLayout.setTag("automatic-reminder-popup");
        linearLayout.setPadding(m13dp(context, 18), m13dp(context, 12), m13dp(context, 18), m13dp(context, 18));
        linearLayout.setBackground(HybridUi.rounded(z ? -14406856 : -1, m13dp(context, 16), 0, 0));
        linearLayout.setElevation(m13dp(context, 10));
        addSwipeHandle(context, linearLayout, jSONObject);
        LinearLayout linearLayout2 = new LinearLayout(context);
        linearLayout2.setGravity(16);
        linearLayout2.addView(text(context, "⚑", 20, -16590), new LinearLayout.LayoutParams(m13dp(context, 22), -2));
        TextView textViewText = text(context, due(jSONObject), 14, i);
        textViewText.setTag(str + "date");
        textViewText.setMaxLines(1);
        textViewText.setEllipsize(TextUtils.TruncateAt.END);
        linearLayout2.addView(textViewText, new LinearLayout.LayoutParams(0, -2, 1.0f));
        TextView inboxGlyph = text(context, "▣", 12, i3);
        linearLayout2.addView(inboxGlyph, new LinearLayout.LayoutParams(m13dp(context, 18), -2));
        TextView textViewText2 = text(context, container(context, jSONObject), 12, i3);
        textViewText2.setMaxLines(1);
        textViewText2.setEllipsize(TextUtils.TruncateAt.END);
        textViewText2.setMaxWidth(m13dp(context, 98));
        textViewText2.setPadding(m13dp(context, 6), 0, m13dp(context, 4), 0);
        if (context.getResources().getConfiguration().fontScale <= 1.2f) {
            linearLayout2.addView(textViewText2, new LinearLayout.LayoutParams(-2, -2));
        }
        Objects.requireNonNull(actions);
        if (!jSONObject.optBoolean("test")) {
            Button focusButton = button(context, "◎", str + "start", 0, i3, 24, new Runnable() {
                @Override public void run() { actions.start(); }
            });
            focusButton.setContentDescription("Pomodoro");
            linearLayout2.addView(focusButton, new LinearLayout.LayoutParams(m13dp(context, 36), m13dp(context, 48)));
        }
        Button button = button(context, "×", str + "close", 0, i3, 27, new Runnable() { // from class: com.adib.maintenance.ReminderCardView$$ExternalSyntheticLambda1
            @Override // java.lang.Runnable
            public final void run() {
                actions.close();
            }
        });
        button.setContentDescription("Закрыть напоминание");
        linearLayout2.addView(button, new LinearLayout.LayoutParams(m13dp(context, 36), m13dp(context, 48)));
        linearLayout.addView(linearLayout2, new LinearLayout.LayoutParams(-1, m13dp(context, Math.max(48, (int) Math.ceil(context.getResources().getConfiguration().fontScale * 34.0f)))));
        ScrollView scrollView = new ScrollView(context);
        LinearLayout linearLayout3 = new LinearLayout(context);
        linearLayout3.setOrientation(1);
        scrollView.addView(linearLayout3);
        TextView textViewText3 = text(context, jSONObject.optString("title", "Задача"), 24, i2);
        textViewText3.setTypeface(null, 1);
        textViewText3.setTag(str + "title");
        textViewText3.setPadding(0, m13dp(context, 10), 0, m13dp(context, 12));
        linearLayout3.addView(textViewText3);
        TextView textViewText4 = text(context, jSONObject.optBoolean("test") ? "ADIB · тест окна, без изменения задач" : "", 12, i3);
        textViewText4.setTag(str + "status");
        textViewText4.setAccessibilityLiveRegion(1);
        linearLayout3.addView(textViewText4);
        linearLayout.addView(scrollView, new LinearLayout.LayoutParams(-1, 0, 1.0f));
        if (jSONObject.optBoolean("test")) {
            Objects.requireNonNull(actions);
            linearLayout.addView(button(context, "Закрыть тестовое окно", str + "test-close", -11241500, -1, 15, new Runnable() { // from class: com.adib.maintenance.ReminderCardView$$ExternalSyntheticLambda1
                @Override // java.lang.Runnable
                public final void run() {
                    actions.close();
                }
            }), new LinearLayout.LayoutParams(-1, m13dp(context, 48)));
            return linearLayout;
        }
        int iM13dp = m13dp(context, Math.max(44, (int) Math.ceil(context.getResources().getConfiguration().fontScale * 40.0f)));
        LinearLayout linearLayout4 = new LinearLayout(context);
        String str2 = str + "snooze";
        int i4 = z ? -13288117 : -592138;
        Objects.requireNonNull(actions);
        Button button2 = button(context, "Отсрочка", str2, i4, i3, 16, new Runnable() { // from class: com.adib.maintenance.ReminderCardView$$ExternalSyntheticLambda2
            @Override // java.lang.Runnable
            public final void run() {
                actions.snooze();
            }
        });
        String str3 = str + "complete";
        int i5 = z ? -13351575 : -1117441;
        Objects.requireNonNull(actions);
        Button button3 = button(context, "Завершить", str3, i5, i, 16, new Runnable() { // from class: com.adib.maintenance.ReminderCardView$$ExternalSyntheticLambda3
            @Override // java.lang.Runnable
            public final void run() {
                actions.complete();
            }
        });
        linearLayout4.addView(button2, new LinearLayout.LayoutParams(0, iM13dp, 1.0f));
        LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(0, iM13dp, 1.0f);
        layoutParams.leftMargin = m13dp(context, 8);
        linearLayout4.addView(button3, layoutParams);
        linearLayout.addView(linearLayout4, new LinearLayout.LayoutParams(-1, iM13dp));
        return linearLayout;
    }
}
