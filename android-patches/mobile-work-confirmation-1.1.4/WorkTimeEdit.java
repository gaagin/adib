package com.adib.maintenance;
import java.text.SimpleDateFormat;
import java.text.ParsePosition;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;
/** Strict, shared UI-only parser; no timer writes occur while editing. */
final class WorkTimeEdit {
 private static SimpleDateFormat formatter(){SimpleDateFormat format=new SimpleDateFormat("dd.MM.yyyy HH:mm:ss",Locale.ROOT);format.setLenient(false);format.setTimeZone(TimeZone.getTimeZone("Asia/Baku"));return format;}
 static String format(long millis){return formatter().format(new Date(millis));}
 static long editedMillis(String text,long original){text=text.trim();if(text.equals(format(original)))return original;ParsePosition position=new ParsePosition(0);Date date=formatter().parse(text,position);if(date==null||position.getIndex()!=text.length()||!text.equals(format(date.getTime())))throw new IllegalArgumentException("Введите дату и время в формате дд.ММ.гггг чч:мм:сс");return date.getTime();}
 static void validate(long start,long end){if(start<=0||end<=start)throw new IllegalArgumentException("Окончание должно быть позже начала");}
}
