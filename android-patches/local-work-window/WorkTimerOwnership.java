package com.adib.maintenance;
import android.content.Context;
import org.json.JSONObject;
/** Local display preference, never an access-control or server-data filter. */
final class WorkTimerOwnership {
 static boolean allowed(Context c,JSONObject s){return s!=null&&!s.optString("id").isEmpty()&&s.optString("id").equals(WorkTimerClient.commandPrefs(c,WorkTimerClient.scope(c)).getString("localSession",""));}
 static void confirm(Context c,JSONObject command,JSONObject s){if(s==null||command==null)return;String action=command.optString("action");if((action.equals("start")||action.equals("continue"))&&!s.optString("id").isEmpty()&&!command.optString("operationId").isEmpty()&&command.optString("operationId").equals(s.optString("startOperation")))WorkTimerClient.commandPrefs(c,WorkTimerClient.scope(c)).edit().putString("localSession",s.optString("id")).commit();}
}
