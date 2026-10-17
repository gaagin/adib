package com.adib.maintenance;

import android.app.Activity;
import android.app.AlarmManager;
import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.media.AudioAttributes;
import android.media.RingtoneManager;
import android.net.Uri;
import android.os.Build;
import android.widget.Toast;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public final class TaskReminderReceiver extends BroadcastReceiver {
    static final String ACTION_REMIND = "com.adib.maintenance.TASK_REMINDER";
    static final String CHANNEL = "adib_task_reminders_channel";
    static final String DELIVERED = "delivered_items";
    static final String ITEMS = "scheduled_items";
    static final int NOTICE = 17401;
    static final String PREFS = "adib_task_reminders";

    @Override // android.content.BroadcastReceiver
    public void onReceive(Context context, Intent intent) {
        String stringExtra;
        JSONObject jSONObjectScheduledReference;
        if (intent != null && ("android.intent.action.BOOT_COMPLETED".equals(intent.getAction()) || "android.intent.action.MY_PACKAGE_REPLACED".equals(intent.getAction()) || "android.app.action.SCHEDULE_EXACT_ALARM_PERMISSION_STATE_CHANGED".equals(intent.getAction()))) {
            rescheduleAll(context);
            ReminderPopupService.resumePending(context);
            return;
        }
        if (intent == null || !ACTION_REMIND.equals(intent.getAction()) || (jSONObjectScheduledReference = scheduledReference(context, (stringExtra = intent.getStringExtra("task_id")))) == null) {
            return;
        }
        if (OfflineDeletes.hidden(context, stringExtra)) {
            cancel(context, stringExtra);
            return;
        }
        event(context, "Получен сигнал Android");
        if (openInForeground(context, jSONObjectScheduledReference)) return;
        if (showNotification(context, jSONObjectScheduledReference)) {
            remove(context, ITEMS, stringExtra);
            put(context, DELIVERED, jSONObjectScheduledReference);
            ReminderPopupService.show(context, jSONObjectScheduledReference);
        }
    }

    static boolean openInForeground(Context context, JSONObject task) {
        /*
         * Do not gate this on ChatNotifications.foreground. That process-local flag
         * can be false while ADIB is still visible (for example after an activity
         * transition), causing the alarm to fall back to a plain system banner.
         * Try the TickTick-style reminder Activity whenever the device is unlocked;
         * Android's background-activity rules can still reject the launch, in which
         * case the receiver falls back to the notification/overlay path.
         */
        if (LockscreenReminder.locked(context)) return false;
        String id = task.optString("id");
        Intent intent = new Intent(context, TaskReminderActivity.class)
                .setAction("com.adib.maintenance.REMINDER_OPEN")
                .setData(Uri.parse("adib://foreground-reminder/" + Uri.encode(id)))
                .putExtra("task_id", id)
                .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        try {
            context.startActivity(intent);
            remove(context, ITEMS, id);
            put(context, DELIVERED, task);
            event(context, "Карточка напоминания открыта поверх ADIB");
            return true;
        } catch (RuntimeException e) {
            event(context, "Не открыта карточка напоминания: " + e.getClass().getSimpleName());
            return false;
        }
    }

    static JSONObject scheduledReference(Context context, String str) {
        JSONArray jSONArray = read(context, ITEMS);
        for (int i = 0; i < jSONArray.length(); i++) {
            JSONObject jSONObjectOptJSONObject = jSONArray.optJSONObject(i);
            if (jSONObjectOptJSONObject != null && str != null && str.equals(jSONObjectOptJSONObject.optString("id")) && (!jSONObjectOptJSONObject.has("scope") || DirectConfig.scope(context).equals(jSONObjectOptJSONObject.optString("scope")))) {
                return jSONObjectOptJSONObject;
            }
        }
        return null;
    }

    static JSONObject reference(Context context, String str) {
        if (str != null && !str.isEmpty()) {
            String[] strArr = {ITEMS, DELIVERED};
            for (int i = 0; i < 2; i++) {
                JSONArray jSONArray = read(context, strArr[i]);
                for (int i2 = 0; i2 < jSONArray.length(); i2++) {
                    JSONObject jSONObjectOptJSONObject = jSONArray.optJSONObject(i2);
                    if (jSONObjectOptJSONObject != null && str.equals(jSONObjectOptJSONObject.optString("id")) && (!jSONObjectOptJSONObject.has("scope") || DirectConfig.scope(context).equals(jSONObjectOptJSONObject.optString("scope")))) {
                        return jSONObjectOptJSONObject;
                    }
                }
            }
        }
        return null;
    }

    static void schedule(Context context, String str, String str2, long j) {
        JSONObject jSONObjectReference = reference(context, str);
        if (jSONObjectReference == null) {
            jSONObjectReference = new JSONObject();
        }
        try {
            JSONObject jSONObjectPut = jSONObjectReference.put("id", str);
            if (str2 == null) {
                str2 = "Задача";
            }
            jSONObjectPut.put("title", str2);
        } catch (Exception unused) {
        }
        schedule(context, jSONObjectReference, j);
    }

    static JSONObject referenceFor(JSONObject jSONObject, boolean z) {
        JSONObject jSONObject2 = new JSONObject();
        String[] strArr = {"id", "title", "date", "containerId", "machineId", "planId", "sourceKey", "completed"};
        for (int i = 0; i < 8; i++) {
            String str = strArr[i];
            if (jSONObject.has(str)) {
                try {
                    jSONObject2.put(str, jSONObject.get(str));
                } catch (Exception unused) {
                }
            }
        }
        try {
            jSONObject2.put("path", z ? "/api/personal-task" : "/api/task");
        } catch (Exception unused2) {
        }
        return jSONObject2;
    }

    static JSONObject savedReference(JSONObject jSONObject, String str, String str2, String str3, boolean z) {
        try {
            return referenceFor(new JSONObject(jSONObject.toString()).put("id", str).put("title", str2).put("date", str3), z);
        } catch (Exception unused) {
            return new JSONObject();
        }
    }

    static void schedule(Context context, JSONObject jSONObject, long j) {
        String strOptString = jSONObject.optString("id");
        if (OfflineDeletes.hidden(context, strOptString) || strOptString.isEmpty() || j <= System.currentTimeMillis() || jSONObject.optBoolean("completed")) {
            return;
        }
        if (!jSONObject.has("scope") || DirectConfig.scope(context).equals(jSONObject.optString("scope"))) {
            try {
                JSONObject jSONObjectPut = new JSONObject(jSONObject.toString()).put("scope", DirectConfig.scope(context)).put("at", j);
                cancelAlarm(context, strOptString);
                put(context, ITEMS, jSONObjectPut);
                remove(context, DELIVERED, strOptString);
                dismiss(context, strOptString);
                scheduleAlarm(context, jSONObjectPut, j);
            } catch (Exception e) {
                event(context, "Ошибка постановки: " + e.getClass().getSimpleName());
            }
        }
    }

    static boolean exactAllowed(Context context) {
        AlarmManager alarmManager = (AlarmManager) context.getSystemService("alarm");
        if (Build.VERSION.SDK_INT >= 31) {
            return alarmManager != null && alarmManager.canScheduleExactAlarms();
        }
        return true;
    }

    static void openExactSettings(Activity activity) {
        if (Build.VERSION.SDK_INT >= 31) {
            try {
                activity.startActivity(new Intent("android.settings.REQUEST_SCHEDULE_EXACT_ALARM", Uri.parse("package:" + activity.getPackageName())));
            } catch (RuntimeException unused) {
                Toast.makeText(activity, "Откройте разрешение «Будильники и напоминания» в настройках Android", 1).show();
            }
        }
    }

    static boolean isScheduled(Context context, String str) {
        JSONArray jSONArray = read(context, ITEMS);
        for (int i = 0; i < jSONArray.length(); i++) {
            JSONObject jSONObjectOptJSONObject = jSONArray.optJSONObject(i);
            if (jSONObjectOptJSONObject != null && str != null && str.equals(jSONObjectOptJSONObject.optString("id")) && jSONObjectOptJSONObject.optLong("at") > System.currentTimeMillis()) {
                return true;
            }
        }
        return false;
    }

    static void cancel(Context context, String str) {
        if (str == null || str.isEmpty()) {
            return;
        }
        cancelAlarm(context, str);
        remove(context, ITEMS, str);
        remove(context, DELIVERED, str);
        dismiss(context, str);
    }

    static void dismiss(Context context, String str) {
        NotificationManager notificationManager = (NotificationManager) context.getSystemService("notification");
        if (notificationManager != null) {
            notificationManager.cancel(str, NOTICE);
        }
        PendingReminderPopups.consume(context, str);
        ReminderPopupService.dismissMatching(str);
    }

    static void rescheduleAll(Context context) {
        JSONArray jSONArray = read(context, ITEMS);
        for (int i = 0; i < jSONArray.length(); i++) {
            JSONObject jSONObjectOptJSONObject = jSONArray.optJSONObject(i);
            if (jSONObjectOptJSONObject != null && (!jSONObjectOptJSONObject.has("scope") || DirectConfig.scope(context).equals(jSONObjectOptJSONObject.optString("scope")))) {
                long jOptLong = jSONObjectOptJSONObject.optLong("at");
                try {
                    if (jOptLong > System.currentTimeMillis()) {
                        scheduleAlarm(context, jSONObjectOptJSONObject, jOptLong);
                    } else if (System.currentTimeMillis() - jOptLong < 86400000) {
                        scheduleAlarm(context, jSONObjectOptJSONObject, System.currentTimeMillis() + 5000);
                    } else {
                        remove(context, ITEMS, jSONObjectOptJSONObject.optString("id"));
                    }
                } catch (RuntimeException e) {
                    event(context, "Не восстановлен сигнал: " + e.getClass().getSimpleName());
                }
            }
        }
    }

    static JSONArray read(Context context, String str) {
        try {
            return new JSONArray(context.getSharedPreferences(PREFS, 0).getString(str, "[]"));
        } catch (Exception unused) {
            return new JSONArray();
        }
    }

    private static synchronized void put(Context context, String str, JSONObject jSONObject) {
        JSONArray jSONArray = read(context, str);
        JSONArray jSONArray2 = new JSONArray();
        for (int i = 0; i < jSONArray.length(); i++) {
            JSONObject jSONObjectOptJSONObject = jSONArray.optJSONObject(i);
            if (jSONObjectOptJSONObject != null && !jSONObject.optString("id").equals(jSONObjectOptJSONObject.optString("id"))) {
                jSONArray2.put(jSONObjectOptJSONObject);
            }
        }
        if (DELIVERED.equals(str) && jSONArray2.length() > 99) {
            JSONArray jSONArray3 = new JSONArray();
            for (int length = jSONArray2.length() - 99; length < jSONArray2.length(); length++) {
                jSONArray3.put(jSONArray2.optJSONObject(length));
            }
            jSONArray2 = jSONArray3;
        }
        jSONArray2.put(jSONObject);
        context.getSharedPreferences(PREFS, 0).edit().putString(str, jSONArray2.toString()).apply();
    }

    private static synchronized void remove(Context context, String str, String str2) {
        JSONArray jSONArray = read(context, str);
        JSONArray jSONArray2 = new JSONArray();
        for (int i = 0; i < jSONArray.length(); i++) {
            JSONObject jSONObjectOptJSONObject = jSONArray.optJSONObject(i);
            if (jSONObjectOptJSONObject != null && !str2.equals(jSONObjectOptJSONObject.optString("id"))) {
                jSONArray2.put(jSONObjectOptJSONObject);
            }
        }
        context.getSharedPreferences(PREFS, 0).edit().putString(str, jSONArray2.toString()).apply();
    }

    static int requestCode(String str) {
        return (str.hashCode() & 1073741823) + 17000;
    }

    private static PendingIntent alarm(Context context, String str, int i) {
        return PendingIntent.getBroadcast(context, requestCode(str), new Intent(context, (Class<?>) TaskReminderReceiver.class).setAction(ACTION_REMIND).setData(Uri.parse("adib://reminder/" + Uri.encode(str))).putExtra("task_id", str), i | 67108864);
    }

    private static void scheduleAlarm(Context context, JSONObject jSONObject, long j) {
        cancelAlarm(context, jSONObject.optString("id"));
        AlarmManager alarmManager = (AlarmManager) context.getSystemService("alarm");
        if (alarmManager == null) {
            throw new IllegalStateException("AlarmManager unavailable");
        }
        if (alarmManager != null) {
            PendingIntent pendingIntentAlarm = alarm(context, jSONObject.optString("id"), 134217728);
            try {
                if (Build.VERSION.SDK_INT < 31 || alarmManager.canScheduleExactAlarms()) {
                    alarmManager.setExactAndAllowWhileIdle(0, j, pendingIntentAlarm);
                } else {
                    alarmManager.setAndAllowWhileIdle(0, j, pendingIntentAlarm);
                }
            } catch (SecurityException unused) {
                alarmManager.setAndAllowWhileIdle(0, j, pendingIntentAlarm);
            }
            event(context, "Сигнал поставлен: " + new SimpleDateFormat("dd.MM HH:mm:ss", Locale.ROOT).format(new Date(j)) + (exactAllowed(context) ? " · точный" : " · неточный"));
        }
    }

    private static void cancelAlarm(Context context, String str) {
        AlarmManager alarmManager = (AlarmManager) context.getSystemService("alarm");
        PendingIntent[] pendingIntentArr = {PendingIntent.getBroadcast(context, requestCode(str), new Intent(context, (Class<?>) TaskReminderReceiver.class).setAction(ACTION_REMIND), 603979776), alarm(context, str, 536870912)};
        for (int i = 0; i < 2; i++) {
            PendingIntent pendingIntent = pendingIntentArr[i];
            if (pendingIntent != null) {
                if (alarmManager != null) {
                    alarmManager.cancel(pendingIntent);
                }
                pendingIntent.cancel();
            }
        }
    }

    static PendingIntent open(Context context, String str, String str2) {
        return PendingIntent.getActivity(context, requestCode(str), new Intent(context, (Class<?>) TaskReminderActivity.class).setAction(str2).setData(Uri.parse("adib://reminder-action/" + Uri.encode(str) + "/" + str2)).putExtra("task_id", str).addFlags(268435456), 201326592);
    }

    static Notification notification(Context context, JSONObject jSONObject) {
        String strOptString = jSONObject.optString("id");
        NotificationManager notificationManager = (NotificationManager) context.getSystemService("notification");
        if (Build.VERSION.SDK_INT >= 26 && notificationManager != null) {
            NotificationChannel notificationChannel = new NotificationChannel(CHANNEL, "Напоминания о задачах", 4);
            notificationChannel.enableVibration(true);
            notificationChannel.setSound(RingtoneManager.getDefaultUri(2), new AudioAttributes.Builder().setUsage(5).build());
            notificationManager.createNotificationChannel(notificationChannel);
        }
        Notification.Builder builder = Build.VERSION.SDK_INT >= 26 ? new Notification.Builder(context, CHANNEL) : new Notification.Builder(context);
        builder.setSmallIcon(C0031R.drawable.ic_adib).setColor(HybridUi.BLUE).setContentTitle(jSONObject.optString("title", "Задача")).setContentText("Напоминание · ADIB").setContentIntent(open(context, strOptString, "com.adib.maintenance.REMINDER_OPEN")).setAutoCancel(false).setCategory("reminder").setVisibility(0).setPriority(1).setDefaults(3);
        String[][] strArr = {new String[]{"Завершить", "com.adib.maintenance.REMINDER_COMPLETE"}, new String[]{"Отсрочка", "com.adib.maintenance.REMINDER_SNOOZE"}, new String[]{"Начать Помидор", "com.adib.maintenance.REMINDER_START"}};
        for (int i = 0; i < 3; i++) {
            String[] strArr2 = strArr[i];
            builder.addAction(new Notification.Action.Builder(C0031R.drawable.ic_adib, strArr2[0], open(context, strOptString, strArr2[1])).build());
        }
        if (jSONObject.optBoolean("test")) {
            Notification.Builder builder2 = new Notification.Builder(context);
            if (Build.VERSION.SDK_INT >= 26) {
                builder2 = new Notification.Builder(context, CHANNEL);
            }
            builder = builder2;
            builder.setSmallIcon(C0031R.drawable.ic_adib).setContentTitle("Проверка напоминания · ADIB").setContentText("Тест доставки и звука. Задачи не изменены.").setDefaults(3).setPriority(1).setCategory("reminder").setAutoCancel(true).setContentIntent(PendingIntent.getActivity(context, 17499, new Intent(context, (Class<?>) ReminderSettingsActivity.class), 201326592));
        }
        LockscreenReminder.attach(context, jSONObject, builder);
        return builder.build();
    }

    static boolean showNotification(Context context, JSONObject jSONObject) {
        NotificationManager notificationManager = (NotificationManager) context.getSystemService("notification");
        String strBlockedReason = blockedReason(context);
        if (!strBlockedReason.isEmpty()) {
            event(context, strBlockedReason);
            return false;
        }
        try {
            Notification notification = notification(context, jSONObject);
            if (Build.VERSION.SDK_INT >= 26 && notificationManager.getNotificationChannel(CHANNEL).getImportance() == 0) {
                event(context, "Канал напоминаний заблокирован");
                return false;
            }
            notificationManager.notify(jSONObject.optString("id"), NOTICE, notification);
            if (notification.fullScreenIntent != null) {
                event(context, "Полноэкранное окно запрошено у Android");
            }
            event(context, "Уведомление принято Android (показ и звук зависят от системы)");
            return true;
        } catch (RuntimeException e) {
            event(context, "Ошибка уведомления: " + e.getClass().getSimpleName());
            return false;
        }
    }

    static String blockedReason(Context context) {
        NotificationChannel notificationChannel;
        if (Build.VERSION.SDK_INT >= 33 && context.checkSelfPermission("android.permission.POST_NOTIFICATIONS") != 0) {
            return "Нет разрешения на уведомления";
        }
        NotificationManager notificationManager = (NotificationManager) context.getSystemService("notification");
        if (notificationManager == null) {
            return "NotificationManager недоступен";
        }
        if (notificationManager.areNotificationsEnabled()) {
            return (Build.VERSION.SDK_INT < 26 || (notificationChannel = notificationManager.getNotificationChannel(CHANNEL)) == null || notificationChannel.getImportance() != 0) ? "" : "Канал напоминаний заблокирован";
        }
        return "Уведомления приложения выключены";
    }

    static synchronized void event(Context context, String str) {
        SharedPreferences sharedPreferences = context.getSharedPreferences(PREFS, 0);
        String[] strArrSplit = (sharedPreferences.getString("diagnostic_log", "") + new SimpleDateFormat("dd.MM HH:mm:ss", Locale.ROOT).format(new Date()) + " " + str + "\n").split("\n");
        StringBuilder sb = new StringBuilder();
        for (int iMax = Math.max(0, strArrSplit.length - 20); iMax < strArrSplit.length; iMax++) {
            sb.append(strArrSplit[iMax]).append('\n');
        }
        sharedPreferences.edit().putString("diagnostic_log", sb.toString()).apply();
    }

    static JSONObject testTask() {
        try {
            return new JSONObject().put("id", "__adib_local_reminder_test__").put("title", "Проверка напоминания").put("test", true);
        } catch (JSONException e) {
            throw new IllegalStateException(e);
        }
    }
}
