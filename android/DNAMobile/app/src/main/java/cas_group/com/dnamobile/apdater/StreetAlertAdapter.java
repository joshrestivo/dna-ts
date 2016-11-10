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
        public ViewHolder(View view) {
            super(view);
            uiTxtTitle = (TextView) view.findViewById(R.id.uiTxtTitle);
            uiTxtContent = (TextView) view.findViewById(R.id.uiTxtContent);
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
        StreetAlert streetAlert = items.get(position);
        holder.uiTxtTitle.setText(streetAlert.getDate());
        holder.uiTxtContent.setText(streetAlert.getLink());

    }

    @Override
    public int getItemCount() {
        return items.size();
    }

    private List<StreetAlert> items;
    private Context _context;
}
