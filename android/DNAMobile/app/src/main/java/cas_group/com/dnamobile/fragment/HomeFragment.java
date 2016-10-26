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
import cas_group.com.dnamobile.apdater.NewsAdapter;
import cas_group.com.dnamobile.models.News;

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
        _bulletin = new ArrayList<>();

        _news.add(new News("test","test","https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQoNSAIzRg9H-AsYfHjaYw8LF5dRhwAkXh6aBftoxuceT_YRt7-aw"));
        _news.add(new News("test","test","https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQoNSAIzRg9H-AsYfHjaYw8LF5dRhwAkXh6aBftoxuceT_YRt7-aw"));
        _news.add(new News("test","test","https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQoNSAIzRg9H-AsYfHjaYw8LF5dRhwAkXh6aBftoxuceT_YRt7-aw"));
        _news.add(new News("test","test","https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQoNSAIzRg9H-AsYfHjaYw8LF5dRhwAkXh6aBftoxuceT_YRt7-aw"));
        _news.add(new News("test","test","https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQoNSAIzRg9H-AsYfHjaYw8LF5dRhwAkXh6aBftoxuceT_YRt7-aw"));
        _news.add(new News("test","test","https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQoNSAIzRg9H-AsYfHjaYw8LF5dRhwAkXh6aBftoxuceT_YRt7-aw"));
        _news.add(new News("test","test","https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQoNSAIzRg9H-AsYfHjaYw8LF5dRhwAkXh6aBftoxuceT_YRt7-aw"));
        _news.add(new News("test","test","https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQoNSAIzRg9H-AsYfHjaYw8LF5dRhwAkXh6aBftoxuceT_YRt7-aw"));
        _news.add(new News("test","test","https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQoNSAIzRg9H-AsYfHjaYw8LF5dRhwAkXh6aBftoxuceT_YRt7-aw"));

//        _uiHomeBulletin
        LinearLayoutManager horizontalLayoutManagaer
                = new LinearLayoutManager(getActivity(), LinearLayoutManager.HORIZONTAL, false);
        _uiHomeNewLvl.setLayoutManager(horizontalLayoutManagaer);

        LinearLayoutManager horizontalLayoutManagaerBulletin
                = new LinearLayoutManager(getActivity(), LinearLayoutManager.HORIZONTAL, false);

        _uiHomeBulletin.setLayoutManager(horizontalLayoutManagaerBulletin);

        _newsAdapter = new NewsAdapter(getActivity(), _news);
        _uiHomeNewLvl.setAdapter(_newsAdapter);
        _uiHomeBulletin.setAdapter(_newsAdapter);
        _newsAdapter.notifyDataSetChanged();
    }

    private RecyclerView _uiHomeNewLvl;
    private RecyclerView _uiHomeBulletin;


    private ArrayList<News> _news;
    private ArrayList<News> _bulletin;

    private NewsAdapter _newsAdapter;
    private NewsAdapter _bulletinAdapter;
}
