module Townsquare
  module API
    class V1 < Grape::API
      resource 'admin' do

        get 'locations' do
          if !admin_authenticate?
            return JSONResult.new(false, "INVALID_SESSION")
          end
          
          locations = Location.all          
          JSONResult.new(true, locations)          
        end

        params do
          requires :id, type:Integer, desc: "Id of the location, assign to 0 when creating new"
          requires :name, type:String, desc: "Name of location"
          requires :longitude, type:Float, desc: "Longitude"
          requires :latitude, type:Float, desc: "latitude"
          requires :city, type:String, desc: "City of location"
          requires :state, type:String, desc: "State of location"
          requires :country_code, type:String, desc: "Country of location"
          optional :street_alerts_rss_feed_url, type:String, desc: "Street alert RSS feed"
          requires :has_upcomming_events, type:Boolean, desc: "Support upcomming events"
          requires :has_request_service, type:Boolean, desc: "Support request service"
          requires :has_location_info, type:Boolean, desc: "Support building "
          requires :has_street_alerts, type:Boolean, desc: "Support street alert "
          requires :client_resource_id, type:Integer, desc: "Id of client resource"
        end        
        post 'location/save' do
          admin_user = login_admin_user
          if !admin_user
            return JSONResult.new(false, "INVALID_SESSION")
          end
          
          location = Location.find_by(:id => params[:id])
          if !location
            location = Location.create(:name => params[:name],
                                       :longitude => params[:longitude],
                                       :latitude => params[:latitude],
                                       :city => params[:city],
                                       :state => params[:state],
                                       :country_code => params[:country_code],
                                       :street_alerts_rss_feed_url => params[:street_alerts_rss_feed_url],
                                       :has_upcomming_events => params[:has_upcomming_events],
                                       :has_request_service => params[:has_request_service],
                                       :has_location_info => params[:has_location_info],
                                       :has_street_alerts => params[:has_street_alerts],
                                       :client_resource_id => params[:client_resource_id],
                                       :created_by => admin_user.username)                               
          else
            location.name = params[:name]
            location.longitude = params[:longitude]
            location.latitude = params[:latitude]
            location.city = params[:city]
            location.state = params[:state]
            location.country_code = params[:country_code]
            location.street_alerts_rss_feed_url = params[:street_alerts_rss_feed_url]
            location.has_location_info = params[:has_location_info]
            location.has_request_service = params[:has_request_service]
            location.has_street_alerts = params[:has_street_alerts]
            location.has_upcomming_events = params[:has_upcomming_events]
            location.client_resource_id = params[:client_resource_id]
            location.updated_by = admin_user.username
            location.save
          end
          
          JSONResult.new(true, location)          
        end

        params do
          requires :id, type:Integer, desc: "ID of a location"
        end
        get 'location/:id/del' do
          if !admin_authenticate?
            return JSONResult.new(false, "INVALID_SESSION")
          end
          
          location = Location.find_by(:id => params[:id])
          if location
            location.destroy
          end
          
          JSONResult.new(true, nil)
        end
         
      end
    end
  end
end