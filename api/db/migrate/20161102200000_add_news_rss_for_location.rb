class AddNewsRssForLocation < ActiveRecord::Migration

  def up
    
    add_column :locations, :news_rss_url_1, :string
    add_column :locations, :news_rss_url_2, :string
    add_column :locations, :news_rss_url_3, :string

  end

  def down
    
  end

end
