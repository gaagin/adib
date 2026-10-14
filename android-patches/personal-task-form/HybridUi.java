package com.adib.maintenance;
import android.graphics.Color;
import android.graphics.drawable.GradientDrawable;
import android.widget.EditText;
/** Shared native palette: TickTick-like controls, chat bubbles, document description. */
final class HybridUi {
 static final int BLUE=Color.rgb(79,99,232);
 static int accent(boolean dark){return dark?Color.parseColor("#B7C4FF"):BLUE;}
 static void button(android.widget.Button button,boolean dark,boolean primary){float d=button.getResources().getDisplayMetrics().density;button.setAllCaps(false);button.setTextSize(14);button.setTextColor(primary?Color.WHITE:accent(dark));button.setStateListAnimator(null);button.setElevation(0);button.setMinHeight((int)(52*d));button.setMinimumHeight((int)(52*d));button.setPadding((int)(12*d),(int)(8*d),(int)(12*d),(int)(8*d));button.setBackground(rounded(primary?BLUE:soft(dark),14*d,border(dark),primary?0:(int)Math.max(1,d)));}
 static int bg(boolean dark){return Color.parseColor(dark?"#171E2A":"#F4F6FA");}
 static int surface(boolean dark){return Color.parseColor(dark?"#222D3E":"#FFFFFF");}
 static int soft(boolean dark){return Color.parseColor(dark?"#293649":"#F7F9FC");}
 static int text(boolean dark){return Color.parseColor(dark?"#EEF2FB":"#253047");}
 static int muted(boolean dark){return Color.parseColor(dark?"#AFBBCF":"#68758C");}
 static int border(boolean dark){return Color.parseColor(dark?"#3B4A61":"#DFE5EF");}
 static int outgoing(boolean dark){return Color.parseColor(dark?"#303F67":"#EDF0FF");}
 static GradientDrawable rounded(int color,float radius,int border,int width){GradientDrawable d=new GradientDrawable();d.setColor(color);d.setCornerRadius(radius);d.setStroke(width,border);return d;}
 static android.graphics.drawable.Drawable choice(boolean dark,float density){return new android.graphics.drawable.Drawable(){final GradientDrawable base=rounded(soft(dark),14*density,border(dark),(int)Math.max(1,density));public void draw(android.graphics.Canvas canvas){android.graphics.Rect b=getBounds();base.setBounds(b);base.draw(canvas);android.graphics.Paint paint=new android.graphics.Paint(3);paint.setColor(muted(dark));paint.setStyle(android.graphics.Paint.Style.STROKE);paint.setStrokeWidth(2*density);float x=b.right-18*density,y=b.exactCenterY();android.graphics.Path path=new android.graphics.Path();path.moveTo(x-4*density,y-2*density);path.lineTo(x,y+2*density);path.lineTo(x+4*density,y-2*density);canvas.drawPath(path,paint);}public void setAlpha(int alpha){base.setAlpha(alpha);}public void setColorFilter(android.graphics.ColorFilter filter){base.setColorFilter(filter);}public int getOpacity(){return android.graphics.PixelFormat.TRANSLUCENT;}};}
 static void edit(EditText field,boolean dark,boolean document){float d=field.getResources().getDisplayMetrics().density;field.setTextColor(text(dark));field.setHintTextColor(muted(dark));field.setTextSize(document?16:15);field.setPadding((int)(14*d),(int)(12*d),(int)(14*d),(int)(12*d));field.setMinimumHeight((int)(52*d));field.setBackground(rounded(document?surface(dark):soft(dark),14*d,border(dark),document?0:(int)Math.max(1,d)));if(document)field.setLineSpacing(4*d,1.15f);}
}
