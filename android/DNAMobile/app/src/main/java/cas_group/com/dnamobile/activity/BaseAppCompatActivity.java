package cas_group.com.dnamobile.activity;

import android.app.ActionBar;
import android.app.Activity;
import android.app.ProgressDialog;
import android.content.pm.ActivityInfo;
import android.graphics.drawable.ColorDrawable;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.MenuItem;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import android.widget.Toast;

import cas_group.com.dnamobile.DNAApplication;
import cas_group.com.dnamobile.R;
import cas_group.com.dnamobile.utils.AlertDialogManager;



public class BaseAppCompatActivity extends AppCompatActivity {

	// --------------------------------------------
	// Override methods
	// --------------------------------------------

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		DNAApplication.context = getApplicationContext();
		if (_onDefaultFlowOfCreation) {
			onInitArguments();
			onInitContentView();
			onInitControls();
			onInitLayout();
			onRegisterEvents();
            onInitData();
			if (!_isEnableRotate){
				setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
			}
		}
	}
	public void initNavBarDetail(){
		Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
		setSupportActionBar(toolbar);
		final Drawable upArrow = getResources().getDrawable(R.drawable.abc_ic_ab_back_mtrl_am_alpha);
		getSupportActionBar().setHomeAsUpIndicator(upArrow);
		getSupportActionBar().setDisplayHomeAsUpEnabled(true);
		getSupportActionBar().setDisplayShowHomeEnabled(true);
	}
	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		switch (item.getItemId()) {
		case android.R.id.home:
			onCloseActivity();
			finish();
			return true;
		}

		return super.onOptionsItemSelected(item);
	}

    @Override
    protected void onPause() {
        super.onPause();
//        PFApplication.activityPaused();
    }

    @Override
    protected void onResume() {
        super.onResume();
//        PFApplication.activityResumed();
    }

    // --------------------------------------------
	// Methods will be override by child
	// --------------------------------------------
	
	protected void onInitArguments() {
		
	}

	protected void onInitContentView() {
		
	}
	
	protected void onInitLayout() {
		ActionBar actionbar = getActionBar();
		if(actionbar != null){
			actionbar.setDisplayHomeAsUpEnabled(true);
		}
	}
	
	protected void onInitControls() {
		
	}
	
	protected void onRegisterEvents() {
		
	}
	
	protected void onInitData() {
		
	}
	
	protected void onCloseActivity() {
		
	}

	// --------------------------------------------
	// Helper methods
	// --------------------------------------------
	
	public void showLoading(){
		runOnUiThread(new Runnable() {
			@Override
			public void run() {
				try {
					if(_progressDialog != null){
						_progressDialog.dismiss();
						_progressDialog = null;
					}
					_progressDialog = new ProgressDialog(_context);
					_progressDialog.setCancelable(false);
					_progressDialog.setIndeterminate(true);
					_progressDialog.show();
//					_progressDialog.setProgressStyle(R.style.DialogTheme);
//					_progressDialog.setContentView(R.layout.progress_dialog);
					_progressDialog.getWindow().setBackgroundDrawable(new ColorDrawable(android.graphics.Color.TRANSPARENT));

				} catch (Exception ex){
					// Ignore exception for this.
				}
			}
		});

	}
	
	public void hideLoading(){
		if (_progressDialog != null) {
			try{
				_progressDialog.dismiss();
				_progressDialog = null;
			}catch (Exception e){

			}

		}
	}

	public boolean isShowLoading(){
		if (_progressDialog != null){
			return true;
		}
		return false;
	}
	
	protected void showToastMessage(final String message){
		runOnUiThread(new Runnable() {
			@Override
			public void run() {
				Toast.makeText(_context, message, Toast.LENGTH_SHORT).show();
			}
		});
	}
	
	protected void showErrorDialog(final String message) {
		runOnUiThread(new Runnable() {
			@Override
			public void run() {
				AlertDialogManager.showErrorDialog(_context, message);
			}
		});	}

    protected void showGeneralErrorDialog() {

	 runOnUiThread(new Runnable() {
		 @Override
		 public void run() {
			 AlertDialogManager.showErrorDialog(_context, getString(R.string.general_error_message));
		 }
	 });

    }

    protected void showAlertMessage(String message) {
		AlertDialogManager.showInfoDialog(_context, message);
	}
	protected void showKeyboard(boolean isShow){
		InputMethodManager imm = (InputMethodManager) this.getSystemService(Activity.INPUT_METHOD_SERVICE);
		if (imm.isActive()){
			imm.toggleSoftInput(InputMethodManager.HIDE_IMPLICIT_ONLY, 0); // hide
		} else {
			imm.toggleSoftInput(0, InputMethodManager.HIDE_IMPLICIT_ONLY); // show
		}
	}
	public void hideSoftKeyboard() {
		// Check if no view has focus:
		View view = getCurrentFocus();
		if (view != null) {
			InputMethodManager imm = (InputMethodManager)getSystemService(INPUT_METHOD_SERVICE);
			imm.hideSoftInputFromWindow(view.getWindowToken(), 0);
		}
	}


	// --------------------------------------------
	// Variables
	// --------------------------------------------
	protected boolean _isEnableRotate = false;
	private ProgressDialog _progressDialog;
	protected Activity _context = this;
	protected boolean _onDefaultFlowOfCreation = true;
}