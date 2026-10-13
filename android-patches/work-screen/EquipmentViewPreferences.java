package com.adib.maintenance;
import android.content.SharedPreferences;
import android.content.Context;
/** Local display preference only; never changes tasks or canvas coordinates. */
final class EquipmentViewPreferences {
 static final String[] VIEWS={"canvas","list","kanban"},DEFAULTS={"canvas","list","kanban","last"};
 final SharedPreferences prefs;EquipmentViewPreferences(SharedPreferences prefs){this.prefs=prefs;}
 static String stableScope(Context context){if(DirectRuntime.enabled())return "notion:"+DirectConfig.get(context,"syncDataSourceId");String account=AccountSession.user==null?(AccountSession.required?"locked":"local"):AccountSession.user.optString("id","local");return BuildConfig.APP_BASE_URL+":"+account;}
 static boolean valid(String view){return "canvas".equals(view)||"list".equals(view)||"kanban".equals(view);}
 String chosenDefault(){String value=prefs.getString("default","canvas");return valid(value)||"last".equals(value)?value:"canvas";}
 String last(){String value=prefs.getString("last","canvas");return valid(value)?value:"canvas";}
 String resolveDefault(){String value=chosenDefault();return "last".equals(value)?last():value;}
 void setDefault(String view){if(!valid(view)&&!"last".equals(view))throw new IllegalArgumentException("Unknown default view");if(!prefs.edit().putString("default",view).commit())throw new IllegalStateException("Defolt görünüşü saxlamaq alınmadı");}
 void remember(String view){if(!valid(view))throw new IllegalArgumentException("Unknown view");if(!prefs.edit().putString("last",view).commit())throw new IllegalStateException("Son görünüşü saxlamaq alınmadı");}
}
