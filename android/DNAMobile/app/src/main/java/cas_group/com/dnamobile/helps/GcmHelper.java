package cas_group.com.dnamobile.helps;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.AsyncTask;
import android.preference.PreferenceManager;
import android.util.Log;

import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GoogleApiAvailability;
import com.google.android.gms.gcm.GoogleCloudMessaging;

import java.io.IOException;

import cas_group.com.dnamobile.DNAApplication;
import cas_group.com.dnamobile.api.ResponseCallback;

/**
 * Created by kuccu on 11/6/16.
 */

public class GcmHelper {
    private static final String PROPERTY_APP_VERSION = "TOWNSQUARE_APP_VERSION";
    private static final String PROPERTY_REG_ID = "TOWNSQUARE_REGISTRATION_ID";
    private static final String GCM_PROJECT_NUMBER = "82578007031";//674586173873

    // --------------------------------------------
    // Helper methods
    // --------------------------------------------
    private static final String TAG = GcmHelper.class.getSimpleName();
    private static String _regId = "";
    private static int _retryCount = 0;

    public static void registerGcm(ResponseCallback callback) {
        if (checkPlayServices()) {
            _regId = getRegistrationIdFromCache();
            if (_regId.isEmpty()) {
                registerInBackground(callback);
            } else {
                callback.endSucceeded(_regId);
            }
        } else {
            Log.i(TAG, "No valid Google Play Services APK found.");
            callback.endFailed("No valid Google Play Services APK found.");
        }
    }

    public static String getRegistrationIdFromCache() {
        final SharedPreferences prefs = getGCMPreferences();
        String registrationId = prefs.getString(PROPERTY_REG_ID, "");
        if (registrationId.isEmpty()) {
            Log.e(TAG, "Registration not found.");
            return "";
        }

        int registeredVersion = prefs.getInt(PROPERTY_APP_VERSION, Integer.MIN_VALUE);
        int currentVersion = getAppVersion(DNAApplication.getAppContext());
        if (registeredVersion != currentVersion) {
            return "";
        }

        return registrationId;
    }

    public static void clear() {
        clearRegistrationId();
    }

    // --------------------------------------------
    // Variables
    // --------------------------------------------

    private static void clearRegistrationId() {
        final SharedPreferences prefs = getGCMPreferences();
        SharedPreferences.Editor editor = prefs.edit();
        editor.clear();
        editor.apply();
    }

    private static SharedPreferences getGCMPreferences() {
        // Will use <package_name>__preferences to create file to store private data.
        // In this case, it will be com.hovit.mobile__preferences
        return PreferenceManager.getDefaultSharedPreferences(DNAApplication.getAppContext());
    }

    private static boolean checkPlayServices() {
        GoogleApiAvailability api = GoogleApiAvailability.getInstance();
        int resultCode = api.isGooglePlayServicesAvailable(DNAApplication.getAppContext());
        if (resultCode != ConnectionResult.SUCCESS) {
//            ServerLogHelper.logErrorMessage(TAG, "Google play service is not supported.");
            return false;
        }

        return true;
    }

    private static void registerInBackground(final ResponseCallback callback) {
        new AsyncTask<Object, Object, String>() {
            @Override
            protected String doInBackground(Object... params) {
                String msg;
                try {
                    GoogleCloudMessaging gcm = GoogleCloudMessaging.getInstance(DNAApplication.getAppContext());
                    _regId = gcm.register(GCM_PROJECT_NUMBER);
                    msg = "Device registered, registration ID=" + _regId;
                    storeRegistrationId(DNAApplication.getAppContext(), _regId);
                } catch (IOException ex) {
//                    ServerLogHelper.logException(GcmHelper.class.getSimpleName(), ex);
                    msg = ex.getMessage();
                }

                return msg;
            }

            @Override
            protected void onPostExecute(String msg) {
                super.onPostExecute(msg);
                if (_regId.isEmpty()) {
//                    ServerLogHelper.logErrorMessage(TAG, "GcmHelper: " + msg);
                    if (_retryCount < 3) {
                        _retryCount++;
                        registerInBackground(callback);
                    } else if ("SERVICE_NOT_AVAILABLE".equals(msg)) {
                        callback.endFailed("Could not connect Google Cloud Messaging. Please make sure that you already have available network connection.");
                    } else {
                        callback.endFailed("Registration Id is empty. Please make sure that you already have available network connection.");
                    }
                } else {
                    callback.endSucceeded(_regId);
                }
            }

        }.execute(null, null, null);
    }

    private static int getAppVersion(Context context) {
        try {
            PackageInfo packageInfo = context.getPackageManager().getPackageInfo(context.getPackageName(), 0);
            return packageInfo.versionCode;
        } catch (PackageManager.NameNotFoundException e) {
            throw new RuntimeException("Could not get package name: " + e);
        }
    }

    private static void storeRegistrationId(Context context, String regId) {
        final SharedPreferences prefs = getGCMPreferences();
        int appVersion = getAppVersion(context);
        Log.i(TAG, "Saving regId on app version " + appVersion);
        SharedPreferences.Editor editor = prefs.edit();
        editor.putString(PROPERTY_REG_ID, regId);
        editor.putInt(PROPERTY_APP_VERSION, appVersion);
        editor.apply();
    }
}
