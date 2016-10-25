package cas_group.com.dnamobile.models;

/**
 * Created by kuccu on 10/25/16.
 */

public class News {
    private String _imageUrl;
    private String _title;
    private String _content;

    public  News(String imageUrl, String title, String content){
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
