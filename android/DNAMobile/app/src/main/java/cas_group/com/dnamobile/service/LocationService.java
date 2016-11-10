package cas_group.com.dnamobile.service;

/**
 * Created by kuccu on 11/7/16.
 */

import android.app.Activity;
import android.app.Service;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.location.Location;
import android.os.Build;
import android.os.Bundle;
import android.os.IBinder;
import android.support.annotation.NonNull;
import android.support.v4.app.ActivityCompat;
import android.support.v4.content.ContextCompat;
import android.util.Log;

import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.location.LocationListener;
import com.google.android.gms.location.LocationRequest;
import com.google.android.gms.location.LocationServices;

import cas_group.com.dnamobile.DNAApplication;

public class LocationService extends Service implements GoogleApiClient.ConnectionCallbacks, GoogleApiClient.OnConnectionFailedListener, LocationListener {
    public static boolean isServiceRunning() {
        return _isServiceRunning;
    }

    public static LocationService instance() {
        return _instance;
    }

    public static void killService() {
        try {
            if (_instance != null) {
                _instance.stopSelf();
                _instance = null;
            }
        } catch (Exception e) {
//            ServerLogHelper.logException(TAG, e);
        }
    }

    public LocationService() {
        super();
        _instance = this;
    }

    public void startLocationUpdates(Activity activity) {
        _activity = activity;
        if (_googleApiClient.isConnected()) {
            startLocationUpdates();
        } else {
            connectGoogleApiClient();
        }
    }

    public Location getCurrentLocation() {
        Location location = null;
        try {
            if (_googleApiClient != null && _googleApiClient.isConnected()) {
                if (Build.VERSION.SDK_INT >= 23) {
                    if (ContextCompat.checkSelfPermission(DNAApplication.getAppContext(), android.Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
                        ActivityCompat.requestPermissions(_activity, new String[]{android.Manifest.permission.ACCESS_COARSE_LOCATION}, MY_PERMISSIONS_REQUEST_ACCESS_COARSE_LOCATION);
                    }

                    if (ContextCompat.checkSelfPermission(DNAApplication.getAppContext(), android.Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
                        ActivityCompat.requestPermissions(_activity, new String[]{android.Manifest.permission.ACCESS_FINE_LOCATION}, MY_PERMISSIONS_REQUEST_ACCESS_FINE_LOCATION);
                    }
                }

                location = LocationServices.FusedLocationApi.getLastLocation(_googleApiClient);
            }

            if (location == null) {
                startLocationUpdates(_activity);
            } else {
                onLocationChanged(location);
            }

            //if (location == null && _googleApiClient != null && _googleApiClient.isConnected()) {
            //Context context = HovitApplication.getAppContext();
            //LocationManager locationManager = (LocationManager) context.getSystemService(Context.LOCATION_SERVICE);
            //if (!locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER)) {
            //String message = ResourceHelper.getMessage(R.string.error_gps_location_provider_disabled);
            //ServerLogHelper.logErrorMessage(TAG, message);
            //}

            //ServerLogHelper.logErrorMessage(TAG, "[LocationService][getCurrentLocation] could not retrieve the current location");
            //}
        } catch (Exception e) {
//            ServerLogHelper.logException(TAG, e);
        }

        return location;
    }

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override
    public void onCreate() {
        try {
            super.onCreate();
            Log.e(TAG, "LocationService create");
            createGoogleApiClient();
            connectGoogleApiClient();
            _isServiceRunning = true;
        } catch (Exception e) {
//            ServerLogHelper.logException(TAG, e);
        }
    }

    /*@Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        try {
            Log.e(TAG, "onStartCommand");
            //connectGoogleApiClient();
        } catch (Exception e) {
            Log.e(TAG, String.format("Error: %s", e.getMessage()));
            e.printStackTrace();
        }

        return super.onStartCommand(intent, flags, startId);
    }*/

    @Override
    public void onDestroy() {
        try {
            super.onDestroy();
//            ServerLogHelper.logInfoMessage(TAG, "[LocationService] service destroyed");

            stopLocationUpdates();
            _isServiceRunning = false;
        } catch (Exception e) {
//            ServerLogHelper.logException(TAG, e);
        } finally {
            _instance = null;
        }
    }

    @Override
    public void onLowMemory() {
        super.onLowMemory();
        //ServerLogHelper.logWarningMessage(TAG, "onLowMemory() called");
    }

    @Override
    public void onTrimMemory(int level) {
        super.onTrimMemory(level);
        //if (level != ComponentCallbacks2.TRIM_MEMORY_UI_HIDDEN) {
        //    ServerLogHelper.logWarningMessage(TAG, String.format("onTrimMemory(level = %s) called", AppHelper.getTrimMemoryLevelName(level)));
        //}
    }

    //----------------------------------------------------------------
    // Implementation of GoogleApiClient.ConnectionCallbacks

    @Override
    public void onConnected(Bundle bundle) {
        //Log.i(TAG, "onConnected");
        //ServerLogHelper.logInfoMessage(null, "[LocationService][onConnected]");
        if (_activity != null && !_activity.isDestroyed() && !_activity.isFinishing()) {
            startLocationUpdates();
        }
    }

    @Override
    public void onConnectionSuspended(int cause) {
        String message = "[LocationService][onConnectionSuspended] cause = " + getCauseOfSuspension(cause);
//        ServerLogHelper.logErrorMessage(TAG, message);
    }

    //----------------------------------------------------------------
    // Implementation of GoogleApiClient.OnConnectionFailedListener

    @Override
    public void onConnectionFailed(@NonNull ConnectionResult connectionResult) {
        String message = "[LocationService][onConnectionFailed] connectionResult = " + connectionResult.toString();
//        ServerLogHelper.logErrorMessage(TAG, message);
    }

    //----------------------------------------------------------------
    // Implementation of LocationListener

    @Override
    public void onLocationChanged(Location location) {
        try {
            if (location != null) {
                // Notify location change
//                BroadcastHelper.notifyLocationChange(location);

//                // Detect trip and add trip point if necessary
//                if (TripTrackingHelper.isEnRoutingToDestination()) {
//                    TripWayPoint latestPoint = TripTrackingHelper.getLatestPoint();
//                    if (latestPoint != null && DistanceHelper.isFarEnoughBetweenTwoLocationsForTrip(UtilsPosition.toLocation(latestPoint.getPosition()), location)) {
//                        TripTrackingHelper.addTripPosition(location);
//                    }
//                }
            } else {
//                String timeText = UtilsDateTime.formatTime(System.currentTimeMillis());
//                ServerLogHelper.logErrorMessage(TAG, String.format("[%s]:[LocationService][onLocationChanged] location is NULL", timeText));
            }
        } catch (Exception e) {
//            ServerLogHelper.logException(TAG, e);
        }
    }

    //----------------------------------------------------------------
    // Private helper methods

    private String getCauseOfSuspension(int cause) {
        switch (cause)
        {
            case GoogleApiClient.ConnectionCallbacks.CAUSE_NETWORK_LOST:
                return "CAUSE_NETWORK_LOST";
            case GoogleApiClient.ConnectionCallbacks.CAUSE_SERVICE_DISCONNECTED:
                return "CAUSE_SERVICE_DISCONNECTED";
        }

        return cause + "";
    }

    private void createGoogleApiClient() {
        if (_googleApiClient == null) {
            _googleApiClient = new GoogleApiClient.Builder(this).addConnectionCallbacks(this).addOnConnectionFailedListener(this).addApi(LocationServices.API).build();
        }
    }

    private void connectGoogleApiClient() {
        if (_googleApiClient != null) {
            _googleApiClient.connect();
            _isServiceRunning = true;
        } else {
            Log.e(TAG, "_googleApiClient is null");
        }
    }

    private void startLocationUpdates() {
        // Location updates intervals in sec
        int UPDATE_INTERVAL = 10000; // 10 sec
        int FASTEST_INTERVAL = 5000; // 5 sec

        LocationRequest locationRequest = LocationRequest.create();
        locationRequest.setInterval(UPDATE_INTERVAL);
        locationRequest.setFastestInterval(FASTEST_INTERVAL);
        locationRequest.setPriority(LocationRequest.PRIORITY_HIGH_ACCURACY);
        locationRequest.setSmallestDisplacement(SMALLEST_DISPLACEMENT_LOCATION_REQUEST_IN_METERS);

        if (Build.VERSION.SDK_INT >= 23) {
            if (ContextCompat.checkSelfPermission(DNAApplication.getAppContext(), android.Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
                //ServerLogHelper.logInfoMessage(LocationService.class.getSimpleName(), "[LocationService] request ACCESS_COARSE_LOCATION permission");
                ActivityCompat.requestPermissions(_activity, new String[]{android.Manifest.permission.ACCESS_COARSE_LOCATION}, MY_PERMISSIONS_REQUEST_ACCESS_COARSE_LOCATION);
            }

            if (ContextCompat.checkSelfPermission(DNAApplication.getAppContext(), android.Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
                //ServerLogHelper.logInfoMessage(LocationService.class.getSimpleName(), "[LocationService] request ACCESS_FINE_LOCATION permission");
                ActivityCompat.requestPermissions(_activity, new String[]{android.Manifest.permission.ACCESS_FINE_LOCATION}, MY_PERMISSIONS_REQUEST_ACCESS_FINE_LOCATION);
            }
        }

        LocationServices.FusedLocationApi.requestLocationUpdates(_googleApiClient, locationRequest, this);
    }

    private void stopLocationUpdates() {
        LocationServices.FusedLocationApi.removeLocationUpdates(_googleApiClient, this);
    }

    //---------------------------------
    // Private members

    private static LocationService _instance;
    private static final String TAG = LocationService.class.getSimpleName();
    private static boolean _isServiceRunning;
    private GoogleApiClient _googleApiClient;
    private Activity _activity;

    public static final int MY_PERMISSIONS_REQUEST_ACCESS_COARSE_LOCATION = 5;
    public static final int MY_PERMISSIONS_REQUEST_ACCESS_FINE_LOCATION = 6;
    public static final float SMALLEST_DISPLACEMENT_LOCATION_REQUEST_IN_METERS = 10;
}
