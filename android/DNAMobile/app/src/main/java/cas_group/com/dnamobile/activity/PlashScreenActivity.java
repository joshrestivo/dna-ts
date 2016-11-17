package cas_group.com.dnamobile.activity;

import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.location.Location;
import android.location.LocationManager;
import android.os.Bundle;
import android.support.v4.app.ActivityCompat;
import android.support.v4.content.ContextCompat;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.widget.Toast;

import cas_group.com.dnamobile.api.ApiClientUsage;
import cas_group.com.dnamobile.api.ResponseCallback;
import cas_group.com.dnamobile.helps.GcmHelper;
import cas_group.com.dnamobile.models.AuthenticationCache;
import cas_group.com.dnamobile.service.GPSTracker;
import cas_group.com.dnamobile.service.LocationService;


/**
 * Created by thanhpham on 12/13/14.
 */
public class PlashScreenActivity extends BaseAppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        final GPSTracker tracker = new GPSTracker(_context);
        GcmHelper.registerGcm(new ResponseCallback(this) {

            public void endSucceeded(String regId) {
                //check authenticate

                if (tracker.getCurrentLocation() != null){
                    AuthenticationCache.setLocation(tracker.getCurrentLocation());
                    checkAuthentication();
                }
            }
        });


    }

    public void onRequestPermissionsResult(int requestCode, String[] permissions,
                                           int[] grantResults) {
        if (requestCode == 5
                && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
            getCurrentLocation();


        }else{
            Toast.makeText(this, "Need your location!", Toast.LENGTH_SHORT).show();
        }


    }

    private void getCurrentLocation(){
        LocationManager locationManager = (LocationManager) _context.getSystemService(LOCATION_SERVICE);
        String provider_info = LocationManager.NETWORK_PROVIDER;

        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            // TODO: Consider calling
            //    ActivityCompat#requestPermissions
            // here to request the missing permissions, and then overriding
            //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
            //                                          int[] grantResults)
            // to handle the case where the user grants the permission. See the documentation
            // for ActivityCompat#requestPermissions for more details.
            return;
        }
        Location location = locationManager.getLastKnownLocation(provider_info);

        AuthenticationCache.setLocation(location);
        checkAuthentication();
    }
    private void gotoMainActivity() {
        Intent intent = new Intent(this, MainActivity.class);
        startActivity(intent);
    }

    private void checkAuthentication() {
        int idRestore = AuthenticationCache.restoreAuth();
        idRestore = 0;
        if(idRestore > 0){
            ApiClientUsage.getClientResource(idRestore, getLocationcallback());

        }else{
            showLoading();
            ApiClientUsage.authentication(new ResponseCallback(this) {

                @Override
                public void endSucceeded(Object location) {
                    hideLoading();
                    if (location != null) {
                        //ok
                    } else {
                        showErrorDialog("missing data");
                    }
                    gotoMainActivity();
                }

                @Override
                public void endFailed(String result) {
//                    hideLoading();
                    if (result.equalsIgnoreCase("SYSTEM_ERROR")){
                        showGeneralServerErrorDialog();
                    }else {
                        showGeneralErrorDialog();
                    }

                }

            });
        }

    }

    private ResponseCallback getLocationcallback(){
        return new ResponseCallback((BaseAppCompatActivity)_context){
            @Override
            public void endSucceeded(Object object) {
                gotoMainActivity();
            }

            @Override
            public void endFailed(String result) {
                super.endFailed(result);
            }

        };
    }

}