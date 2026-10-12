package com.adib.maintenance;
import android.app.*;import android.content.*;import android.media.*;import android.os.Build;import org.json.*;import java.util.*;
/** One delivery ledger shared by the Activity and foreground sync service; reading is separate. */
final class ChatNotifications {
 static final String CHANNEL="adib_chat_comments",ACTION_NEW="com.adib.maintenance.NEW_COMMENTS",EXTRA_TASK="chat_task_id";
 static volatile boolean foreground=false;
 static android.content.SharedPreferences prefs(Context c){android.content.SharedPreferences current=c.getSharedPreferences("MainActivity"+AccountSession.suffix(),Context.MODE_PRIVATE);if(!current.getBoolean("chat_prefs_migrated_v2",false)){android.content.SharedPreferences legacy=c.getSharedPreferences(MainActivity.class.getName()+AccountSession.suffix(),Context.MODE_PRIVATE);android.content.SharedPreferences.Editor edit=current.edit().putBoolean("chat_prefs_migrated_v2",true);for(String key:new String[]{"chat_seen_ids","chat_notified_ids"}){java.util.Set<String> ids=new java.util.HashSet<>(current.getStringSet(key,new java.util.HashSet<>()));ids.addAll(legacy.getStringSet(key,new java.util.HashSet<>()));edit.putStringSet(key,ids);}if(legacy.getBoolean("chat_seen_initialized",false))edit.putBoolean("chat_seen_initialized",true);edit.commit();}return current;}
 static boolean own(String author,String user){return author.trim().equalsIgnoreCase(user.trim());}
 static final class Notice {final JSONObject thread,comment;final int count;Notice(JSONObject t,JSONObject c,int n){thread=t;comment=c;count=n;}}
 static synchronized Notice accept(Context context,JSONArray threads){
  if(threads==null)return null;
  android.content.SharedPreferences p=prefs(context);Set<String> seen=new HashSet<>(p.getStringSet("chat_seen_ids",new HashSet<>())),notified=new HashSet<>(p.getStringSet("chat_notified_ids",seen));boolean initialized=p.getBoolean("chat_seen_initialized",false);String user=AccountSession.user==null?p.getString("comment_user","ilqar mamedov"):AccountSession.user.optString("name");JSONObject latestThread=null,latestComment=null;int count=0;
  for(int i=0;i<threads.length();i++){JSONObject t=threads.optJSONObject(i);JSONArray comments=t==null?null:t.optJSONArray("comments");if(comments==null)continue;for(int j=0;j<comments.length();j++){JSONObject c=comments.optJSONObject(j);if(c==null)continue;String id=c.optString("id","");if(id.isEmpty())continue;if(!initialized||own(c.optString("authorName",""),user)){seen.add(id);notified.add(id);}else if(!seen.contains(id)&&notified.add(id)){latestThread=t;latestComment=c;count++;}}}
  p.edit().putStringSet("chat_seen_ids",seen).putStringSet("chat_notified_ids",notified).putBoolean("chat_seen_initialized",true).putString("chat_threads_cache",threads.toString()).apply();return count==0?null:new Notice(latestThread,latestComment,count);
 }
 static int unread(Context context,JSONArray threads){Set<String> read=prefs(context).getStringSet("chat_seen_ids",new HashSet<>()),ids=new HashSet<>();String user=prefs(context).getString("comment_user","ilqar mamedov");if(threads!=null)for(int i=0;i<threads.length();i++){JSONObject t=threads.optJSONObject(i);JSONArray list=t==null?null:t.optJSONArray("comments");if(list!=null)for(int j=0;j<list.length();j++){JSONObject c=list.optJSONObject(j);if(c!=null&&!c.optString("id").isEmpty()&&!read.contains(c.optString("id"))&&!own(c.optString("authorName",""),user))ids.add(c.optString("id"));}}return ids.size();}
 static void publish(Context context,Notice n){if(n==null)return;String title=n.count>1?"Yeni şərhlər · "+n.count:"Şərh · "+n.thread.optString("title","Tapşırıq"),body=n.comment.optString("authorName","İstifadəçi")+": "+n.comment.optString("text","Şərh"),task=n.thread.optString("taskId","");
  context.sendBroadcast(new Intent(ACTION_NEW).setPackage(context.getPackageName()).putExtra("title",title).putExtra("body",body).putExtra(EXTRA_TASK,task));
  if(Build.VERSION.SDK_INT>=33&&context.checkSelfPermission("android.permission.POST_NOTIFICATIONS")!=android.content.pm.PackageManager.PERMISSION_GRANTED)return;
  NotificationManager manager=(NotificationManager)context.getSystemService(Context.NOTIFICATION_SERVICE);if(manager==null)return;
  if(Build.VERSION.SDK_INT>=26){NotificationChannel channel=new NotificationChannel(CHANNEL,"Yeni şərhlər ADIB",NotificationManager.IMPORTANCE_HIGH);channel.setDescription("Yeni tapşırıq şərhlərinin səsli və pop-up bildirişi");channel.enableVibration(true);channel.setSound(RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION),new AudioAttributes.Builder().setUsage(AudioAttributes.USAGE_NOTIFICATION).setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION).build());manager.createNotificationChannel(channel);}
  Intent intent=new Intent(context,MainActivity.class).setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP|Intent.FLAG_ACTIVITY_SINGLE_TOP).putExtra(EXTRA_TASK,task);
  PendingIntent pending=PendingIntent.getActivity(context,4120,intent,PendingIntent.FLAG_UPDATE_CURRENT|PendingIntent.FLAG_IMMUTABLE);
  Notification.Builder builder=Build.VERSION.SDK_INT>=26?new Notification.Builder(context,CHANNEL):new Notification.Builder(context).setDefaults(Notification.DEFAULT_SOUND|Notification.DEFAULT_VIBRATE).setPriority(Notification.PRIORITY_HIGH);
  builder.setSmallIcon(android.R.drawable.ic_dialog_email).setContentTitle(title).setContentText(body).setStyle(new Notification.BigTextStyle().bigText(body)).setContentIntent(pending).setAutoCancel(true).setCategory(Notification.CATEGORY_MESSAGE);
  try{manager.notify(4120,builder.build());}catch(SecurityException ignored){}
 }
 static void poll(Context context)throws Exception{
  if(foreground)return;
  String candidates=prefs(context).getString("chat_candidates_cache","");if(candidates.isEmpty())return;JSONArray tasks=new JSONArray(candidates);if(tasks.length()==0)return;JSONObject payload=new JSONObject().put("tasks",tasks),result;DirectRuntime.init(context);
  if(DirectRuntime.enabled())result=DirectRuntime.request("POST","/api/chat-threads",payload);
  else{java.net.HttpURLConnection c=(java.net.HttpURLConnection)new java.net.URL(BuildConfig.APP_BASE_URL.replaceAll("/+$","")+"/api/chat-threads").openConnection();AccountSession.authorize(c);try{c.setConnectTimeout(7000);c.setReadTimeout(12000);c.setRequestMethod("POST");c.setRequestProperty("Content-Type","application/json");c.setDoOutput(true);try(java.io.OutputStream out=c.getOutputStream()){out.write(payload.toString().getBytes(java.nio.charset.StandardCharsets.UTF_8));}if(AccountSession.response(c)!=200)return;try(java.io.InputStream in=c.getInputStream()){result=new JSONObject(DirectRuntime.text(in,8*1024*1024));}}finally{c.disconnect();}}
  if(result!=null&&result.optJSONArray("threads")!=null)publish(context,accept(context,result.optJSONArray("threads")));
 }
}
