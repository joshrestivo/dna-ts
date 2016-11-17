package cas_group.com.dnamobile.models;

import android.content.Context;
import android.content.SharedPreferences;

import org.json.JSONObject;

import cas_group.com.dnamobile.DNAApplication;
import cas_group.com.dnamobile.api.ApiClient;
import cas_group.com.dnamobile.api.ApiClientUsage;
import cas_group.com.dnamobile.utils.UtilsValidation;

/**
 * Created by kuccu on 11/7/16.
 */

public class AuthenticationCache {

    public static void setCurrentLocation(Location location) {
        _currentLocation = location;

        // This is standard behavior in most mobile operating systems, definitely including Android.
        // Your app is in fact very often killed if some other application with higher priority (generally,
        // if it's in the foreground it's higher priority) needs the resources.
        // This is due to the nature of mobile devices having relatively limited resources.
        // You should save your data somewhere more durable.
        // Original source: http://stackoverflow.com/questions/9541688/static-variable-null-when-returning-to-the-app

        writeCache(location);
    }

    public static Location getCurrentLocation () {
        if (_currentLocation == null) {
//            restoreAuth();
        }

        return _currentLocation;
    }


    public static void logout() {
        _currentLocation = null;
        clearCache();
        ApiClient.clear();
    }
    public static android.location.Location getLocation() {
        return _location;
    }

    public static void setLocation(android.location.Location _location) {
        AuthenticationCache._location = _location;
    }

    // --------------------------------------------
    // Helper methods
    // --------------------------------------------

    public static int restoreAuth() {
        try{
            SharedPreferences prefs = DNAApplication.getAppContext().getSharedPreferences(SHARED_PREF_FILE, Context.MODE_PRIVATE);
            int idLoc = prefs.getInt(AUTH_LOC, 0);
//            String userJson = prefs.getString(AUTH_LOC, null);
//            if (UtilsValidation.isNotNullOrWhitespace(userJson)) {
//                _currentLocation = new Location(new JSONObject(userJson));
            return idLoc;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    private static void writeCache(Location location) {
        SharedPreferences prefs = DNAApplication.getAppContext().getSharedPreferences(SHARED_PREF_FILE, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = prefs.edit();
        editor.putInt(AUTH_LOC, location.getIdLoc());
        editor.apply();
    }

    private static void clearCache() {
        SharedPreferences prefs = DNAApplication.getAppContext().getSharedPreferences(SHARED_PREF_FILE, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = prefs.edit();
        editor.remove(AUTH_LOC);
        //editor.clear();
        editor.apply();
    }
    public static String getTitleWithKey(String key){
        ClientResource.DetailResource [] detailResources = getCurrentLocation().getClientResource().getDetails();
        for (ClientResource.DetailResource detailResource:
             detailResources) {
            if(detailResource.uniqueName.equalsIgnoreCase(key)){
                return detailResource.displayText;
            }
        }
        return "";
    }
    // --------------------------------------------
    // Variables
    // --------------------------------------------

    private static Location _currentLocation;


    private static android.location.Location _location;
    private static final String AUTH_LOC = "AUTH_LOCATION";
    private static final String SHARED_PREF_FILE = "TOWNSQUARE";
}