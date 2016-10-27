package cas_group.com.dnamobile.apdater;

import android.content.Context;
import android.content.Intent;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import java.util.List;

import cas_group.com.dnamobile.R;
import cas_group.com.dnamobile.activity.DetailNewsActivity;
import cas_group.com.dnamobile.activity.MainActivity;
import cas_group.com.dnamobile.models.News;

/**
 * Created by kuccu on 10/25/16.
 */

public class NewsAdapter extends RecyclerView.Adapter<NewsAdapter.NewsViewHolder> {
    private Context _context;
    private List<News> horizontalList;

    public class NewsViewHolder extends RecyclerView.ViewHolder {
        public TextView txtView;

        public NewsViewHolder(View view) {
            super(view);
        }
    }



    public NewsAdapter(Context context, List<News> horizontalList) {
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

        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //goto detail
                Intent detailIntent = new Intent(_context, DetailNewsActivity.class);
                _context.startActivity(detailIntent);

            }
        });
    }

    @Override
    public int getItemCount() {
        return horizontalList.size();
    }
}
