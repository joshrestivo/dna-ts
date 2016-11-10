package cas_group.com.dnamobile.models;

import org.json.JSONObject;

/**
 * Created by kuccu on 11/6/16.
 */

public class JSONResult {

    private boolean _success;
    private Object _data;

    public JSONResult(JSONObject result) {
        _success = result.optBoolean("success");
        _data = result.opt("data");
    }

    public boolean getSuccess() {
        return _success;
    }

    public Object getData() {
        return _data;
    }

}
