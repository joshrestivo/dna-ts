package cas_group.com.dnamobile.apdater;

import android.content.Context;
import android.content.Intent;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import java.util.List;

import cas_group.com.dnamobile.R;
import cas_group.com.dnamobile.activity.DetailNewsActivity;
import cas_group.com.dnamobile.models.NewFeed;
import cas_group.com.dnamobile.utils.GraphicsUtil;

/**
 * Created by kuccu on 10/25/16.
 */

public class NewFeedAdapter extends RecyclerView.Adapter<NewFeedAdapter.NewsViewHolder> {
    private static int MAX_LENG_CONTENT = 200;
    private Context _context;
    private List<NewFeed> horizontalList;

    public class NewsViewHolder extends RecyclerView.ViewHolder {
        public TextView uiTxtTitle;
        public TextView uiTxtContent;
        public ImageView uiImageView;

        public NewsViewHolder(View view) {
            super(view);
            uiTxtTitle = (TextView) view.findViewById(R.id.uiTxtTitle);
            uiTxtContent = (TextView) view.findViewById(R.id.uiTxtContent);
            uiImageView = (ImageView) view.findViewById(R.id.uiImageView);
        }
    }



    public NewFeedAdapter(Context context, List<NewFeed> horizontalList) {
        this.horizontalList = horizontalList;
        _context = context;
    }

    @Override
    public NewsViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View itemView = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.list_item_news, parent, false);

        return new NewsViewHolder(itemView);
    }

    @Override
    public void onBindViewHolder(final NewsViewHolder holder, final int position) {
        final NewFeed newFeed = horizontalList.get(position);
        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //goto detail
                Intent detailIntent = new Intent(_context, DetailNewsActivity.class);
                detailIntent.putExtra("link",newFeed.getLink());
                detailIntent.putExtra("title",newFeed.getTitle());
                detailIntent.putExtra("desc",newFeed.getDescription());
                detailIntent.putExtra("imageUrl",newFeed.getThumbnail_url());
                _context.startActivity(detailIntent);

            }
        });
        if(newFeed.getThumbnail_url().isEmpty()){
            holder.uiImageView.setVisibility(View.GONE);
        }else {
            holder.uiImageView.setVisibility(View.VISIBLE);
            GraphicsUtil.displayPhoto(_context, newFeed.getThumbnail_url(), holder.uiImageView);
        }

        holder.uiTxtTitle.setText(newFeed.getTitle());
        if (newFeed.getDescription().length() > MAX_LENG_CONTENT){
            holder.uiTxtContent.setText(newFeed.getDescription().substring(0, MAX_LENG_CONTENT - 1) + "...");
        }else{
            holder.uiTxtContent.setText(newFeed.getDescription());
        }

    }

    @Override
    public int getItemCount() {
        return horizontalList.size();
    }
}
