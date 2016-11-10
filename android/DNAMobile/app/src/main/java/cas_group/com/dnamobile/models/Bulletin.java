package cas_group.com.dnamobile.models;

import org.json.JSONObject;

/**
 * Created by kuccu on 11/7/16.
 */

public class Bulletin extends BaseModel {

    private int _idBulletin;
    private int _locationId;
    private String _title;
    private String _description;
    private String _validFrom;
    private String _validTo;
    private String _imageUrl;
    private double _imageWidth;
    private double _imageHeight;
    private String _thumbnailUrl;
    private double _thumbnailWidth;
    private double _thumbnailHeight;
    private String _createdBy;
    private String _updatedBy;
    private String _createdAt;
    private String _updatedAt;

    public Bulletin(JSONObject jsonObject){
        _idBulletin = jsonObject.optInt("id");
        _locationId = jsonObject.optInt("location_id");
        _title = jsonObject.optString("title");
        _description = jsonObject.optString("description");
        _validFrom = jsonObject.optString("valid_from");
        _validTo = jsonObject.optString("valid_to");
        _imageUrl = jsonObject.optString("image_url");

        _imageWidth = jsonObject.optDouble("image_width");
        _imageHeight = jsonObject.optDouble("image_height");

        _thumbnailUrl = jsonObject.optString("thumbnail_url");

        _thumbnailWidth = jsonObject.optDouble("thumbnail_width");
        _thumbnailHeight = jsonObject.optDouble("thumbnail_height");

        _createdBy = jsonObject.optString("created_by");
        _updatedBy = jsonObject.optString("updated_by");
        _createdAt = jsonObject.optString("created_at");
        _updatedAt = jsonObject.optString("updated_at");
    }

    public int getIdBulletin() {
        return _idBulletin;
    }

    public void setIdBulletin(int idBulletin) {
        _idBulletin = idBulletin;
    }

    public int getLocationId() {
        return _locationId;
    }

    public void setLocationId(int locationId) {
        _locationId = locationId;
    }

    public String getTitle() {
        return _title;
    }

    public void setTitle(String title) {
        _title = title;
    }

    public String getDescription() {
        return _description;
    }

    public void setDescription(String description) {
        _description = description;
    }

    public String getValidFrom() {
        return _validFrom;
    }

    public void setValidFrom(String validFrom) {
        _validFrom = validFrom;
    }

    public String getValidTo() {
        return _validTo;
    }

    public void setValidTo(String validTo) {
        _validTo = validTo;
    }

    public String getImageUrl() {
        return _imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        _imageUrl = imageUrl;
    }

    public double getImageWidth() {
        return _imageWidth;
    }

    public void setImageWidth(double imageWidth) {
        _imageWidth = imageWidth;
    }

    public double getImageHeight() {
        return _imageHeight;
    }

    public void setImageHeight(double imageHeight) {
        _imageHeight = imageHeight;
    }

    public String getThumbnailUrl() {
        return _thumbnailUrl;
    }

    public void setThumbnailUrl(String thumbnailUrl) {
        _thumbnailUrl = thumbnailUrl;
    }

    public double getThumbnailWidth() {
        return _thumbnailWidth;
    }

    public void setThumbnailWidth(double thumbnailWidth) {
        _thumbnailWidth = thumbnailWidth;
    }

    public double getThumbnailHeight() {
        return _thumbnailHeight;
    }

    public void setThumbnailHeight(double thumbnailHeight) {
        _thumbnailHeight = thumbnailHeight;
    }

    public String getCreatedBy() {
        return _createdBy;
    }

    public void setCreatedBy(String createdBy) {
        _createdBy = createdBy;
    }

    public String getUpdatedBy() {
        return _updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        _updatedBy = updatedBy;
    }

    public String getCreatedAt() {
        return _createdAt;
    }

    public void setCreatedAt(String createdAt) {
        _createdAt = createdAt;
    }

    public String getUpdatedAt() {
        return _updatedAt;
    }

    public void setUpdatedAt(String updatedAt) {
        _updatedAt = updatedAt;
    }

}
