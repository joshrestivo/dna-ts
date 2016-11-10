package cas_group.com.dnamobile.models;

import org.json.JSONObject;

/**
 * Created by kuccu on 10/26/16.
 */

public class Building extends BaseModel {
    public int getIdBuilding() {
        return _idBuilding;
    }

    public void setIdBuilding(int idBuilding) {
        _idBuilding = idBuilding;
    }

    public int getLocationId() {
        return _locationId;
    }

    public void setLocationId(int locationId) {
        _locationId = locationId;
    }

    public String getName() {
        return _name;
    }

    public void setName(String name) {
        _name = name;
    }

    public String getAddress() {
        return _address;
    }

    public String getZipcode() {
        return _zipcode;
    }

    public String getImageUrl() {
        return _imageUrl;
    }

    public double getImageWidth() {
        return _imageWidth;
    }


    public double getImageHeight() {
        return _imageHeight;
    }


    public String getCreatedBy() {
        return _createdBy;
    }

    public String getUpdatedBy() {
        return _updatedBy;
    }


    public String getCreatedAt() {
        return _createdAt;
    }

    public String getUpdatedAt() {
        return _updatedAt;
    }

    public Building(JSONObject jsonObject){
        _idBuilding = jsonObject.optInt("id");
        _locationId = jsonObject.optInt("location_id");
        _name = jsonObject.optString("name");
        _address = jsonObject.optString("address");
        _zipcode = jsonObject.optString("zipcode");
        _imageUrl = jsonObject.optString("image_url");

        _imageWidth = jsonObject.optDouble("image_width");
        _imageHeight = jsonObject.optDouble("image_height");

        _createdBy = jsonObject.optString("created_by");
        _updatedBy = jsonObject.optString("updated_by");
        _createdAt = jsonObject.optString("created_at");
        _updatedAt = jsonObject.optString("updated_at");
    }

    private int _idBuilding;
    private int _locationId;
    private String _name;
    private String _address;
    private String _zipcode;
    private String _imageUrl;
    private double _imageWidth;
    private double _imageHeight;
    private String _createdBy;
    private String _updatedBy;
    private String _createdAt;
    private String _updatedAt;

}
