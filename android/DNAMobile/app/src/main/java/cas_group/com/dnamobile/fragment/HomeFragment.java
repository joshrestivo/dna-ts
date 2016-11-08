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
import cas_group.com.dnamobile.apdater.BulletinAdapter;
import cas_group.com.dnamobile.apdater.NewFeedAdapter;
import cas_group.com.dnamobile.api.ApiClientUsage;
import cas_group.com.dnamobile.api.ResponseCallback;
import cas_group.com.dnamobile.models.BaseModel;
import cas_group.com.dnamobile.models.Bulletin;
import cas_group.com.dnamobile.models.NewFeed;

/**
 * Created by kuccu on 10/26/16.
 */

public class HomeFragment extends Fragment {


    private OnFragmentInteractionListener mListener;

    public HomeFragment() {
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
        View rootView = inflater.inflate(R.layout.fragment_content_main, container, false);

        _uiHomeNewLvl = (RecyclerView) rootView.findViewById(R.id.uiLvHomeNew);
        _uiHomeBulletin = (RecyclerView) rootView.findViewById(R.id.uiLvBulletin);

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
        _news = new ArrayList<>();
        _bulletins = new ArrayList<>();

        //layout property
        LinearLayoutManager horizontalLayoutManagaer
                = new LinearLayoutManager(getActivity(), LinearLayoutManager.HORIZONTAL, false);
        _uiHomeNewLvl.setLayoutManager(horizontalLayoutManagaer);

        LinearLayoutManager horizontalLayoutManagaerBulletin
                = new LinearLayoutManager(getActivity(), LinearLayoutManager.HORIZONTAL, false);

        _uiHomeBulletin.setLayoutManager(horizontalLayoutManagaerBulletin);


        _newFeedAdapter = new NewFeedAdapter(getActivity(), _news);
        _uiHomeNewLvl.setAdapter(_newFeedAdapter);

        _bulletinAdapter = new BulletinAdapter(getActivity(), _bulletins);
        _uiHomeBulletin.setAdapter(_bulletinAdapter);

        //
        ApiClientUsage.getNewFeeds(_currentPageNews,getNewFeedcallback());

        ApiClientUsage.getBulletins(_currentPageBulletin,getBulletincallback());
    }
    private ResponseCallback getNewFeedcallback(){
        return new ResponseCallback((MainActivity)getActivity()){
            @Override
            public void endSucceeded(ArrayList<BaseModel> bulletins) {
                for (int i = 0; i < bulletins.size(); i++) {
                    Bulletin bulletin = (Bulletin) bulletins.get(i);
                    _bulletins.add(bulletin);
                }
                _newFeedAdapter = new NewFeedAdapter(getActivity(), _news);
                _uiHomeBulletin.setAdapter(_bulletinAdapter);
                _newFeedAdapter.notifyDataSetChanged();
            }

            @Override
            public void endFailed(String result) {
                super.endFailed(result);
            }

        };
    }
    private ResponseCallback getBulletincallback(){
        return new ResponseCallback((MainActivity)getActivity()){
            @Override
            public void endSucceeded(ArrayList<BaseModel> bulletins) {
                for (int i = 0; i < bulletins.size(); i++) {
                    Bulletin bulletin = (Bulletin) bulletins.get(i);
                    _bulletins.add(bulletin);
                }
                _bulletinAdapter = new BulletinAdapter(getActivity(), _bulletins);
                _uiHomeBulletin.setAdapter(_bulletinAdapter);
                _bulletinAdapter.notifyDataSetChanged();
            }

            @Override
            public void endFailed(String result) {
                super.endFailed(result);
            }

        };
    }

    private RecyclerView _uiHomeNewLvl;
    private RecyclerView _uiHomeBulletin;


    private ArrayList<NewFeed> _news;
    private ArrayList<Bulletin> _bulletins;

    private NewFeedAdapter _newFeedAdapter;
    private BulletinAdapter _bulletinAdapter;

    private int _currentPageNews = 1;
    private int _currentPageBulletin = 1;


}
