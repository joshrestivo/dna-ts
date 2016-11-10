package cas_group.com.dnamobile.apdater;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.List;

import cas_group.com.dnamobile.R;
import cas_group.com.dnamobile.activity.BaseAppCompatActivity;
import cas_group.com.dnamobile.api.ApiClientUsage;
import cas_group.com.dnamobile.api.ResponseCallback;
import cas_group.com.dnamobile.models.AuthenticationCache;
import cas_group.com.dnamobile.models.BaseModel;
import cas_group.com.dnamobile.models.Building;
import cas_group.com.dnamobile.models.Location;
import cas_group.com.dnamobile.utils.CircularImageView;

/**
 * Created by kuccu on 10/25/16.
 */

public class LocationAdapter extends RecyclerView.Adapter<LocationAdapter.ViewHolder> {


    public class ViewHolder extends RecyclerView.ViewHolder {
        public TextView txtTitle;
        public TextView txtDesc;
        public ImageView uiImageSelected;
        public ViewHolder(View view) {
            super(view);
            txtTitle = (TextView) view.findViewById(R.id.uiLblTitle);
            txtDesc = (TextView) view.findViewById(R.id.uiLblDesc);
            uiImageSelected = (ImageView)view.findViewById(R.id.uiImageInfor);
        }
    }



    public LocationAdapter(Context context, List<Location> horizontalList) {
        _context = context;
        this.items = horizontalList;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View itemView = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.list_item_location, parent, false);

        return new ViewHolder(itemView);
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, final int position) {
        final Location location = items.get(position);

        holder.txtTitle.setText(location.getNameLoc());
        holder.txtDesc.setText(location.getCity());
        if(location.getIdLoc() == AuthenticationCache.getCurrentLocation().getIdLoc()){
            holder.uiImageSelected.setVisibility(View.VISIBLE);
        }else{
            holder.uiImageSelected.setVisibility(View.GONE);
        }
        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Toast.makeText(_context,"test", Toast.LENGTH_LONG).show();
                holder.uiImageSelected.setVisibility(View.VISIBLE);
                ApiClientUsage.getClientResource(location.getIdLoc(), getLocationcallback());

            }
        });
    }

    private ResponseCallback getLocationcallback(){
        return new ResponseCallback((BaseAppCompatActivity)_context){
            @Override
            public void endSucceeded(Object object) {
                ((BaseAppCompatActivity) _context).runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        notifyDataSetChanged();
                    }
                });

            }

            @Override
            public void endFailed(String result) {
                super.endFailed(result);
            }

        };
    }
    @Override
    public int getItemCount() {
        return items.size();
    }

    private List<Location> items;
    private Context _context;
}
