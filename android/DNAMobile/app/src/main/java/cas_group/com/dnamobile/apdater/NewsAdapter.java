package cas_group.com.dnamobile.apdater;

import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import java.util.List;

import cas_group.com.dnamobile.R;
import cas_group.com.dnamobile.models.News;

/**
 * Created by kuccu on 10/25/16.
 */

public class NewsAdapter extends RecyclerView.Adapter<NewsAdapter.NewsViewHolder> {

    private List<News> horizontalList;

    public class NewsViewHolder extends RecyclerView.ViewHolder {
        public TextView txtView;

        public NewsViewHolder(View view) {
            super(view);
//            txtView = (TextView) view.findViewById(R.id.txtView);

        }
    }



    public NewsAdapter(List<News> horizontalList) {
        this.horizontalList = horizontalList;
    }

    @Override
    public NewsViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View itemView = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.list_item_news, parent, false);

        return new NewsViewHolder(itemView);
    }

    @Override
    public void onBindViewHolder(final NewsViewHolder holder, final int position) {
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
        return horizontalList.size();
    }
}
