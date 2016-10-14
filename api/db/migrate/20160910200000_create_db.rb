class CreateDb < ActiveRecord::Migration

  def up
    create_table :customers do |t|
      t.string  :name
      t.string  :phone
      t.string  :address
      t.string  :secret_key
      t.string  :created_by
      t.string  :updated_by

      t.timestamps null:false
    end

    create_table :users do |t|
      t.string  :uuid
      t.string  :name
      t.string  :username
      t.string  :password
      t.string  :email
      t.string  :created_by
      t.string  :updated_by

      t.timestamps null:false
    end

    create_table :locations do |t|
      t.float   :longitude
      t.float   :latitude
      t.string  :name
      t.string  :city
      t.string  :state
      t.string  :country_code
      t.string  :street_alerts_rss_feed_url
      t.boolean :has_upcomming_events
      t.boolean :has_request_service
      t.boolean :has_location_info
      t.boolean :has_street_alerts      
      t.string  :created_by
      t.string  :updated_by

      t.timestamps null:false
    end

    create_table :news_feeds do |t|
      t.integer :location_id
      t.string  :rss_url
      t.string  :identity
      t.string  :created_by
      t.string  :updated_by

      t.timestamps null:false
    end
   
    create_table :buildings do |t|
      t.integer :location_id
      t.string  :title
      t.string  :address
      t.string  :zipcode
      t.string  :image_url
      t.integer :image_width
      t.integer :image_height
      t.string  :thumbnail_url
      t.integer :thumbnail_width
      t.integer :thumbnail_height
      t.string  :created_by
      t.string  :updated_by

      t.timestamps null:false
    end
   
    create_table :bulletins do |t|
      t.integer   :location_id
      t.string    :title
      t.string    :description
      t.datetime  :valid_from
      t.datetime  :valid_to
      t.string    :image_url
      t.integer   :image_width
      t.integer   :image_height
      t.string    :thumbnail_url
      t.integer   :thumbnail_width
      t.integer   :thumbnail_height
      t.string    :created_by
      t.string    :updated_by

      t.timestamps null:false
    end

    create_table :countries do |t|
      t.string  :name
      t.string  :country_code

      t.timestamps null:false
    end

    create_table :client_resources do |t|
      t.string  :country_code
      t.string  :unique_name
      t.string  :display_text

      t.timestamps null:false
    end

    create_table :alert_types do |t|
      t.string  :name
      t.string  :created_by
      t.string  :updated_by

      t.timestamps null:false
    end
              
    create_table :devices do |t|
      t.string  :token
      t.string  :platform

      t.timestamps null:false
    end
        
    execute "ALTER TABLE customers ALTER COLUMN id SET DATA TYPE bigint"
    execute "ALTER TABLE users ALTER COLUMN id SET DATA TYPE bigint"
    execute "ALTER TABLE locations ALTER COLUMN id SET DATA TYPE bigint"    
    execute "ALTER TABLE buildings ALTER COLUMN id SET DATA TYPE bigint"    
    execute "ALTER TABLE buildings ALTER COLUMN location_id SET DATA TYPE bigint"    
    execute "ALTER TABLE bulletins ALTER COLUMN id SET DATA TYPE bigint"    
    execute "ALTER TABLE bulletins ALTER COLUMN location_id SET DATA TYPE bigint"    
    execute "ALTER TABLE alert_types ALTER COLUMN id SET DATA TYPE bigint"    
    execute "ALTER TABLE devices ALTER COLUMN id SET DATA TYPE bigint"    
    execute "ALTER TABLE news_feeds ALTER COLUMN id SET DATA TYPE bigint"    
    execute "ALTER TABLE news_feeds ALTER COLUMN location_id SET DATA TYPE bigint"    

    require File.expand_path('../../seeds.rb', __FILE__)
  end

  def down
    
  end

end
