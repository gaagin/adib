package com.adib.maintenance;

import android.content.*;
import android.database.Cursor;
import android.database.MatrixCursor;
import android.net.Uri;
import android.os.ParcelFileDescriptor;
import android.provider.OpenableColumns;
import java.io.*;
import java.util.UUID;

/** Only grantable, private, temporary camera JPEGs; never exposes other app files. */
public class CameraPhotoProvider extends ContentProvider {
    static final int CAPTURE_IMAGE=7411;
    static File directory(Context context){return new File(context.getCacheDir(),"camera-photos");}
    static Uri create(Context context)throws IOException{
        File dir=directory(context);if(!dir.isDirectory()&&!dir.mkdirs())throw new IOException("Foto üçün yer hazırlamaq alınmadı");
        File[] old=dir.listFiles();if(old!=null)for(File f:old)if(f.getName().matches("capture-[a-f0-9-]{36}\\.jpg")&&System.currentTimeMillis()-f.lastModified()>24*60*60*1000L)f.delete();
        File file=new File(dir,"capture-"+UUID.randomUUID()+".jpg");if(!file.createNewFile())throw new IOException("Foto faylını yaratmaq alınmadı");
        return new Uri.Builder().scheme("content").authority(context.getPackageName()+".camera").appendPath(file.getName()).build();
    }
    static File file(Context context,Uri uri)throws FileNotFoundException{
        try{
            if(uri==null||!"content".equals(uri.getScheme())||!(context.getPackageName()+".camera").equals(uri.getAuthority())||uri.getPathSegments().size()!=1||uri.getQuery()!=null||uri.getFragment()!=null)throw new IOException();
            String name=uri.getLastPathSegment();if(name==null||!name.matches("capture-[a-f0-9-]{36}\\.jpg"))throw new IOException();
            File dir=directory(context).getCanonicalFile(),f=new File(dir,name).getCanonicalFile();if(!dir.equals(f.getParentFile())||!f.isFile())throw new IOException();return f;
        }catch(IOException e){throw new FileNotFoundException("Kamera faylı əlçatan deyil");}
    }
    static Intent intent(Context context,Uri uri){Intent intent=new Intent(android.provider.MediaStore.ACTION_IMAGE_CAPTURE).putExtra(android.provider.MediaStore.EXTRA_OUTPUT,uri).addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION|Intent.FLAG_GRANT_WRITE_URI_PERMISSION);intent.setClipData(ClipData.newRawUri("ADIB camera",uri));return intent;}
    static void discard(Context context,Uri uri){if(uri==null)return;try{context.revokeUriPermission(uri,Intent.FLAG_GRANT_READ_URI_PERMISSION|Intent.FLAG_GRANT_WRITE_URI_PERMISSION);}catch(Exception ignored){}try{file(context,uri).delete();}catch(Exception ignored){}}
    @Override public boolean onCreate(){return true;}
    @Override public String getType(Uri uri){try{file(getContext(),uri);return "image/jpeg";}catch(FileNotFoundException e){throw new IllegalArgumentException("Kamera faylı əlçatan deyil");}}
    @Override public ParcelFileDescriptor openFile(Uri uri,String mode)throws FileNotFoundException{return ParcelFileDescriptor.open(file(getContext(),uri),ParcelFileDescriptor.parseMode(mode));}
    @Override public Cursor query(Uri uri,String[] projection,String selection,String[] selectionArgs,String sortOrder){try{File f=file(getContext(),uri);String[] columns=projection==null?new String[]{OpenableColumns.DISPLAY_NAME,OpenableColumns.SIZE}:projection;MatrixCursor cursor=new MatrixCursor(columns);Object[] values=new Object[columns.length];for(int i=0;i<columns.length;i++){if(OpenableColumns.DISPLAY_NAME.equals(columns[i]))values[i]=f.getName();else if(OpenableColumns.SIZE.equals(columns[i]))values[i]=f.length();}cursor.addRow(values);return cursor;}catch(FileNotFoundException e){throw new IllegalArgumentException("Kamera faylı əlçatan deyil");}}
    @Override public Uri insert(Uri uri,ContentValues values){throw new UnsupportedOperationException();}
    @Override public int update(Uri uri,ContentValues values,String selection,String[] selectionArgs){throw new UnsupportedOperationException();}
    @Override public int delete(Uri uri,String selection,String[] selectionArgs){throw new UnsupportedOperationException();}
}
