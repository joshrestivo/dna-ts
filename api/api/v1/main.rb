require 'simple-rss'
require 'open-uri'

module Townsquare
  module API
    class V1 < Grape::API
      route_param 'main/:location_id' do

        get 'bulletins' do
          if !user_authenticate?
            return JSONResult.new(false, "INVALID_SESSION")          
          end
          
          bulletins = Bulletin.where(:location_id => params[:location_id]).offset(offset).limit(limit)
          JSONResult.new(true, bulletins)
        end   

        get 'buildings' do
          if !user_authenticate?
            return JSONResult.new(false, "INVALID_SESSION")          
          end
          
          buildings = Building.where(:location_id => params[:location_id]).offset(offset).limit(limit)
          JSONResult.new(true, buildings)
        end   

        get 'street-alerts' do
          if !user_authenticate?
            return JSONResult.new(false, "INVALID_SESSION")          
          end
          
          location = Location.find_by(:id => params[:location_id])
          feeds = []
          if location && location.has_street_alerts && location.street_alerts_rss_feed_url
            rss = SimpleRSS.parse open(location.street_alerts_rss_feed_url)
            rss.items.each do |item|
              if item.pubDate && item.link
                feeds.push({:date => item.pubDate, :link => item.link})
              end
            end
            return JSONResult.new(true, feeds)
          end
          
          JSONResult.new(true, feeds)
        end   

      end      
    end
  end
end