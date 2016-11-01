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
import cas_group.com.dnamobile.apdater.LocationInforAdapter;
import cas_group.com.dnamobile.apdater.UpcomingEventAdapter;
import cas_group.com.dnamobile.models.BuildingLocation;
import cas_group.com.dnamobile.models.UpcomingEvent;

/**
 * Created by kuccu on 10/26/16.
 */

public class LocationInforFragment extends Fragment {


    private OnFragmentInteractionListener mListener;

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

    // TODO: Rename method, update argument and hook method into UI event
    public void onButtonPressed(Uri uri) {
        if (mListener != null) {
            mListener.onFragmentInteraction(uri);
        }
    }

    @Override
    public void onAttach(Context context) {
        super.onAttach(context);
//        if (context instanceof OnFragmentInteractionListener) {
//            mListener = (OnFragmentInteractionListener) context;
//        } else {
//            throw new RuntimeException(context.toString()
//                    + " must implement OnFragmentInteractionListener");
//        }
    }

    @Override
    public void onDetach() {
        super.onDetach();
        mListener = null;
    }

    /**
     * This interface must be implemented by activities that contain this
     * fragment to allow an interaction in this fragment to be communicated
     * to the activity and potentially other fragments contained in that
     * activity.
     * <p>
     * See the Android Training lesson <a href=
     * "http://developer.android.com/training/basics/fragments/communicating.html"
     * >Communicating with Other Fragments</a> for more information.
     */
    public interface OnFragmentInteractionListener {
        // TODO: Update argument type and name
        void onFragmentInteraction(Uri uri);
    }




    protected void onInitData(){
        _items.add(new BuildingLocation("test","test","https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQoNSAIzRg9H-AsYfHjaYw8LF5dRhwAkXh6aBftoxuceT_YRt7-aw"));
        _items.add(new BuildingLocation("test","test","https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQoNSAIzRg9H-AsYfHjaYw8LF5dRhwAkXh6aBftoxuceT_YRt7-aw"));
        _items.add(new BuildingLocation("test","test","https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQoNSAIzRg9H-AsYfHjaYw8LF5dRhwAkXh6aBftoxuceT_YRt7-aw"));
        _items.add(new BuildingLocation("test","test","https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQoNSAIzRg9H-AsYfHjaYw8LF5dRhwAkXh6aBftoxuceT_YRt7-aw"));
        _items.add(new BuildingLocation("test","test","https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQoNSAIzRg9H-AsYfHjaYw8LF5dRhwAkXh6aBftoxuceT_YRt7-aw"));
        _items.add(new BuildingLocation("test","test","https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQoNSAIzRg9H-AsYfHjaYw8LF5dRhwAkXh6aBftoxuceT_YRt7-aw"));
        _items.add(new BuildingLocation("test","test","https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQoNSAIzRg9H-AsYfHjaYw8LF5dRhwAkXh6aBftoxuceT_YRt7-aw"));
        _items.add(new BuildingLocation("test","test","https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQoNSAIzRg9H-AsYfHjaYw8LF5dRhwAkXh6aBftoxuceT_YRt7-aw"));
        _items.add(new BuildingLocation("test","test","https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQoNSAIzRg9H-AsYfHjaYw8LF5dRhwAkXh6aBftoxuceT_YRt7-aw"));

        _adapter = new LocationInforAdapter(getActivity(), _items);
        _uiListEmail.setAdapter(_adapter);
        _adapter.notifyDataSetChanged();
    }

    private RecyclerView _uiListEmail;
    private SearchView _uiSearchView;

    private LocationInforAdapter _adapter;

    private ArrayList<BuildingLocation> _items = new ArrayList<>();
}
