package cas_group.com.dnamobile.apdater;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import org.w3c.dom.Text;

import java.util.List;

import cas_group.com.dnamobile.R;
import cas_group.com.dnamobile.models.NewFeed;
import cas_group.com.dnamobile.models.UpcomingEvent;
import cas_group.com.dnamobile.utils.GraphicsUtil;

/**
 * Created by kuccu on 10/25/16.
 */

public class UpcomingEventAdapter extends RecyclerView.Adapter<UpcomingEventAdapter.ViewHolder> {


    public class ViewHolder extends RecyclerView.ViewHolder {
        public TextView uiTxtTitle;
        public TextView uiTxtDesc;
        public ImageView uiImageView;
        public ViewHolder(View view) {
            super(view);
            uiTxtTitle = (TextView) view.findViewById(R.id.uiLblTitle);
            uiTxtDesc = (TextView) view.findViewById(R.id.uiLblDesc);
            uiImageView = (ImageView) view.findViewById(R.id.uiImageInfor);
        }
    }



    public UpcomingEventAdapter(Context context, List<NewFeed> horizontalList) {
        _context = context;
        this.items = horizontalList;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View itemView = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.list_item_upcoming, parent, false);

        return new ViewHolder(itemView);
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, final int position) {
        NewFeed newFeed = items.get(position);
        holder.uiTxtTitle.setText(newFeed.getTitle());
        holder.uiTxtDesc.setText(newFeed.getDescription());
        GraphicsUtil.displayPhoto(_context, newFeed.getThumbnail_url(), holder.uiImageView);


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

    private List<NewFeed> items;
    private Context _context;
}
