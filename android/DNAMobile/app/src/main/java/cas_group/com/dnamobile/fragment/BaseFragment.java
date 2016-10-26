package cas_group.com.dnamobile.fragment;

import android.app.ActionBar;
import android.content.pm.ActivityInfo;
import android.os.Bundle;
import android.support.v4.app.Fragment;

/**
 * Created by kuccu on 10/26/16.
 */

public class BaseFragment extends Fragment {
    private boolean _onDefaultFlowOfCreation = true;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
//		PFApplication.context = getApplicationContext();
        if (_onDefaultFlowOfCreation) {
            onInitArguments();
            onInitContentView();
            onInitControls();
            onInitLayout();
            onRegisterEvents();
            onInitData();

        }
    }


    protected void onInitArguments() {

    }

    protected void onInitContentView() {

    }

    protected void onInitLayout() {

    }

    protected void onInitControls() {

    }

    protected void onRegisterEvents() {

    }

    protected void onInitData() {

    }

    /*
    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";

    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;



    // TODO: Rename and change types and number of parameters
    public static UpcomingEventFragment newInstance(String param1, String param2) {
        UpcomingEventFragment fragment = new UpcomingEventFragment();
        Bundle args = new Bundle();
        args.putString(ARG_PARAM1, param1);
        args.putString(ARG_PARAM2, param2);
        fragment.setArguments(args);
        return fragment;
    }

     */
}
