package cas_group.com.dnamobile.utils;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Matrix;

import android.widget.ImageView;



import com.squareup.picasso.*;
import java.io.FileOutputStream;
import java.io.IOException;

import cas_group.com.dnamobile.R;

public class GraphicsUtil {


    public static Bitmap rotateBitmap(Bitmap source, float angle) {
        Matrix matrix = new Matrix();
        matrix.postRotate(angle);
        return Bitmap.createBitmap(source, 0, 0, source.getWidth(), source.getHeight(), matrix, true);
    }
    public static void resizePhoto(String photoPath){
        try {
            BitmapFactory.Options options = new BitmapFactory.Options();
            options.inJustDecodeBounds = true;
            BitmapFactory.decodeFile(photoPath, options);
            int imageWidth = options.outWidth;
            options = new BitmapFactory.Options();
            if (imageWidth < 720) {
                options.inSampleSize = 1;
            } else {
                options.inSampleSize = imageWidth / 720;
            }

            Bitmap bitmap = BitmapFactory.decodeFile(photoPath, options);
            FileOutputStream out = null;
            Bitmap resized = null;
            try {
                out = new FileOutputStream(photoPath);
                if (bitmap.getWidth() > 720) {
                    resized = Bitmap.createScaledBitmap(bitmap, 720, bitmap.getHeight() * 720 / bitmap.getWidth(), false);
                    resized.compress(Bitmap.CompressFormat.JPEG, 70, out);
                } else {
                    bitmap.compress(Bitmap.CompressFormat.JPEG, 70, out);
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (out != null) {
                        out.close();
                    }

                    bitmap.recycle();
                    if (resized != null) {
                        resized.recycle();
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
    public static void resizePhotoToOutPut(Bitmap bitmap,String photoPath) {
        try {
            FileOutputStream out = null;
            Bitmap resized = null;
            try {
                out = new FileOutputStream(photoPath);
                bitmap.compress(Bitmap.CompressFormat.JPEG, 90, out);

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (out != null) {
                        out.close();
                    }

                    bitmap.recycle();
                    if (resized != null) {
                        resized.recycle();
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
    public static void resizePhoto(Bitmap bitmap,String photoPath) {
        try {
            FileOutputStream out = null;
            Bitmap resized = null;
            try {
                out = new FileOutputStream(photoPath);
                if (bitmap.getWidth() > 720) {
                    resized = Bitmap.createScaledBitmap(bitmap, 720, bitmap.getHeight() * 720 / bitmap.getWidth(), false);
                    resized.compress(Bitmap.CompressFormat.JPEG, 70, out);
                } else {
                    bitmap.compress(Bitmap.CompressFormat.JPEG, 70, out);
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (out != null) {
                        out.close();
                    }

                    bitmap.recycle();
                    if (resized != null) {
                        resized.recycle();
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }



    public static void displayAvartar(Context context, String url, ImageView img){
        if (url != null){
            if (url.startsWith("https://s3.amazonaws")){
                int index = url.lastIndexOf("/");
                if (!url.contains("100x100_")) {
                    url = url.substring(0, index + 1) + "100x100_" + url.substring(index + 1);
                }
            }
            Picasso.with(context)
                    .load(url)
                    .placeholder(R.drawable.icon_empty_avatar)
                    .error(R.drawable.icon_empty_avatar).into(img);
        }else{

            img.setImageResource(R.drawable.icon_empty_avatar);
        }

    }

    public static void displayPhoto(Context context, String url, ImageView img) {
        Picasso.with(context)
                .load(url)
                .placeholder(R.drawable.img_not_available)
                .error(R.drawable.img_not_available)
                .into(img);
    }


}
