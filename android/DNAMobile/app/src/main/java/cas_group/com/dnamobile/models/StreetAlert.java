package cas_group.com.dnamobile.models;

import org.json.JSONObject;

/**
 * Created by kuccu on 10/26/16.
 */

public class StreetAlert extends BaseModel {
    private String _date;
    private String _link;


   public StreetAlert(JSONObject jsonObject){
       _date = jsonObject.optString("date");
       _link = jsonObject.optString("link");
   }
}
