package com.adib.maintenance;

import android.content.Context;
import android.webkit.CookieManager;
import org.json.JSONObject;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

/** Authenticated calls to the existing shared work-timer API. */
final class WorkTimerApi {
    private WorkTimerApi(){}
    static JSONObject getState(Context context)throws Exception{return request(context,"GET","/api/work-state",null);}
    static JSONObject action(Context context,JSONObject payload)throws Exception{return request(context,"POST","/api/work-timer",payload);}
    static JSONObject authStatus(Context context)throws Exception{return request(context,"GET","/api/auth/me",null);}
    static JSONObject request(Context context,String method,String path,JSONObject body)throws Exception{
        String base=BuildConfig.APP_BASE_URL;URL url=new URL((base.endsWith("/")?base.substring(0,base.length()-1):base)+path);HttpURLConnection c=null;
        try{c=(HttpURLConnection)url.openConnection();c.setRequestMethod(method);c.setConnectTimeout(10000);c.setReadTimeout(20000);c.setUseCaches(false);c.setRequestProperty("Accept","application/json");c.setRequestProperty("Cache-Control","no-store");c.setRequestProperty("Origin",base.replaceAll("/$",""));c.setRequestProperty("Referer",base);String cookie=CookieManager.getInstance().getCookie(base);if(cookie!=null&&!cookie.isEmpty())c.setRequestProperty("Cookie",cookie);if(body!=null){c.setDoOutput(true);c.setRequestProperty("Content-Type","application/json; charset=utf-8");try(OutputStream out=c.getOutputStream()){out.write(body.toString().getBytes(StandardCharsets.UTF_8));}}
            int status=c.getResponseCode();InputStream in=status>=400?c.getErrorStream():c.getInputStream();if(in==null)throw new java.io.IOException("Taymerdən boş cavab");ByteArrayOutputStream out=new ByteArrayOutputStream();byte[] buffer=new byte[4096];int n;while((n=in.read(buffer))!=-1){out.write(buffer,0,n);if(out.size()>1024*1024)throw new java.io.IOException("Taymerin cavabı həddən artıq böyükdür");}in.close();JSONObject result=new JSONObject(new String(out.toByteArray(),StandardCharsets.UTF_8));if(status>=400)throw new ApiException(result.optString("error","HTTP "+status),status);return result;
        }finally{if(c!=null)c.disconnect();}
    }
    static final class ApiException extends Exception{final int status;ApiException(String message,int status){super(message);this.status=status;}}
}
