package cas_group.com.dnamobile.apdater;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import java.util.List;

import cas_group.com.dnamobile.R;
import cas_group.com.dnamobile.models.StreetAlert;
import cas_group.com.dnamobile.utils.GraphicsUtil;

/**
 * Created by kuccu on 10/25/16.
 */

public class StreetAlertAdapter extends RecyclerView.Adapter<StreetAlertAdapter.ViewHolder> {


    public class ViewHolder extends RecyclerView.ViewHolder {
        public TextView uiTxtTitle;
        public TextView uiTxtContent;
        public ImageView uiImagview;
        public ViewHolder(View view) {
            super(view);
            uiTxtTitle = (TextView) view.findViewById(R.id.uiTxtTitle);
            uiTxtContent = (TextView) view.findViewById(R.id.uiTxtContent);
            uiImagview = (ImageView) view.findViewById(R.id.uiImageView);
        }
    }



    public StreetAlertAdapter(Context context, List<StreetAlert> horizontalList) {
        _context = context;
        this.items = horizontalList;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View itemView = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.list_item_street_alert, parent, false);

        return new ViewHolder(itemView);
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, final int position) {
        GraphicsUtil.displayPhoto(_context, "http://www.mappery.com/maps/Poznan-Street-Map.png", holder.uiImagview);
//        holder.txtView.setText(horizontalList.get(position));

//        holder.txtView.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View v) {
//
//            }
//        });
    }

    @Override
    public int getItemCount() {
        return items.size();
    }

    private List<StreetAlert> items;
    private Context _context;
}
