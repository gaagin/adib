package com.adib.maintenance;
import android.content.SharedPreferences;
/** Local display preference only; never changes tasks or canvas coordinates. */
final class EquipmentViewPreferences {
 static final String[] VIEWS={"canvas","list","kanban"},DEFAULTS={"canvas","list","kanban","last"};
 final SharedPreferences prefs;EquipmentViewPreferences(SharedPreferences prefs){this.prefs=prefs;}
 static boolean valid(String view){return "canvas".equals(view)||"list".equals(view)||"kanban".equals(view);}
 String chosenDefault(){String value=prefs.getString("default","canvas");return valid(value)||"last".equals(value)?value:"canvas";}
 String last(){String value=prefs.getString("last","canvas");return valid(value)?value:"canvas";}
 String resolveDefault(){String value=chosenDefault();return "last".equals(value)?last():value;}
 void setDefault(String view){if(!valid(view)&&!"last".equals(view))throw new IllegalArgumentException("Unknown default view");prefs.edit().putString("default",view).apply();}
 void remember(String view){if(!valid(view))throw new IllegalArgumentException("Unknown view");prefs.edit().putString("last",view).apply();}
}
