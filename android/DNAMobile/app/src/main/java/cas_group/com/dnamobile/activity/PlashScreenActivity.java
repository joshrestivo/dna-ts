package cas_group.com.dnamobile.activity;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;

import cas_group.com.dnamobile.api.ApiClientUsage;
import cas_group.com.dnamobile.api.ResponseCallback;
import cas_group.com.dnamobile.helps.GcmHelper;
import cas_group.com.dnamobile.models.AuthenticationCache;


/**
 * Created by thanhpham on 12/13/14.
 */
public class PlashScreenActivity extends BaseAppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);


        GcmHelper.registerGcm(new ResponseCallback(this) {

            public void endSucceeded(String regId) {
                checkAuthentication();
            }
        });

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