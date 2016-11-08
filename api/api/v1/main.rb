require 'simple-rss'
require 'open-uri'
require 'will_paginate/array'
require 'nokogiri'
require 'rest-client'

module Townsquare
  module API
    class V1 < Grape::API
      route_param 'main/:location_id' do
        
        helpers do
          def populate_news_feeds(feeds, url)
            if url
              rss = SimpleRSS.parse open(url)
              rss.items.each do |item|
                if item.title && item.pubDate && item.link
                  feeds.push({:date => item.pubDate, 
                              :link => item.link, 
                              :title => item.title.force_encoding("UTF-8"), 
                              :description => item.description.force_encoding("UTF-8"),
                              :thumbnail_url => '',
                              :thumbnail_width => 0,
                              :thumbnail_height => 0})
                end
              end            
            end
          end
        end

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
          end
          
          JSONResult.new(true, feeds)
        end   

        get 'news' do
          if !user_authenticate?
            return JSONResult.new(false, "INVALID_SESSION")          
          end
          
          location = Location.find_by(:id => params[:location_id])
          feeds = []
          if location && location.has_upcomming_events       
            populate_news_feeds(feeds, location.news_rss_url_1)     
            populate_news_feeds(feeds, location.news_rss_url_2)     
            populate_news_feeds(feeds, location.news_rss_url_3)     
          end
          
          feeds = feeds.sort_by {|feed| feed[:date]}.reverse.paginate(:page => page, :per_page => limit)
          if !feeds
            feeds = []
          end          
          feeds.each do |feed|
            doc = Nokogiri::HTML(feed[:description])
            img_srcs = doc.css('img').map{ |i| i['src'] }
            if img_srcs.size > 0
              feed[:thumbnail_url] = img_srcs[0]
              image_size = FastImage.size(img_srcs[0])
              feed[:thumbnail_width] = image_size[0]
              feed[:thumbnail_height] = image_size[1]
            end
            
            feed[:description] = Nokogiri::HTML(feed[:description]).text
            feed[:description] = feed[:description].gsub(/\r/, '')
            feed[:description] = feed[:description].gsub(/\n/, '')
            feed[:description] = feed[:description].gsub(/\t/, '')
          end
          
          JSONResult.new(true, feeds)
        end   

        get 'calendar' do
          if !user_authenticate?
            return JSONResult.new(false, "INVALID_SESSION")          
          end
          
          location = Location.find_by(:id => params[:location_id])
          calendars = []
          if location && location.google_calendar_id && location.google_calendar_api_key
            google_url = "https://www.googleapis.com/calendar/v3/calendars/#{location.google_calendar_id}/events?key=#{location.google_calendar_api_key}"
            response = RestClient.get(google_url, :content_type => :json, :accept => :json)
            if response
              result = JSON.parse(response)
              result["items"].each do |item|
                calendars.push({:start => item["start"]["dateTime"],
                                :end => item["end"]["dateTime"],
                                :location => item["location"],
                                :description => item["description"]})
              end
            end
          end
          
          if !calendars
            calendars = []
          end

          calendars = calendars.sort_by {|calendar| calendar[:start]}
          now = Time.now
          result = []          
          calendars.each do |calendar|
            if calendar[:start] > now
              result.push(calendar) 
            end
            
            if result.size == 3
              break
            end
          end
          
          JSONResult.new(true, result)
        end
        
      end      
    end
  end
end