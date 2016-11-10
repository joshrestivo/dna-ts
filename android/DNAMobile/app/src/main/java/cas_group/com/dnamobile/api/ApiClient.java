package cas_group.com.dnamobile.api;

import android.os.Looper;
import android.util.Log;

import org.json.JSONArray;
import org.json.JSONObject;
import com.loopj.android.http.AsyncHttpClient;
import com.loopj.android.http.AsyncHttpResponseHandler;
import com.loopj.android.http.BuildConfig;
import com.loopj.android.http.JsonHttpResponseHandler;
import com.loopj.android.http.PersistentCookieStore;
import com.loopj.android.http.RequestParams;

import com.loopj.android.http.SyncHttpClient;
import java.io.UnsupportedEncodingException;

import cas_group.com.dnamobile.DNAApplication;
import cas_group.com.dnamobile.R;
import cz.msebera.android.httpclient.entity.ByteArrayEntity;

/**
 * Created by kuccu on 11/6/16.
 */


public class ApiClient {

    public static void get(String url, AsyncHttpResponseHandler responseHandler) {
        String fullUrl = getAbsoluteUrl(url);
        onInitAPI(GET_METHOD, fullUrl);
        getClient().get(fullUrl, responseHandler);
    }

    public static void get(String url, RequestParams params, AsyncHttpResponseHandler responseHandler) {
        String fullUrl = getAbsoluteUrl(url);
        onInitAPI(GET_METHOD, fullUrl);
        getClient().get(fullUrl, params, responseHandler);
    }

    public static void post(String url, JSONObject params, AsyncHttpResponseHandler responseHandler){
        String fullUrl = getAbsoluteUrl(url);
        onInitAPI(POST_METHOD, fullUrl);
        ByteArrayEntity entity = null;
        if (params != null){
            try {
                entity = new ByteArrayEntity(params.toString().getBytes("UTF-8"));
                entity.setContentType("application/json");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }

        getClient().post(DNAApplication.getAppContext(), fullUrl, entity, "application/json", responseHandler);
    }

    public static void post(String url, JSONArray params, AsyncHttpResponseHandler responseHandler) {
        String fullUrl = getAbsoluteUrl(url);
        onInitAPI(POST_METHOD, fullUrl);
        ByteArrayEntity entity = null;
        if (params != null){
            try {
                entity = new ByteArrayEntity(params.toString().getBytes("UTF-8"));
                entity.setContentType("application/json");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }

        getClient().post(DNAApplication.getAppContext(), fullUrl, entity, "application/json", responseHandler);
    }

    public static void post(String url, RequestParams params, JsonHttpResponseHandler responseHandler){
        String fullUrl = getAbsoluteUrl(url);
        onInitAPI(POST_METHOD, fullUrl);

        getClient().post(fullUrl, params, responseHandler);
    }

    public static void clear() {
        if (_client != null) {
            _cookieStore.clear();
            _cookieStore = null;
            _client = null;
        }
    }

    // --------------------------------------------
    // Helper methods
    // --------------------------------------------

    private static AsyncHttpClient getClient() {
        if (_client == null) {
            _client = new AsyncHttpClient();
            _cookieStore = new PersistentCookieStore(DNAApplication.getAppContext());
            _client.addHeader("Secret-Key","ee9c6aaa512cd328c641d21f13bb2654353d36dc");
            _client.setCookieStore(_cookieStore);
            _client.setTimeout(DEFAULT_TIMEOUT);
        }

        if (_syncClient == null) {
            _syncClient = new SyncHttpClient();
        }

        // Return the synchronous HTTP client when the thread is not prepared
        if (Looper.myLooper() == null) {
            return _syncClient;
        }

        return _client;
    }

    private static String getAbsoluteUrl(String relativeUrl) {
        return BASE_URL + relativeUrl;
    }

    private static void onInitAPI(String httpMethod, String fullUrl) {
        if (BuildConfig.DEBUG) {
            Log.i(DNAApplication.class.getSimpleName(), "Initialize for calling " + httpMethod + " API: " + fullUrl);
        }
    }

    // --------------------------------------------
    // Variables
    // --------------------------------------------

    private static final String BASE_URL = DNAApplication.getAppContext().getString(R.string.SERVER_URL) + "/api/1.0/";

    private static AsyncHttpClient _client;
    private static AsyncHttpClient _syncClient;
    private static PersistentCookieStore _cookieStore;
    private final static int DEFAULT_TIMEOUT = 60 * 1000;
    private final static String POST_METHOD = "POST";
    private final static String GET_METHOD = "GET";
}
