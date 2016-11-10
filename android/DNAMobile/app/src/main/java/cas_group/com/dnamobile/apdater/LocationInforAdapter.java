package cas_group.com.dnamobile.apdater;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.Toast;

import java.util.List;

import cas_group.com.dnamobile.R;
import cas_group.com.dnamobile.models.Building;
import cas_group.com.dnamobile.utils.CircularImageView;
import cas_group.com.dnamobile.utils.GraphicsUtil;

/**
 * Created by kuccu on 10/25/16.
 */

public class LocationInforAdapter extends RecyclerView.Adapter<LocationInforAdapter.ViewHolder> {


    public class ViewHolder extends RecyclerView.ViewHolder {
        public TextView txtTitle;
        public TextView txtDesc;
        public CircularImageView uiImageView;
        public ViewHolder(View view) {
            super(view);
            txtTitle = (TextView) view.findViewById(R.id.uiLblTitle);
            txtDesc = (TextView) view.findViewById(R.id.uiLblDesc);
            uiImageView = (CircularImageView)view.findViewById(R.id.uiImageInfor);
        }
    }



    public LocationInforAdapter(Context context, List<Building> horizontalList) {
        _context = context;
        this.items = horizontalList;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View itemView = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.list_item_location_infor, parent, false);

        return new ViewHolder(itemView);
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, final int position) {
        Building building = items.get(position);
        holder.txtTitle.setText(building.getName());
        holder.txtDesc.setText(building.getAddress());
        GraphicsUtil.displayPhoto(_context, building.getImageUrl(), holder.uiImageView);

        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Toast.makeText(_context,"test", Toast.LENGTH_LONG).show();
            }
        });


    }

    @Override
    public int getItemCount() {
        return items.size();
    }

    private List<Building> items;
    private Context _context;
}
