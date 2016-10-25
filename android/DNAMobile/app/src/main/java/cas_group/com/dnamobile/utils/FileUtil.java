package cas_group.com.dnamobile.utils;

import android.graphics.Bitmap;
import android.net.Uri;
import android.os.Environment;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

public class FileUtil {
    public static File createFileFromInputStream(InputStream inputStream, String fileName) {

        try {
            File f = new File(fileName);
            f.setWritable(true, false);
            OutputStream outputStream = new FileOutputStream(f);
            byte buffer[] = new byte[1024];
            int length = 0;

            while ((length = inputStream.read(buffer)) > 0) {
                outputStream.write(buffer, 0, length);
            }

            outputStream.close();
            inputStream.close();

            return f;
        } catch (IOException e) {
            System.out.println("error in creating a file");
            e.printStackTrace();
        }

        return null;
    }
    public static File SaveImage(Bitmap finalBitmap) {
        String root = Environment.getExternalStorageDirectory().toString();
        File myDir = new File(root + "/PipeFish");
        myDir.mkdirs();
        String fname = "Image_temp.jpg";
        File file = new File(myDir, fname);
        if (file.exists()) file.delete();
        try {
            FileOutputStream out = new FileOutputStream(file);
            finalBitmap.compress(Bitmap.CompressFormat.JPEG, 90, out);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return file;
    }
    public static File createTestGifFile() throws IOException {
        // Create an image file name
        String root = Environment.getExternalStorageDirectory().toString();
        File myDir = new File(root + "/Anti");
        myDir.mkdirs();
        String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
        String imageFileName = "test";

        File image = File.createTempFile(
                imageFileName,  /* prefix */
                ".gif",         /* suffix */
                myDir      /* directory */
        );

        return image;
    }
    public static File createImageFile() throws IOException {
        // Create an image file name
        String root = Environment.getExternalStorageDirectory().toString();
        File myDir = new File(root + "/Anti");
        myDir.mkdirs();
        String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
        String imageFileName = "viewer_" + timeStamp + "_";

        File image = File.createTempFile(
                imageFileName,  /* prefix */
                ".jpg",         /* suffix */
                myDir      /* directory */
        );

        return image;
    }
    public static File createVideoFile() throws IOException {
        // Create an image file name
        String root = Environment.getExternalStorageDirectory().toString();
        File myDir = new File(root + "/PipeFish");
        myDir.mkdirs();
        String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
        String imageFileName = "viewer_" + timeStamp + "_";

        File image = File.createTempFile(
                imageFileName,  /* prefix */
                ".mp4",         /* suffix */
                myDir      /* directory */
        );

        return image;
    }

    public static Uri getImageUri(String path) {
        return Uri.fromFile(new File(path));
    }

    public static String getDirectory(String folderName) {
        File directory = null;
        directory = new File(Environment.getExternalStorageDirectory().getAbsolutePath()
                + File.separator + folderName);
        if (!directory.exists()) {
            directory.mkdirs();
        }
        return directory.getAbsolutePath();
    }
}
