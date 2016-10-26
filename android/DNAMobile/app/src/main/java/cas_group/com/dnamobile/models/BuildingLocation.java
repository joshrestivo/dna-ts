package cas_group.com.dnamobile.models;

/**
 * Created by kuccu on 10/26/16.
 */

public class BuildingLocation {
    private String _imageUrl;
    private String _title;
    private String _content;

    public BuildingLocation(String imageUrl, String title, String content){
        _imageUrl = imageUrl;
        _title = title;
        _content = content;
    }
    public String getImageUrl(){
        return _imageUrl;
    }

    public String getTitle(){
        return _title;
    }

    public String getContent(){
        return _content;
    }
}
