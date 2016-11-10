package cas_group.com.dnamobile.activity;

import android.content.Intent;
import android.location.Location;
import android.os.Bundle;
import android.os.Handler;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentTransaction;
import android.support.v4.content.ContextCompat;
import android.view.View;
import android.support.v4.view.GravityCompat;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.ActionBarDrawerToggle;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.widget.AdapterView;
import android.widget.ListView;

import org.json.JSONArray;

import java.util.ArrayList;

import cas_group.com.dnamobile.DNAApplication;
import cas_group.com.dnamobile.R;
import cas_group.com.dnamobile.apdater.LeftMenuAdapter;
import cas_group.com.dnamobile.api.ApiClientUsage;
import cas_group.com.dnamobile.api.ResponseCallback;
import cas_group.com.dnamobile.fragment.LocationInforFragment;
import cas_group.com.dnamobile.fragment.RequestServiceFragment;
import cas_group.com.dnamobile.fragment.SettingsFragment;
import cas_group.com.dnamobile.fragment.StreetAlertFragment;
import cas_group.com.dnamobile.fragment.UpcomingEventFragment;
import cas_group.com.dnamobile.fragment.HomeFragment;
import cas_group.com.dnamobile.models.AuthenticationCache;
import cas_group.com.dnamobile.models.ClientResource;
import cas_group.com.dnamobile.models.LeftMenuItem;
import cas_group.com.dnamobile.service.GPSTracker;
import cas_group.com.dnamobile.service.LocationService;

public class MainActivity extends BaseAppCompatActivity implements DrawerLayout.DrawerListener{
    @Override
    protected void onInitControls() {
        _drawerLayout = (DrawerLayout) findViewById(R.id.drawer_layout);
        _uiLvLeftMenu = (ListView) findViewById(R.id.uiLvLeftMenu);

    }
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        _handler = new Handler();
        if (savedInstanceState == null){
            _navItemIndex = 0;
            CURRENT_TAG = TAG_HOME;
            loadHomeFragment();
        }

        LocationService.killService();

        /***** For start Service  ****/
        Intent myIntent = new Intent(DNAApplication.context, LocationService.class);
        DNAApplication.context.startService(myIntent);
//        LocationService.instance().startLocationUpdates(this);
        getData();
    }

    @Override
    protected void onRegisterEvents() {
        _uiLvLeftMenu.setOnItemClickListener(new ListView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> arg0, View view, int position, long arg3) {
                view.setSelected(true);
                selectLeftMenuItem(position, false);
            }
        });

        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        ActionBarDrawerToggle toggle = new ActionBarDrawerToggle(
                this, _drawerLayout, toolbar, R.string.navigation_drawer_open, R.string.navigation_drawer_close);
        _drawerLayout.addDrawerListener(toggle);
        _drawerLayout.addDrawerListener(this);
        toggle.syncState();
    }

    @Override
    protected void onInitContentView() {
        setContentView(R.layout.activity_main);

    }

    @Override
    protected void onInitData() {
        super.onInitData();
        ClientResource clientResource = AuthenticationCache.getCurrentLocation().getClientResource();
        ClientResource.DetailResource []detailResources = clientResource.getDetails();

        _leftMenuItems.add(new LeftMenuItem(detailResources[0].displayText, ContextCompat.getDrawable(getBaseContext(),R.drawable.ic_home_black_36dp)));
        _leftMenuItems.add(new LeftMenuItem(detailResources[1].displayText,ContextCompat.getDrawable(getBaseContext(),R.drawable.ic_event_black_36dp)));
        _leftMenuItems.add(new LeftMenuItem(detailResources[2].displayText,ContextCompat.getDrawable(getBaseContext(),R.drawable.ic_assignment_black_36dp)));
        _leftMenuItems.add(new LeftMenuItem(detailResources[3].displayText,ContextCompat.getDrawable(getBaseContext(),R.drawable.ic_info_outline_black_36dp)));
        _leftMenuItems.add(new LeftMenuItem(detailResources[4].displayText,ContextCompat.getDrawable(getBaseContext(),R.drawable.ic_add_alert_black_36dp)));
        _leftMenuItems.add(new LeftMenuItem(detailResources[5].displayText,ContextCompat.getDrawable(getBaseContext(),R.drawable.ic_settings_black_36dp)));

        _leftMenuAdapter = new LeftMenuAdapter(this, _leftMenuItems);
        _uiLvLeftMenu.setAdapter(_leftMenuAdapter);

    }
    @Override
    public void onBackPressed() {
        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        if (drawer.isDrawerOpen(GravityCompat.START)) {
            drawer.closeDrawer(GravityCompat.START);
        } else {
            super.onBackPressed();
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
//        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }

    private void selectLeftMenuItem(int position, boolean ignoreLoading) {
        _navItemIndex = position;
        CURRENT_TAG = TAGS[_navItemIndex];
        loadHomeFragment();
    }

    private void selectNavMenu(){
        if(_leftMenuAdapter != null){
            _leftMenuAdapter.setSelectedItem(_navItemIndex);
            _leftMenuAdapter.notifyDataSetChanged();
        }

    }
    private void setToolbarTitle(){
        String []activityTitles = getResources().getStringArray(R.array.nav_item_activity_titles);

        getSupportActionBar().setTitle(AuthenticationCache.getTitleWithKey(activityTitles[_navItemIndex]));
    }

    private void loadHomeFragment() {
        // selecting appropriate nav menu item
        selectNavMenu();

        // set toolbar title
        setToolbarTitle();

        // if user select the current navigation menu again, don't do anything
        // just close the navigation drawer
        if (getSupportFragmentManager().findFragmentByTag(CURRENT_TAG) != null) {
            _drawerLayout.closeDrawers();
            return;
        }

        Runnable mPendingRunnable = new Runnable() {
            @Override
            public void run() {
                // update the main content by replacing fragments
                Fragment fragment =  getHomeFragment();

                FragmentTransaction fragmentTransaction = getSupportFragmentManager().beginTransaction();
                fragmentTransaction.setCustomAnimations(android.R.anim.fade_in,
                        android.R.anim.fade_out);
                fragmentTransaction.replace(R.id.content_main, fragment, CURRENT_TAG);
                fragmentTransaction.commitAllowingStateLoss();
            }
        };

        // If mPendingRunnable is not null, then add to the message queue
        if (mPendingRunnable != null) {
            _handler.post(mPendingRunnable);
        }


        //Closing drawer on item click
        _drawerLayout.closeDrawers();

        // refresh toolbar menu
        invalidateOptionsMenu();
    }
    private Fragment getHomeFragment() {
        switch (_navItemIndex) {
            case 0:
                // home
                return new HomeFragment();
            case 1:
                return new UpcomingEventFragment();
            case 2:
                return new RequestServiceFragment();
            case 3:
                return new LocationInforFragment();
            case 4:
                return new StreetAlertFragment();
            case 5:
                return new SettingsFragment();
            default:
                return new HomeFragment();
        }
    }

    @Override
    public void onDrawerOpened(View arg0) {
        hideSoftKeyboard();
    }

    @Override
    public void onDrawerClosed(View arg0) {
        hideSoftKeyboard();
    }

    @Override
    public void onDrawerSlide(View arg0, float arg1) {

    }

    @Override
    public void onDrawerStateChanged(int arg0) {

    }

    private void checkLocation(){
        Location location = null;
        if (LocationService.isServiceRunning() && LocationService.instance() != null) {
            location = LocationService.instance().getCurrentLocation();
//            double loc = location.getLongitude();
//            double lat = location.getLatitude();
        }

//        if (showToastIfNoLocationRetrieved && location == null) {
//            ToastHelper.showErrorToast(R.string.error_no_location_service_enabled);
//        }

    }
    private void getData(){
        checkLocation();
//        getClientResource();
    }
    private void getClientResource(){
        showLoading();
        ApiClientUsage.getClientResource(AuthenticationCache.getCurrentLocation().getIdLoc(), getClientResourceCallback());
    }

    private ResponseCallback getClientResourceCallback(){
        return new ResponseCallback(this){
            @Override
            public void endSucceeded(Object object) {

                hideLoading();
            }

            @Override
            public void endFailed(String result) {
                super.endFailed(result);
            }

        };
    }


    // tags used to attach the fragments
    private static final String TAG_HOME = "home";
    private static final String TAG_UPCOMING_EVENT = "upcoming_event";
    private static final String TAG_REQUEST_SERVICE = "request_service";
    private static final String TAG_LOCATION_INFOR = "location_infor";
    private static final String TAG_STREET_ALERT = "street_alert";
    private static final String TAG_SETTINGS = "settings";
    private static final String[] TAGS  ={TAG_HOME,TAG_UPCOMING_EVENT,TAG_REQUEST_SERVICE, TAG_LOCATION_INFOR, TAG_STREET_ALERT, TAG_SETTINGS};
    public static String CURRENT_TAG = TAG_HOME;
    private int _navItemIndex = 0;
    //UI
    private ListView _uiLvLeftMenu;
    private DrawerLayout _drawerLayout;
    private Handler _handler;

    //variable
    private ArrayList<LeftMenuItem> _leftMenuItems = new ArrayList<>();
    private LeftMenuAdapter _leftMenuAdapter ;
}
