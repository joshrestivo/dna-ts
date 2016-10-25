package cas_group.com.dnamobile.apdater;

import android.annotation.SuppressLint;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import java.util.ArrayList;

import cas_group.com.dnamobile.R;
import cas_group.com.dnamobile.models.LeftMenuItem;

/**
 * Created by kuccu on 10/17/16.
 */

public class LeftMenuAdapter extends ArrayAdapter<LeftMenuItem>{

    public LeftMenuAdapter(Context context, ArrayList<LeftMenuItem> items) {
        super(context, 0, items);

        _dataSource = items;
        _context = context;
        _inflater = (LayoutInflater) _context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);

    }

    @SuppressLint("InflateParams")
    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        ViewHolder holder;
        if (convertView == null) {
            convertView = _inflater.inflate(R.layout.list_item_leftmenu, null);
            holder = new ViewHolder();
            holder.uiLblName = (TextView) convertView.findViewById(R.id.uiTxtTitle);
            holder.uiImageAvatar = (ImageView) convertView.findViewById(R.id.uiImageIcon);

            convertView.setTag(holder);
        } else  {
            holder = (ViewHolder)convertView.getTag();
        }
        LeftMenuItem item = _dataSource.get(position);
        holder.uiLblName.setText(item.getTitle());
        holder.uiImageAvatar.setImageDrawable(item.getDrawable());
        return convertView;
    }

    private ArrayList<LeftMenuItem> _dataSource;
    private Context _context;
    private LayoutInflater _inflater;

    private static class ViewHolder {
        public TextView uiLblName;
        public ImageView uiImageAvatar;


    }
}
