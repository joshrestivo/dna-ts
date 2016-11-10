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

import java.util.ArrayList;

import cas_group.com.dnamobile.R;
import cas_group.com.dnamobile.activity.MainActivity;
import cas_group.com.dnamobile.apdater.UpcomingEventAdapter;
import cas_group.com.dnamobile.models.UpcomingEvent;

/**
 * Created by kuccu on 10/26/16.
 */

public class RequestServiceFragment extends Fragment {


    public RequestServiceFragment() {
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
        View rootView = inflater.inflate(R.layout.fragment_request_service, container, false);

        _uiListEmail = (RecyclerView) rootView.findViewById(R.id.uiListEvent);
        LinearLayoutManager horizontalLayoutManager
                = new LinearLayoutManager(getActivity(), LinearLayoutManager.VERTICAL, false);
        _uiListEmail.setLayoutManager(horizontalLayoutManager);
        onInitData();
        return rootView;

    }



    protected void onInitData(){

//        _adapter = new UpcomingEventAdapter(getActivity(), _items);
//        _uiListEmail.setAdapter(_adapter);
//        _adapter.notifyDataSetChanged();
    }

    private RecyclerView _uiListEmail;
    private UpcomingEventAdapter _adapter;

    private ArrayList<UpcomingEvent> _items = new ArrayList<>();
}
