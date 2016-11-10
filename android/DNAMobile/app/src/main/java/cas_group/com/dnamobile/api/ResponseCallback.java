package cas_group.com.dnamobile.api;

import android.content.Context;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;

import cas_group.com.dnamobile.activity.BaseAppCompatActivity;
import cas_group.com.dnamobile.models.BaseModel;
import cas_group.com.dnamobile.utils.AlertDialogManager;

/**
 * Created by kuccu on 11/6/16.
 */

public class ResponseCallback {

    private final BaseAppCompatActivity _context;

    public ResponseCallback(BaseAppCompatActivity context) {
        _context = context;
    }

    public void endSucceeded(ArrayList<BaseModel> baseModels) {
        throw new UnsupportedOperationException();
    }
    public void start() {
        // Initiated the request
    }

    public void endSucceeded(Object object) {
    }

    public void endSucceeded(JSONObject jsonObject) {
    }

    public void endSucceeded(JSONArray object) {
    }

    public void endSucceeded(String result) {
    }

    public void endSucceeded(int result) {
    }

    public void endSucceeded(boolean success) {
    }

    public void endSucceeded() {
    }

    public void endFailed(String result) {

    }
    public void endFailed(Exception ex) {

    }

    public void endFailedDialog(String result, String url){
        String msgContent = "";
        if(result.equalsIgnoreCase("NOT_EXISTED")){
        }

        else if(result.length() > 0){
//            AlertDialogManager.showGeneralErrorDialog(_context);
        }

        if (msgContent.length() > 0){
            AlertDialogManager.showErrorDialog(_context,msgContent);
        }else{
            AlertDialogManager.showGeneralErrorDialog(_context);
        }

    }

    public void endAppFailed(boolean ignoreDialog) {
        if (_context != null && !ignoreDialog) {
            AlertDialogManager.showGeneralErrorDialog(_context);
        }
    }

    private BaseAppCompatActivity getContext() {
        BaseAppCompatActivity context = _context;
        if (context != null) {
            if (_context.isDestroyed() || _context.isFinishing()) {
                context = null;
            }
        }

        return context;
    }

    // --------------------------------------------
    // Variables
    // --------------------------------------------

    public void end(boolean success, String msg){

    }
}
