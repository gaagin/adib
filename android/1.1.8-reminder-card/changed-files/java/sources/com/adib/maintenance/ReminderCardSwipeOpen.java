package com.adib.maintenance;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.view.MotionEvent;
import android.view.View;

/** Opens the full task editor when the reminder card's top handle is swiped up. */
final class ReminderCardSwipeOpen implements View.OnTouchListener {
    private final Context context;
    private final String taskId;
    private float downY;
    private boolean tracking;

    ReminderCardSwipeOpen(Context context, String taskId) {
        this.context = context;
        this.taskId = taskId;
    }

    @Override public boolean onTouch(View view, MotionEvent event) {
        if (event.getActionMasked() == MotionEvent.ACTION_DOWN) {
            downY = event.getRawY();
            tracking = true;
            return true;
        }
        if (event.getActionMasked() == MotionEvent.ACTION_CANCEL) {
            tracking = false;
            return true;
        }
        if (event.getActionMasked() != MotionEvent.ACTION_UP) return true;
        boolean wasTracking = tracking;
        tracking = false;
        float distance = downY - event.getRawY();
        if (!wasTracking || distance < ReminderCardView.dp(context, 56)) return true;

        ReminderPopupService.dismissMatching(taskId);
        Intent intent = new Intent(context, MainActivity.class)
                .setAction(MainActivity.ACTION_WIDGET_TASK)
                .putExtra("widget_id", taskId)
                .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_SINGLE_TOP);
        context.startActivity(intent);
        if (context instanceof Activity) ((Activity) context).finish();
        return true;
    }
}
