package cas_group.com.dnamobile.models;

import org.json.JSONException;
import org.json.JSONObject;

/**
 * Created by kuccu on 11/9/16.
 */

public class Calendar extends BaseModel {
    public String getStart() {
        return _start;
    }

    public String getEnd() {
        return _end;
    }

    public String getLocation() {
        return _location;
    }

    public String getDescription() {
        return _description;
    }

    private String _start;
    private String _end;
    private String _location;
    private String _description;

    public Calendar(JSONObject jsonObject){
        _start = jsonObject.optString("start");
        _end = jsonObject.optString("end");
        try {
            _location = jsonObject.getString("location");
            _description = jsonObject.getString("description");
        } catch (JSONException e) {
            e.printStackTrace();
        }

    }
}
