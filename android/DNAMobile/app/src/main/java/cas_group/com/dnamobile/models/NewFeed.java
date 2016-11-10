package cas_group.com.dnamobile.models;

import org.json.JSONObject;

/**
 * Created by kuccu on 10/25/16.
 */

public class NewFeed extends BaseModel{
    private String _date;

    public String getLink() {
        return _link;
    }

    private String _link;
    private String _title;
    private String _description;
    private String _thumbnail_url;

    private double _thumbnailWidth;
    private double _thumbnailHight;

    public NewFeed(JSONObject jsonObject){
        _date = jsonObject.optString("date");
        _link = jsonObject.optString("link");
        _title = jsonObject.optString("title");
        _description = jsonObject.optString("description");
        _thumbnail_url = jsonObject.optString("thumbnail_url");
        _thumbnailWidth = jsonObject.optDouble("thumbnail_width");
        _thumbnailHight = jsonObject.optDouble("thumbnail_height");
    }
    public String getThumbnail_url(){
        return _thumbnail_url;
    }

    public String getTitle(){
        return _title;
    }

    public String getDescription(){
        return _description;
    }
}
