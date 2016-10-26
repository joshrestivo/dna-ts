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

public class UpcomingEventFragment extends Fragment {


    private OnFragmentInteractionListener mListener;

    public UpcomingEventFragment() {
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
        View rootView = inflater.inflate(R.layout.fragment_upcoming_event, container, false);

        _uiListEmail = (RecyclerView) rootView.findViewById(R.id.uiListEvent);
        LinearLayoutManager horizontalLayoutManagaer
                = new LinearLayoutManager(getActivity(), LinearLayoutManager.VERTICAL, false);
        _uiListEmail.setLayoutManager(horizontalLayoutManagaer);
        onInitData();
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
        _items.add(new UpcomingEvent("test","test","test"));
        _items.add(new UpcomingEvent("test","test","test"));
        _items.add(new UpcomingEvent("test","test","test"));
        _items.add(new UpcomingEvent("test","test","test"));
        _items.add(new UpcomingEvent("test","test","test"));

        _adapter = new UpcomingEventAdapter(getActivity(), _items);
        _uiListEmail.setAdapter(_adapter);
        _adapter.notifyDataSetChanged();
    }

    private RecyclerView _uiListEmail;
    private UpcomingEventAdapter _adapter;

    private ArrayList<UpcomingEvent> _items = new ArrayList<>();
}
