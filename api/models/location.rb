class Location < ActiveRecord::Base
  
  belongs_to :client_resource
  has_many :buildings
  has_many :news_feeds
  has_many :bulletins
  
  attr_accessor :need_client_resource

  def as_json(*)
            
    ret = {
      :id             => id,
      :longitude      => longitude,
      :latitude       => latitude,
      :name           => name,
      :city           => city,
      :state          => state,
      :country_code   => country_code,
      :country => Country.where("LOWER(country_code) = ?", country_code.downcase()).first.name,
      :street_alerts_rss_feed_url => street_alerts_rss_feed_url,
      :has_upcomming_events => has_upcomming_events,
      :has_request_service  => has_request_service,
      :has_location_info    => has_location_info,
      :has_street_alerts    => has_street_alerts,
      :created_by     => created_by,
      :updated_by     => updated_by,
      :created_at     => created_at,
      :updated_at     => updated_at,
      :client_resource_id => client_resource_id,
      :client_resource_name => client_resource.name
    }
    
    if need_client_resource
      ret["client_resource"] = client_resource
    end
    ret
  end

end
