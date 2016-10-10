class Location < ActiveRecord::Base

  def as_json(*)        
    {
      :longitude      => longitude,
      :latitude       => latitude,
      :name           => name,
      :city           => city,
      :state          => state,
      :country_code   => country_code,
      :has_upcomming_events => has_upcomming_events,
      :has_request_service  => has_request_service,
      :has_location_info    => has_location_info,
      :has_street_alerts    => has_street_alerts,
      :created_by     => created_by,
      :updated_by     => updated_by,
      :created_at     => created_at,
      :updated_at     => updated_at
    }
  end

end
