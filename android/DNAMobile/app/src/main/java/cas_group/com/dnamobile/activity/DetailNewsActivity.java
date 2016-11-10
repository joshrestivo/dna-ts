package cas_group.com.dnamobile.activity;

import android.os.Bundle;

import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import cas_group.com.dnamobile.R;
import cas_group.com.dnamobile.models.NewFeed;
import cas_group.com.dnamobile.utils.GraphicsUtil;

/**
 * Created by kuccu on 10/27/16.
 */

public class DetailNewsActivity extends BaseAppCompatActivity {
    @Override
    protected void onInitControls() {
        _uiBtnTitle = (Button)findViewById(R.id.uiBtnTitle);
        _uiBtnDataSource = (Button)findViewById(R.id.uiBtnDataSource);
        _uiTxtContent = (TextView)findViewById(R.id.uiTxtContent);
        _uiImageView = (ImageView)findViewById(R.id.uiImageNews);
    }
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

    }
    @Override
    protected void onRegisterEvents() {
        _uiBtnTitle.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

            }
        });

        _uiBtnDataSource.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

            }
        });
    }

    @Override
    protected void onInitData() {
        super.onInitData();
        _link = getIntent().getExtras().getString("link");
        _title = getIntent().getExtras().getString("title");
        _descript = getIntent().getExtras().getString("desc");
        _imageUrl = getIntent().getExtras().getString("imageUrl");

        _uiBtnTitle.setText(_title);
        _uiTxtContent.setText(_descript);
        GraphicsUtil.displayPhoto(_context, _imageUrl, _uiImageView);

    }

    @Override
    protected void onInitContentView() {
        setContentView(R.layout.activity_detail_news);
//        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
//        setSupportActionBar(toolbar);


    }

    private ImageView _uiImageView;
    private Button _uiBtnTitle;
    private TextView _uiTxtContent;
    private Button _uiBtnDataSource;

    private String _link;
    private String _title;
    private String _imageUrl;
    private String _descript;

}
