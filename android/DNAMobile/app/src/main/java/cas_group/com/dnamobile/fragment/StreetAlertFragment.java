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
import android.widget.ProgressBar;

import java.util.ArrayList;

import cas_group.com.dnamobile.R;
import cas_group.com.dnamobile.activity.MainActivity;
import cas_group.com.dnamobile.apdater.StreetAlertAdapter;
import cas_group.com.dnamobile.apdater.UpcomingEventAdapter;
import cas_group.com.dnamobile.api.ApiClientUsage;
import cas_group.com.dnamobile.api.ResponseCallback;
import cas_group.com.dnamobile.models.BaseModel;
import cas_group.com.dnamobile.models.Building;
import cas_group.com.dnamobile.models.StreetAlert;
import cas_group.com.dnamobile.models.UpcomingEvent;

/**
 * Created by kuccu on 10/26/16.
 */

public class StreetAlertFragment extends Fragment {

    public StreetAlertFragment() {
        // Required empty public constructor
    }


    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {

        View rootView = inflater.inflate(R.layout.fragment_street_alert, container, false);

        _uiProgressLoading = (ProgressBar) rootView.findViewById(R.id.uiProgressLoading);
        _uiListEmail = (RecyclerView) rootView.findViewById(R.id.uiListEvent);

        final LinearLayoutManager horizontalLayoutManagaer
                = new LinearLayoutManager(getActivity(), LinearLayoutManager.VERTICAL, false);
        _uiListEmail.setLayoutManager(horizontalLayoutManagaer);
        onInitData();

        _uiListEmail.addOnScrollListener(new RecyclerView.OnScrollListener() {
            @Override
            public void onScrolled(RecyclerView recyclerView, int dx, int dy) {
                super.onScrolled(recyclerView, dx, dy);
                int totalItemCount = horizontalLayoutManagaer.getItemCount();
                int lastVisibleItem = horizontalLayoutManagaer.findLastVisibleItemPosition();

                if (_hasLoadMore && !_isLoading && totalItemCount <= (lastVisibleItem + 1)) {
                    getStreetAlerts();
                }
            }
        });
        return rootView;

    }


    protected void onInitData(){

        _adapter = new StreetAlertAdapter(getActivity(), _items);
        _uiListEmail.setAdapter(_adapter);
        _adapter.notifyDataSetChanged();
        getStreetAlerts();
    }

    private void getStreetAlerts(){
        _uiProgressLoading.setVisibility(View.VISIBLE);
        _isLoading = true;
        ApiClientUsage.getStreetAlerts(_currentPage, getStreetAlertCallback());
    }

    private ResponseCallback getStreetAlertCallback(){
        return new ResponseCallback((MainActivity)getActivity()){
            @Override
            public void endSucceeded(ArrayList<BaseModel> bulletins) {
                for (int i = 0; i < bulletins.size(); i++) {
                    StreetAlert bulletin = (StreetAlert) bulletins.get(i);
                    _items.add(bulletin);
                }
                _hasLoadMore = bulletins.size() == ApiClientUsage.PAGE_SIZE;
                if (_hasLoadMore){
                    _currentPage ++;
                }
                _adapter.notifyDataSetChanged();
                hideLoading();
            }

            @Override
            public void endFailed(String result) {
                super.endFailed(result);
                hideLoading();
            }

            @Override
            public void endFailed(Exception ex) {
                super.endFailed(ex);
                hideLoading();
            }
        };
    }

    private void hideLoading(){
        _isLoading = false;
        _uiProgressLoading.setVisibility(View.GONE);
    }

    private RecyclerView _uiListEmail;
    private StreetAlertAdapter _adapter;
    private ProgressBar _uiProgressLoading;

    private int _currentPage = 1;
    private boolean _isLoading = true;
    private boolean _hasLoadMore = true;

    private ArrayList<StreetAlert> _items = new ArrayList<>();
}
