package com.adib.maintenance;

import android.app.AlertDialog;
import android.content.Context;
import android.graphics.Color;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.Gravity;
import android.view.View;
import android.view.WindowManager;
import android.widget.BaseAdapter;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.Spinner;
import android.widget.TextView;
import java.text.Normalizer;
import java.util.ArrayList;
import java.util.Locale;

/** Spinner-compatible searchable picker, retaining the original selection API. */
final class EquipmentSearchSpinner extends Spinner {
    private final String[] options;
    private final boolean dark;
    private final int foreground, muted, surface;

    EquipmentSearchSpinner(Context context, String[] options, boolean dark, int foreground, int muted, int surface) {
        super(context);
        this.options = options.clone();
        this.dark = dark;
        this.foreground = foreground;
        this.muted = muted;
        this.surface = surface;
    }

    @Override public boolean performClick() {
        final ArrayList<Integer> visible = new ArrayList<>();
        for (int i = 0; i < options.length; i++) visible.add(i);
        LinearLayout panel = new LinearLayout(getContext());
        panel.setOrientation(LinearLayout.VERTICAL);
        panel.setPadding(dp(12), dp(4), dp(12), dp(4));
        panel.setBackgroundColor(surface);
        EditText search = new EditText(getContext());
        search.setSingleLine(true);
        search.setHint("Avadanlıq axtarın...");
        search.setContentDescription("Avadanlıq axtarışı");
        search.setTag("equipment-search-input");
        search.setTextColor(foreground);
        search.setHintTextColor(muted);
        search.setPadding(dp(12), 0, dp(12), 0);
        search.setBackgroundColor(dark ? Color.rgb(39, 51, 67) : Color.rgb(246, 248, 252));
        panel.addView(search, new LinearLayout.LayoutParams(-1, dp(48)));
        ListView list = new ListView(getContext());
        list.setTag("equipment-search-results");
        list.setDividerHeight(dp(1));
        BaseAdapter rows = new BaseAdapter() {
            @Override public int getCount() { return visible.size(); }
            @Override public Object getItem(int position) { return visible.get(position); }
            @Override public long getItemId(int position) { return visible.get(position); }
            @Override public View getView(int position, View convertView, android.view.ViewGroup parent) {
                TextView row = convertView instanceof TextView ? (TextView) convertView : new TextView(getContext());
                row.setText(options[visible.get(position)]);
                row.setTextSize(16);
                row.setTextColor(foreground);
                row.setGravity(Gravity.CENTER_VERTICAL);
                row.setPadding(dp(12), dp(8), dp(12), dp(8));
                row.setMinHeight(dp(48));
                return row;
            }
        };
        list.setAdapter(rows);
        TextView empty = new TextView(getContext());
        empty.setText("Avadanlıq tapılmadı");
        empty.setTextColor(muted);
        empty.setGravity(Gravity.CENTER);
        int screenHeight = getResources().getDisplayMetrics().heightPixels;
        int listHeight = Math.max(dp(120), Math.min(dp(420), (int)(screenHeight * .52f) - dp(70)));
        panel.addView(list, new LinearLayout.LayoutParams(-1, listHeight));
        panel.addView(empty, new LinearLayout.LayoutParams(-1, listHeight));
        list.setEmptyView(empty);
        AlertDialog dialog = new AlertDialog.Builder(getContext())
                .setTitle("Avadanlıq seçin")
                .setView(panel)
                .setNegativeButton("Bağla", null)
                .create();
        list.setOnItemClickListener((parent, row, position, id) -> {
            setSelection(visible.get(position));
            dialog.dismiss();
        });
        search.addTextChangedListener(new TextWatcher() {
            @Override public void beforeTextChanged(CharSequence s, int start, int count, int after) {}
            @Override public void onTextChanged(CharSequence s, int start, int before, int count) {
                String query = normalize(s.toString().trim());
                visible.clear();
                for (int i = 0; i < options.length; i++) if (query.isEmpty() || normalize(options[i]).contains(query)) visible.add(i);
                rows.notifyDataSetChanged();
            }
            @Override public void afterTextChanged(Editable s) {}
        });
        dialog.setOnShowListener(ignored -> {
            if (dialog.getWindow() != null) dialog.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE);
            search.requestFocus();
            search.postDelayed(() -> {
                android.view.inputmethod.InputMethodManager input = (android.view.inputmethod.InputMethodManager)getContext().getSystemService(Context.INPUT_METHOD_SERVICE);
                if (input != null) input.showSoftInput(search, android.view.inputmethod.InputMethodManager.SHOW_IMPLICIT);
            }, 120);
        });
        dialog.show();
        return true;
    }

    static String normalize(String value) {
        String folded = Normalizer.normalize(value == null ? "" : value, Normalizer.Form.NFD)
                .replaceAll("\\p{M}+", "").toLowerCase(Locale.ROOT);
        return folded.replace('ə', 'e').replace('ı', 'i');
    }

    private int dp(float value) { return Math.round(value * getResources().getDisplayMetrics().density); }
}
