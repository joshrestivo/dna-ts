package cas_group.com.dnamobile.models;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * Created by kuccu on 11/6/16.
 */

public class ClientResource {
    public int getIdResource() {
        return _idResource;
    }

    public void setIdResource(int idResource) {
        _idResource = idResource;
    }

    public String getName() {
        return _name;
    }

    public void setName(String name) {
        _name = name;
    }

    public boolean isDefault() {
        return _isDefault;
    }

    public void setDefault(boolean aDefault) {
        _isDefault = aDefault;
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

    public DetailResource[] getDetails() {
        return _details;
    }

    public void setDetails(DetailResource[] details) {
        _details = details;
    }

    private int _idResource;
    private String _name;
    private boolean _isDefault;

    private String _createdBy;
    private String _updatedBy;
    private String _createdAt;
    private String _updatedAt;

    private DetailResource[] _details;


    public ClientResource(JSONObject jsonObject){
        _idResource = jsonObject.optInt("id");
        _name = jsonObject.optString("name");
        _isDefault = jsonObject.optBoolean("is_default");

        _createdBy = jsonObject.optString("created_by");
        _updatedBy = jsonObject.optString("updated_by");
        _createdAt = jsonObject.optString("created_at");
        _updatedAt = jsonObject.optString("updated_at");

        JSONArray details = null;
        try {
            details = jsonObject.getJSONArray("details");
            _details = new DetailResource[details.length()];
            for (int i = 0; i < details.length(); i++) {
                _details[i] = new DetailResource(details.getJSONObject(i));;
            }
        } catch (JSONException e) {
            e.printStackTrace();
        }


    }

    public class DetailResource{
        public String uniqueName;
        public String displayText;
        public String createdBy;
        public String updatedBy;
        public String createdAt;
        public String updatedAt;

        public DetailResource(JSONObject jsonObject){

            uniqueName = jsonObject.optString("unique_name");
            displayText = jsonObject.optString("display_text");
            createdBy = jsonObject.optString("created_by");
            updatedBy = jsonObject.optString("updated_by");
            createdAt = jsonObject.optString("created_at");
            updatedAt = jsonObject.optString("updated_at");
        }
    }
}
