package com.adib.maintenance;

import android.app.AlertDialog;
import android.graphics.Color;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.Spinner;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.robolectric.Robolectric;
import org.robolectric.RobolectricTestRunner;
import org.robolectric.Shadows;
import org.robolectric.annotation.Config;
import org.robolectric.shadows.ShadowAlertDialog;
import static org.junit.Assert.*;

@RunWith(RobolectricTestRunner.class)
@Config(sdk={28,35})
public class EquipmentSearchTest {
    @Test public void newEquipmentTasksDefaultToGorulenButRespectExplicitChoice() {
        assertEquals("gorulen", EquipmentTaskDefaults.source("", ""));
        assertEquals("todo", EquipmentTaskDefaults.source("", "todo"));
        assertEquals("gorulen", EquipmentTaskDefaults.source("", "gorulen"));
        assertEquals("todo", EquipmentTaskDefaults.source("parent-task", "gorulen"));
    }

    @Test public void equipmentPickerFiltersNamesAndSelectsOriginalItem() {
        MainActivity activity = Robolectric.buildActivity(MainActivity.class).setup().get();
        String[] options={"Avadanlıqsız", "Guill", "Mal yalama", "Shrinkleme 1"};
        EquipmentSearchSpinner spinner = new EquipmentSearchSpinner(activity, options, false, Color.BLACK, Color.GRAY, Color.WHITE);
        ArrayAdapter<String> adapter = new ArrayAdapter<>(activity, android.R.layout.simple_spinner_item, options);
        spinner.setAdapter(adapter);
        spinner.performClick();
        Shadows.shadowOf(android.os.Looper.getMainLooper()).idle();
        AlertDialog dialog=ShadowAlertDialog.getLatestAlertDialog();
        assertNotNull(dialog);
        EditText field=dialog.getWindow().getDecorView().findViewWithTag("equipment-search-input");
        ListView list=dialog.getWindow().getDecorView().findViewWithTag("equipment-search-results");
        assertNotNull(field);assertNotNull(list);
        field.setText("YALAMA");
        assertEquals(1,list.getAdapter().getCount());
        list.performItemClick(list.getChildAt(0),0,list.getAdapter().getItemId(0));
        assertEquals("Mal yalama",spinner.getSelectedItem().toString());
    }
}
