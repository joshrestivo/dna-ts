package cas_group.com.dnamobile.activity;

import android.content.Intent;
import android.os.Bundle;

import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import cas_group.com.dnamobile.R;
import cas_group.com.dnamobile.models.NewFeed;
import cas_group.com.dnamobile.utils.GraphicsUtil;

/**
 * Created by kuccu on 10/27/16.
 */

public class DetailLocationActivity extends BaseAppCompatActivity {
    @Override
    protected void onInitControls() {
        _uiBtnTitle = (Button)findViewById(R.id.uiBtnTitle);
        _uiTxtAddress = (TextView)findViewById(R.id.uiLblAddress);
        _uiTxtZipcode = (TextView) findViewById(R.id.uiLblZipCode);
        _uiImageView = (ImageView)findViewById(R.id.uiImageInfor);

        _uiPnlContact = (LinearLayout) findViewById(R.id.uiPnlContact);

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

        _uiPnlContact.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //show email
                final Intent emailIntent = new Intent(android.content.Intent.ACTION_SEND);

                emailIntent.setType("plain/text");
                emailIntent.putExtra(android.content.Intent.EXTRA_EMAIL, new String[]{"to@email.com"});
                emailIntent.putExtra(android.content.Intent.EXTRA_SUBJECT, "Subject");
                emailIntent.putExtra(android.content.Intent.EXTRA_TEXT, "Text");

                startActivity(Intent.createChooser(emailIntent, "Send mail..."));
            }
        });

    }

    @Override
    protected void onInitData() {
        super.onInitData();
        _zipCode = getIntent().getExtras().getString("zipCode");
        _title = getIntent().getExtras().getString("title");
        _descript = getIntent().getExtras().getString("desc");
        _imageUrl = getIntent().getExtras().getString("imageUrl");

        _uiBtnTitle.setText(_title);
        _uiTxtAddress.setText(_descript);
        _uiTxtZipcode.setText(_zipCode);

        GraphicsUtil.displayPhoto(_context, _imageUrl, _uiImageView);

    }

    @Override
    protected void onInitContentView() {
        setContentView(R.layout.activity_detail_location);
//        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
//        setSupportActionBar(toolbar);


    }

    private ImageView _uiImageView;
    private Button _uiBtnTitle;
    private TextView _uiTxtAddress;
    private TextView _uiTxtZipcode;

    private LinearLayout _uiPnlContact;

    private String _zipCode;
    private String _title;
    private String _imageUrl;
    private String _descript;

}
