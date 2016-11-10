package cas_group.com.dnamobile.fragment;

import android.annotation.TargetApi;
import android.content.Context;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ProgressBar;
import android.widget.TextView;

import java.util.ArrayList;

import cas_group.com.dnamobile.R;
import cas_group.com.dnamobile.activity.BaseAppCompatActivity;
import cas_group.com.dnamobile.activity.MainActivity;
import cas_group.com.dnamobile.apdater.BulletinAdapter;
import cas_group.com.dnamobile.apdater.NewFeedAdapter;
import cas_group.com.dnamobile.api.ApiClientUsage;
import cas_group.com.dnamobile.api.ResponseCallback;
import cas_group.com.dnamobile.models.AuthenticationCache;
import cas_group.com.dnamobile.models.BaseModel;
import cas_group.com.dnamobile.models.Bulletin;
import cas_group.com.dnamobile.models.Calendar;
import cas_group.com.dnamobile.models.NewFeed;

/**
 * Created by kuccu on 10/26/16.
 */

public class HomeFragment extends Fragment {


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
        _uiLblCalendar = (TextView) rootView.findViewById(R.id.uiLblCalendar);

        _uiProgressLoadingCalendar = (ProgressBar) rootView.findViewById(R.id.uiProgressLoadingCalendar);
        _uiProgressLoadingNews = (ProgressBar) rootView.findViewById(R.id.uiProgressLoadingNews);
        _uiProgressLoadingBulletin = (ProgressBar) rootView.findViewById(R.id.uiProgressLoadingBulletin);

        _uiProgressLoadingCalendar.setVisibility(View.VISIBLE);
        _uiProgressLoadingNews.setVisibility(View.VISIBLE);
        _uiProgressLoadingBulletin.setVisibility(View.VISIBLE);

        _uiBtnServiceRequest = (Button) rootView.findViewById(R.id.uiBtnServiceRequest);

        _uiBtnServiceRequest.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //
            }
        });
        onInitData();
        return rootView;

    }

    @Override
    public void onResume() {
        super.onResume();
    }

    @TargetApi(Build.VERSION_CODES.M)
    protected void onInitData(){
        _news = new ArrayList<>();
        _bulletins = new ArrayList<>();

        //layout property
        final LinearLayoutManager horizontalLayoutManagaer
                = new LinearLayoutManager(getActivity(), LinearLayoutManager.HORIZONTAL, false);
        _uiHomeNewLvl.setLayoutManager(horizontalLayoutManagaer);

        LinearLayoutManager horizontalLayoutManagaerBulletin
                = new LinearLayoutManager(getActivity(), LinearLayoutManager.HORIZONTAL, false);

        _uiHomeBulletin.setLayoutManager(horizontalLayoutManagaerBulletin);


        _newFeedAdapter = new NewFeedAdapter(getActivity(), _news);
        _uiHomeNewLvl.setAdapter(_newFeedAdapter);

        _bulletinAdapter = new BulletinAdapter(getActivity(), _bulletins);
        _uiHomeBulletin.setAdapter(_bulletinAdapter);

        getNews();
        getBulletin();
        getCalendar();

        _uiBtnServiceRequest.setText(AuthenticationCache.getTitleWithKey(getResources().getString(R.string.home_middle_request_button_text)));

        _uiHomeNewLvl.addOnScrollListener(new RecyclerView.OnScrollListener() {
            @Override
            public void onScrolled(RecyclerView recyclerView, int dx, int dy) {
                super.onScrolled(recyclerView, dx, dy);
                int totalItemCount = horizontalLayoutManagaer.getItemCount();
                int lastVisibleItem = horizontalLayoutManagaer.findLastVisibleItemPosition();

                if (_hasLoadMoreNews && !_isLoadingNews && totalItemCount <= (lastVisibleItem + 1)) {
                    //show loading
                    _uiProgressLoadingNews.setVisibility(View.VISIBLE);
                    getNews();
                }
            }
        });

        _uiHomeBulletin.addOnScrollListener(new RecyclerView.OnScrollListener() {
            @Override
            public void onScrolled(RecyclerView recyclerView, int dx, int dy) {
                super.onScrolled(recyclerView, dx, dy);
                int totalItemCount = horizontalLayoutManagaer.getItemCount();
                int lastVisibleItem = horizontalLayoutManagaer.findLastVisibleItemPosition();

                if (_hasLoadMoreBulletin && !_isLoadingBulletin && totalItemCount <= (lastVisibleItem + 1)) {
                    getBulletin();
                }
            }
        });
    }
    private void getNews(){
        _uiProgressLoadingNews.setVisibility(View.VISIBLE);
        _isLoadingNews = true;
        ApiClientUsage.getNewFeeds(_currentPageNews,getNewFeedcallback());
    }
    private void getBulletin(){
        _uiProgressLoadingBulletin.setVisibility(View.VISIBLE);
        _isLoadingBulletin = true;
        ApiClientUsage.getBulletins(_currentPageBulletin,getBulletincallback());

    }
    private ResponseCallback getNewFeedcallback(){
        return new ResponseCallback((MainActivity)getActivity()){
            @Override
            public void endSucceeded(ArrayList<BaseModel> bulletins) {
                for (int i = 0; i < bulletins.size(); i++) {
                    NewFeed bulletin = (NewFeed) bulletins.get(i);
                    _news.add(bulletin);
                }

                _newFeedAdapter.notifyDataSetChanged();
                _uiProgressLoadingNews.setVisibility(View.GONE);
                _uiHomeNewLvl.setVisibility(View.VISIBLE);
                _hasLoadMoreNews = bulletins.size() == ApiClientUsage.PAGE_SIZE;
                if (_hasLoadMoreNews){
                    _currentPageNews ++;
                }
                _isLoadingNews = false;
            }

            @Override
            public void endFailed(String result) {
                super.endFailed(result);
                hideLoadingNew();
                _uiHomeNewLvl.setVisibility(View.VISIBLE);
            }

            @Override
            public void endFailed(Exception ex) {
                super.endFailed(ex);
                hideLoadingNew();
                _uiHomeNewLvl.setVisibility(View.VISIBLE);
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

                _bulletinAdapter.notifyDataSetChanged();

                _uiHomeBulletin.setVisibility(View.VISIBLE);
                _hasLoadMoreBulletin = bulletins.size() == ApiClientUsage.PAGE_SIZE;
                if (_hasLoadMoreBulletin){
                    _currentPageBulletin ++;
                }
                hideLoadingBulletin();
            }

            @Override
            public void endFailed(String result) {
                super.endFailed(result);
                hideLoadingBulletin();
            }

            @Override
            public void endFailed(Exception ex) {
                super.endFailed(ex);
            }
        };
    }
    private void hideLoadingNew(){
        _isLoadingNews = false;
        _uiProgressLoadingNews.setVisibility(View.GONE);
    }
    private void hideLoadingBulletin(){
        _isLoadingBulletin = false;
        _uiProgressLoadingBulletin.setVisibility(View.GONE);
    }
    private void getCalendar(){
        ApiClientUsage.getCalendars(getCalendarCallback());
    }

    private ResponseCallback getCalendarCallback(){
        return new ResponseCallback((MainActivity)getActivity()){
            @Override
            public void endSucceeded(ArrayList<BaseModel> calendars) {
                String calendarText = "";
                for (int i = 0; i < calendars.size() ; i++) {
                    Calendar calendar = (Calendar) calendars.get(i);
                    String prefix = "";
                    if (i > 0) {
                        prefix = "\n\n";
                    }
                    String displayString = calendar.getShortDisplayFormat();
//                    if (displayString.length() > Length_Calendar){
//                        displayString = displayString.substring(0 , Length_Calendar - 1) + "";
//                    }

                    calendarText = calendarText + prefix + calendar.getShortDisplayFormat();

                }
                _uiLblCalendar.setText(calendarText);
//                _uiLblCalendar.setText("sdlfasdf askdf sdskf ksdf sd asldfa lskdf askdf ");
                _uiProgressLoadingCalendar.setVisibility(View.GONE);
            }

            @Override
            public void endFailed(String result) {
                super.endFailed(result);
                _uiProgressLoadingCalendar.setVisibility(View.GONE);
            }

            @Override
            public void endFailed(Exception ex) {
                super.endFailed(ex);
                _uiProgressLoadingCalendar.setVisibility(View.GONE);
            }
        };
    }

    private RecyclerView _uiHomeNewLvl;
    private RecyclerView _uiHomeBulletin;
    private Button _uiBtnServiceRequest;
    private TextView _uiLblCalendar;
    private ProgressBar _uiProgressLoadingCalendar;
    private ProgressBar _uiProgressLoadingNews;
    private ProgressBar _uiProgressLoadingBulletin;

    private ArrayList<NewFeed> _news;
    private ArrayList<Bulletin> _bulletins;

    private NewFeedAdapter _newFeedAdapter;
    private BulletinAdapter _bulletinAdapter;

    private int _currentPageNews = 1;
    private int _currentPageBulletin = 1;

    private boolean _isLoadingNews = false;
    private boolean _isLoadingBulletin = false;

    private boolean _hasLoadMoreNews = true;
    private boolean _hasLoadMoreBulletin = true;

    private static int Length_Calendar = 35;
}
