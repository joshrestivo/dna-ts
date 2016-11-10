package cas_group.com.dnamobile.fragment;

import android.content.Context;
import android.net.Uri;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.SearchView;

import java.util.ArrayList;

import cas_group.com.dnamobile.R;
import cas_group.com.dnamobile.activity.MainActivity;
import cas_group.com.dnamobile.apdater.BulletinAdapter;
import cas_group.com.dnamobile.apdater.LocationInforAdapter;
import cas_group.com.dnamobile.api.ApiClientUsage;
import cas_group.com.dnamobile.api.ResponseCallback;
import cas_group.com.dnamobile.models.BaseModel;
import cas_group.com.dnamobile.models.Building;
import cas_group.com.dnamobile.models.Bulletin;

/**
 * Created by kuccu on 10/26/16.
 */

public class LocationInforFragment extends Fragment {

    
    public LocationInforFragment() {
        // Required empty public constructor
    }


    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View rootView = inflater.inflate(R.layout.fragment_location_infor, container, false);

        _uiSearchView = (SearchView) rootView.findViewById(R.id.uiSearchView);
        _uiListEmail = (RecyclerView) rootView.findViewById(R.id.uiListEvent);
        LinearLayoutManager horizontalLayoutManagaer
                = new LinearLayoutManager(getActivity(), LinearLayoutManager.VERTICAL, false);
        _uiListEmail.setLayoutManager(horizontalLayoutManagaer);

        onInitData();

        _uiSearchView.setOnQueryTextListener(new SearchView.OnQueryTextListener() {
            @Override
            public boolean onQueryTextSubmit(String query) {

                return true;
            }

            @Override
            public boolean onQueryTextChange(String newText) {
                return true;
            }
        });
        return rootView;

    }



    protected void onInitData(){
        _adapter = new LocationInforAdapter(getActivity(), _items);
        _uiListEmail.setAdapter(_adapter);
        _adapter.notifyDataSetChanged();

        ApiClientUsage.getBuildings(_currentPage, getBuildingcallback());
    }

    private ResponseCallback getBuildingcallback(){
        return new ResponseCallback((MainActivity)getActivity()){
            @Override
            public void endSucceeded(ArrayList<BaseModel> bulletins) {
                for (int i = 0; i < bulletins.size(); i++) {
                    Building bulletin = (Building) bulletins.get(i);
                    _items.add(bulletin);
                }
                _uiListEmail.setAdapter(_adapter);
                _adapter.notifyDataSetChanged();
            }

            @Override
            public void endFailed(String result) {
                super.endFailed(result);
            }

        };
    }

    private RecyclerView _uiListEmail;
    private SearchView _uiSearchView;

    private int _currentPage = 1;
    private boolean _isLoading = true;
    private LocationInforAdapter _adapter;

    private ArrayList<Building> _items = new ArrayList<>();
}
