package cas_group.com.dnamobile.api;

import com.loopj.android.http.RequestParams;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;

import cas_group.com.dnamobile.helps.GcmHelper;
import cas_group.com.dnamobile.models.AuthenticationCache;
import cas_group.com.dnamobile.models.BaseModel;
import cas_group.com.dnamobile.models.Building;
import cas_group.com.dnamobile.models.Bulletin;
import cas_group.com.dnamobile.models.Calendar;
import cas_group.com.dnamobile.models.JSONResult;
import cas_group.com.dnamobile.models.Location;
import cas_group.com.dnamobile.models.NewFeed;
import cas_group.com.dnamobile.models.StreetAlert;

/**
 * Created by kuccu on 11/6/16.
 */

public class ApiClientUsage {

    //region Account

    /**
     * Check the cache authentication on the device or browser
     */
    public static void authentication(final ResponseCallback callback) {
        String url = "auth";
        RequestParams params = new RequestParams();

        params.put("longitude", "106.640025");
        params.put("latitude", "106.640025");
        params.put("client_os", "android");
        params.put("device_token", GcmHelper.getRegistrationIdFromCache());

        ApiClient.post(url,params, new ApiJsonHttpResponseHandler(url, callback, true) {
            @Override
            public void onSuccess(JSONResult result) {
                if (result.getSuccess()) {
                    if (result.getData()!= null){
                        Location location = new Location((JSONObject)result.getData());
                        AuthenticationCache.setCurrentLocation(location);
                        callback.endSucceeded(location);

                    }else {
                        callback.endSucceeded((Object)null);
                    }
                } else {
                    callback.endSucceeded((Object)null);
                }
            }

        });
    }
    //endregion

    //region get client resource
    public static void getClientResource(int locationID, final ResponseCallback callback){
        try {
            final String url = "/location/"+ locationID;
            ApiClient.get(url, new ApiJsonHttpResponseHandler(url, callback) {
                @Override
                public void onSuccess(JSONResult result) {
                    try {
                        if (result.getSuccess()) {
                            Location location = new Location((JSONObject)result.getData());
                            AuthenticationCache.setCurrentLocation(location);
                            callback.endSucceeded(location);
                        } else {
                            endFailed((String) result.getData());
                        }
                    } catch (Exception e) {
                        callback.endFailed(e);
                    }
                }
            });
        } catch (Exception e) {
            callback.endFailed(e);
        }
    }

    //endregion

    //region NewFeed, Bulletin
    public static void getNewFeeds(int page, final ResponseCallback callback){
        try {
            final String url = "/main/"+ AuthenticationCache.getCurrentLocation().getIdLoc() +"/news";
            RequestParams params = new RequestParams();
            params.put("page", page );
            params.put("limit", PAGE_SIZE);

            ApiClient.get(url,params, new ApiJsonHttpResponseHandler(url, callback) {
                @Override
                public void onSuccess(JSONResult result) {
                    try {
                        if (result.getSuccess()) {
                            callback.endSucceeded(getNewFeeds((JSONArray) result.getData()));
                        } else {
                            endFailed((String) result.getData());
                        }
                    } catch (Exception e) {
                        callback.endFailed(e);
                    }
                }
            });
        } catch (Exception e) {
            callback.endFailed(e);
        }
    }
    private static ArrayList<BaseModel> getNewFeeds(JSONArray jsonArray)  throws  Exception{
        ArrayList<BaseModel> makes = new ArrayList<>();

        for (int i = 0; i < jsonArray.length(); i++) {
            NewFeed newFeed = new NewFeed(jsonArray.getJSONObject(i));
            makes.add(newFeed);
        }

        return makes;
    }

    public static void getBulletins(int page, final ResponseCallback callback){
        try {
            final String url = "/main/"+ AuthenticationCache.getCurrentLocation().getIdLoc() +"/bulletins";
            RequestParams params = new RequestParams();
            params.put("page", page );
            params.put("limit", PAGE_SIZE);
            ApiClient.get(url, params, new ApiJsonHttpResponseHandler(url, callback) {
                @Override
                public void onSuccess(JSONResult result) {
                    try {
                        if (result.getSuccess()) {
                            callback.endSucceeded(getBulletins((JSONArray) result.getData()));
                        } else {
                            endFailed((String) result.getData());
                        }
                    } catch (Exception e) {
                        callback.endFailed(e);
                    }
                }
            });
        } catch (Exception e) {
            callback.endFailed(e);
        }
    }
    private static ArrayList<BaseModel> getBulletins(JSONArray jsonArray)  throws  Exception{
        ArrayList<BaseModel> makes = new ArrayList<>();

        for (int i = 0; i < jsonArray.length(); i++) {
            Bulletin bulletin = new Bulletin(jsonArray.getJSONObject(i));
            makes.add(bulletin);
        }

        return makes;
    }

    //region get building location
    public static void getBuildings(int page, final ResponseCallback callback){
        try {
            final String url = "/main/"+ AuthenticationCache.getCurrentLocation().getIdLoc() +"/buildings";
            RequestParams params = new RequestParams();
            params.put("page", page );
            params.put("limit", PAGE_SIZE);
            ApiClient.get(url, params, new ApiJsonHttpResponseHandler(url, callback) {
                @Override
                public void onSuccess(JSONResult result) {
                    try {
                        if (result.getSuccess()) {
                            callback.endSucceeded(getBuilding((JSONArray) result.getData()));
                        } else {
                            endFailed((String) result.getData());
                        }
                    } catch (Exception e) {
                        callback.endFailed(e);
                    }
                }
            });
        } catch (Exception e) {
            callback.endFailed(e);
        }
    }
    private static ArrayList<BaseModel> getBuilding(JSONArray jsonArray)  throws  Exception{
        ArrayList<BaseModel> makes = new ArrayList<>();

        for (int i = 0; i < jsonArray.length(); i++) {
            Building building = new Building(jsonArray.getJSONObject(i));
            makes.add(building);
        }

        return makes;
    }
    //endregion

    //region get Street Alert Feed
    public static void getStreetAlerts(int page, final ResponseCallback callback){
        try {
            final String url = "/main/"+ AuthenticationCache.getCurrentLocation().getIdLoc() +"/buildings";
            RequestParams params = new RequestParams();
            params.put("page", page );
            params.put("limit", PAGE_SIZE);
            ApiClient.get(url, params, new ApiJsonHttpResponseHandler(url, callback) {
                @Override
                public void onSuccess(JSONResult result) {
                    try {
                        if (result.getSuccess()) {
                            callback.endSucceeded(getStreetAlerts((JSONArray) result.getData()));
                        } else {
                            endFailed((String) result.getData());
                        }
                    } catch (Exception e) {
                        callback.endFailed(e);
                    }
                }
            });
        } catch (Exception e) {
            callback.endFailed(e);
        }
    }
    private static ArrayList<BaseModel> getStreetAlerts(JSONArray jsonArray)  throws  Exception{
        ArrayList<BaseModel> makes = new ArrayList<>();

        for (int i = 0; i < jsonArray.length(); i++) {
            StreetAlert streetAlert = new StreetAlert(jsonArray.getJSONObject(i));
            makes.add(streetAlert);
        }

        return makes;
    }
    //endregion

    //region get Calendar
    public static void getCalendars(final ResponseCallback callback){
        try {
            final String url = "/main/"+ AuthenticationCache.getCurrentLocation().getIdLoc() +"/calendar";

            ApiClient.get(url, new ApiJsonHttpResponseHandler(url, callback) {
                @Override
                public void onSuccess(JSONResult result) {
                    try {
                        if (result.getSuccess()) {
                            callback.endSucceeded(getCalendars((JSONArray) result.getData()));
                        } else {
                            endFailed((String) result.getData());
                        }
                    } catch (Exception e) {
                        callback.endFailed(e);
                    }
                }
            });
        } catch (Exception e) {
            callback.endFailed(e);
        }
    }
    private static ArrayList<BaseModel> getCalendars(JSONArray jsonArray)  throws  Exception{
        ArrayList<BaseModel> makes = new ArrayList<>();

        for (int i = 0; i < jsonArray.length(); i++) {
            Calendar calendar = new Calendar(jsonArray.getJSONObject(i));
            makes.add(calendar);
        }

        return makes;
    }
    //endregion

    //region get Calendar
    public static void getLocations(int page,final ResponseCallback callback){
        try {
            final String url = "/locations";
            RequestParams params = new RequestParams();
            params.put("page", page );
            params.put("limit", PAGE_SIZE);
            ApiClient.get(url, params, new ApiJsonHttpResponseHandler(url, callback) {
                @Override
                public void onSuccess(JSONResult result) {
                    try {
                        if (result.getSuccess()) {
                            callback.endSucceeded(getLocations((JSONArray) result.getData()));
                        } else {
                            endFailed((String) result.getData());
                        }
                    } catch (Exception e) {
                        callback.endFailed(e);
                    }
                }
            });
        } catch (Exception e) {
            callback.endFailed(e);
        }
    }
    private static ArrayList<BaseModel> getLocations(JSONArray jsonArray)  throws  Exception{
        ArrayList<BaseModel> makes = new ArrayList<>();

        for (int i = 0; i < jsonArray.length(); i++) {
            Location location = new Location(jsonArray.getJSONObject(i));
            makes.add(location);
        }

        return makes;
    }
    //endregion

    public static final int PAGE_SIZE = 10;
}
