package cas_group.com.dnamobile.api;

import android.util.Log;

import com.loopj.android.http.JsonHttpResponseHandler;

import org.json.JSONObject;

import cas_group.com.dnamobile.models.JSONResult;
import cz.msebera.android.httpclient.Header;

/**
 * Created by kuccu on 11/6/16.
 */

public class ApiJsonHttpResponseHandler extends JsonHttpResponseHandler {
    public ApiJsonHttpResponseHandler(final String url, final ResponseCallback callback) {
        _url = url;
        _callback = callback;
        _isIgnoreDialog = false;
    }
    public ApiJsonHttpResponseHandler(final String url, final ResponseCallback callback, boolean isIgnoreDialog) {
        _url = url;
        _callback = callback;
        _isIgnoreDialog =  isIgnoreDialog;
    }
    @Override
    public void onStart() {
        _callback.start();
    }

    @Override
    public void onSuccess(int statusCode, Header[] headers, JSONObject response) {
        JSONResult result = new JSONResult(response);
        onSuccess(result);
    }

    // Instances of ApiJsonHttpResponseHandler class must override this method
    public void onSuccess(JSONResult result) {

    }

    @Override
    public void onFailure(int statusCode, Header[] headers, String responseString, Throwable throwable) {
        onFailureAPI(_url, statusCode, responseString);
        _callback.endAppFailed(_isIgnoreDialog);
        _callback.endFailed("");

    }

    @Override
    public void onFailure(int statusCode, Header[] headers, Throwable throwable, JSONObject errorResponse) {
        if (errorResponse != null) {
            onFailureAPI(_url, statusCode, errorResponse.toString());
        } else if (throwable != null) {
            onFailureAPI(_url, statusCode, throwable.toString());
        } else {
            onFailureAPI(_url, statusCode, null);
        }
        _callback.endAppFailed(_isIgnoreDialog);
        _callback.endFailed("");

    }

    // --------------------------------------------
    // Helper methods
    // --------------------------------------------

    private void onFailureAPI(String url, int statusCode, String reason){
        Log.e("com.pipefish.rock", "Failed calling api: " + url + ". Status Code = " + statusCode + ". Reason: " + reason);
    }

    protected void endFailed(String result) {
        if (result != null) {
            if (!_isIgnoreDialog){
                _callback.endFailedDialog(result,_url);
            }
            _callback.endFailed(result);
        }else{
            if (!_isIgnoreDialog) {
                _callback.endFailed("Error happen. Please try again!!!");
            }
        }
    }

    // --------------------------------------------
    // Variables
    // --------------------------------------------

    private final ResponseCallback _callback;
    private final String _url;
    private boolean _isIgnoreDialog;
}
