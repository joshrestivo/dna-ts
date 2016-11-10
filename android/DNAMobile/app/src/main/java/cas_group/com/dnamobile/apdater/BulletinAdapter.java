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
import cas_group.com.dnamobile.models.Bulletin;
import cas_group.com.dnamobile.models.NewFeed;
import cas_group.com.dnamobile.utils.GraphicsUtil;

/**
 * Created by kuccu on 10/25/16.
 */

public class BulletinAdapter extends RecyclerView.Adapter<BulletinAdapter.NewsViewHolder> {
    private Context _context;
    private List<Bulletin> horizontalList;

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



    public BulletinAdapter(Context context, List<Bulletin> horizontalList) {
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
        final Bulletin bulletin = horizontalList.get(position);
        holder.uiTxtTitle.setText(bulletin.getTitle());
        holder.uiTxtContent.setText(bulletin.getDescription());

        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //goto detail
                Intent detailIntent = new Intent(_context, DetailNewsActivity.class);
                detailIntent.putExtra("link",bulletin.getTitle());
                detailIntent.putExtra("title",bulletin.getTitle());
                detailIntent.putExtra("desc",bulletin.getDescription());
                detailIntent.putExtra("imageUrl",bulletin.getImageUrl());
                _context.startActivity(detailIntent);

            }
        });
        GraphicsUtil.displayPhoto(_context, bulletin.getImageUrl(), holder.uiImageView);

    }

    @Override
    public int getItemCount() {
        return horizontalList.size();
    }
}
