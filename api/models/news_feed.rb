class NewsFeed < ActiveRecord::Base

  def as_json(*)        
    {
      :location_id    => location_id,
      :rss_url        => rss_url,
      :identity       => identity,
      :created_by     => created_by,
      :updated_by     => updated_by,
      :created_at     => created_at,
      :updated_at     => updated_at
    }
  end

end
