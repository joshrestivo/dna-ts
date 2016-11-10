package cas_group.com.dnamobile.activity;

import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import java.util.ArrayList;

import cas_group.com.dnamobile.R;
import cas_group.com.dnamobile.apdater.LocationAdapter;

import cas_group.com.dnamobile.api.ApiClientUsage;
import cas_group.com.dnamobile.api.ResponseCallback;
import cas_group.com.dnamobile.models.BaseModel;
import cas_group.com.dnamobile.models.Location;

/**
 * Created by kuccu on 11/9/16.
 */

public class LocationsActivity extends BaseAppCompatActivity {
    @Override
    protected void onInitControls() {
        _uiListView = (RecyclerView) findViewById(R.id.uiListView);

        LinearLayoutManager horizontalLayoutManagaer
                = new LinearLayoutManager(this, LinearLayoutManager.VERTICAL, false);
        _uiListView.setLayoutManager(horizontalLayoutManagaer);
    }
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

    }
    @Override
    protected void onRegisterEvents() {
    }
    @Override
    protected void onInitContentView() {
        setContentView(R.layout.activity_locations);

    }

    @Override
    protected void onInitData() {
        super.onInitData();
        showLoading();
        ApiClientUsage.getLocations(_currentPage,getLocationcallback());
        setTitle("Locations");
    }
    private ResponseCallback getLocationcallback(){
        return new ResponseCallback(this){
            @Override
            public void endSucceeded(ArrayList<BaseModel> locations) {
                hideLoading();
                for (int i = 0; i < locations.size(); i++) {
                    Location location = (Location) locations.get(i);
                    _items.add(location);
                }
                _adapter = new LocationAdapter(_context, _items);
                _uiListView.setAdapter(_adapter);
                _adapter.notifyDataSetChanged();
            }

            @Override
            public void endFailed(String result) {
                super.endFailed(result);
            }

        };
    }

    private RecyclerView _uiListView;
    private LocationAdapter _adapter;
    private int _currentPage = 1;

    private ArrayList<Location> _items = new ArrayList<>();

}
