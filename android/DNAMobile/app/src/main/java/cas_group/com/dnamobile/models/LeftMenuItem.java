package cas_group.com.dnamobile.models;

import android.graphics.drawable.Drawable;

/**
 * Created by kuccu on 10/17/16.
 */

public class LeftMenuItem {
    private String _title;
    private Drawable _resourceID;
    public LeftMenuItem(String title, Drawable drawable){
        _title = title;
        _resourceID = drawable;
    }

    public String getTitle(){
        return  _title;
    }
    public  Drawable getDrawable(){
        return  _resourceID;
    }
}
