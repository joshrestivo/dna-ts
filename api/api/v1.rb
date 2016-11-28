require 'simple-rss'
require 'open-uri'
require 'uri'
require 'dragonfly'
require 'rest-client'

module Townsquare
  module API
    class V1 < Grape::API
      
      version '1.0', using: :path
      default_format :json
      format :json
      rescue_from :all
      error_formatter :json, Townsquare::CustomErrorFormatter
      prefix :api
      
      before do
        header['Access-Control-Allow-Origin'] = '*'         
        header['Access-Control-Allow-Headers'] = '*'
        header['Access-Control-Allow-Credentials'] = 'true'
      end
      
      helpers do
        def login_admin_user
          access_token = headers['Access-Token']
          if access_token != '' && access_token != nil
            separator_index = access_token.index('-')
            if separator_index
              user_id = access_token[0, separator_index]
              user_uuid = access_token[separator_index + 1, access_token.length - separator_index - 1]
              return User.find_by(:id => user_id, :uuid => user_uuid)
            end
          end
          nil
        end

        def login_user
          secret_key = headers['Secret-Key']
          if secret_key != '' && secret_key != nil
            if secret_key != 'ee9c6aaa512cd328c641d21f13bb2654353d36dc'
              customer = Customer.where("LOWER(secret_key) = ?", secret_key).first
              if customer
                return customer.name
              else
                return nil
              end
            end
            
            return "SYSTEM"             
          end
          
          nil
        end
        
        def admin_authenticate?
          login_admin_user != nil 
        end

        def user_authenticate?
          login_user != nil
        end
        
        def authenticate?
          admin_authenticate? || user_authenticate?
        end
        
        def upload(uploaded_file)
          image_extensions = ["png", "bmp", "jpg", "jpeg"]
          url = nil
          filename = File.basename(uploaded_file.filename)
          if (image_extensions.any? { |ext| filename.downcase().end_with?(ext) })
            dir = 'dragon_fly'
            images = Townsquare::Image.process(dir, uploaded_file.tempfile.path)
            url = Townsquare::CDN.store("#{TOWNSQUARE_ROOT}/#{dir}/#{images[0]}", images[0], :public_read)
            Townsquare::CDN.store("#{TOWNSQUARE_ROOT}/#{dir}/#{images[1]}", images[1], :public_read)
            File.delete("#{TOWNSQUARE_ROOT}/#{dir}/#{images[0]}")
            File.delete("#{TOWNSQUARE_ROOT}/#{dir}/#{images[1]}")
          else
            file_name = "#{Time.now.to_i}_#{SecureRandom.uuid}" + File.extname(uploaded_file.filename)
            url = Townsquare::CDN.store(uploaded_file.tempfile, file_name, :public_read)            
          end
          
          url
        end

        def limit(limit = nil)
          if params[:limit]
            @limit = params[:limit].to_i
          else
            @limit = limit ? limit : 10
          end

          @limit
        end

        def page(page = nil)
          if params[:page]
            @page = params[:page].to_i
          else
            @page = page ? page : 1
          end

          @page
        end

        def offset
          (page - 1) * limit
        end
      end
      
      get :ping do
        "pong" 
      end
      
      params do
        requires :longitude, type:Float, desc: "Longitude"
        requires :latitude, type:Float, desc: "latitude"
        requires :client_os, type:String, desc: "Client OS: ios, android"
        optional :device_token, type:String, desc: "device token"
      end
      post :auth do
        if !user_authenticate?
          return JSONResult.new(false, "INVALID_SESSION")          
        end
        
        closest_location = Location.near([params[:latitude], params[:longitude]], 30000, :unit => :miles).first
        if (params[:client_os] == 'ios' || params[:client_os] == 'android') && (params[:device_token] + '') != ''
          if !Device.where("LOWER(platform) = ? AND LOWER(token) = ?", params[:client_os].downcase(), params[:device_token].downcase()).first
            Device.create(:token => params[:device_token],
                          :platform => params[:client_os])
          end
        end
        
        if closest_location
          closest_location.need_client_resource = true
        end 
        
        JSONResult.new(true, closest_location)
      end
      
      get :locations do
        if !user_authenticate?
          return JSONResult.new(false, "INVALID_SESSION")          
        end
        
        locations = Location.order('name asc').offset(offset).limit(limit)
        JSONResult.new(true, locations)
      end
      
      get 'location/:id' do
        if !user_authenticate?
          return JSONResult.new(false, "INVALID_SESSION")          
        end
        
        location = Location.find_by(:id => params[:id])
        if location
          location.need_client_resource = true
        end
        JSONResult.new(true, location)
      end
      
      get 'import-buildings' do
        stLouisLocation = Location.where("LOWER(name) = 'st. louis'").first
        if !stLouisLocation
          return JSONResult.new(true, [])
        end
        
        buildings = []
        response = RestClient.get('https://dnac.6ceed.com/wp-json/dna/v1/buildings/list', :content_type => :json, :accept => :json)
        result = JSON.parse(response)
        result.each do |item|
          dir = 'dragon_fly'
          images = Townsquare::Image.process_from_url(dir, item['image']['url'])
          image_url = Townsquare::CDN.store("#{TOWNSQUARE_ROOT}/#{dir}/#{images[0]}", images[0], :public_read)
          thumbnail_url = Townsquare::CDN.store("#{TOWNSQUARE_ROOT}/#{dir}/#{images[1]}", images[1], :public_read)
          File.delete("#{TOWNSQUARE_ROOT}/#{dir}/#{images[0]}")
          File.delete("#{TOWNSQUARE_ROOT}/#{dir}/#{images[1]}")
          image_size = FastImage.size(image_url)
          image_width = image_size[0]
          image_height = image_size[1]
          image_size = FastImage.size(thumbnail_url)
          thumbnail_width = image_size[0]
          thumbnail_height = image_size[1]
          building = Building.create(:location_id => stLouisLocation.id,
                                     :name => item['title'],
                                     :address => item['address'],
                                     :zipcode => item['zip'],
                                     :image_url => image_url,
                                     :image_width => image_width,
                                     :image_height => image_height,
                                     :thumbnail_url => thumbnail_url,
                                     :thumbnail_width => thumbnail_width,
                                     :thumbnail_height => thumbnail_height,
                                     :created_by => 'admin')
          buildings.push building
        end
        
        JSONResult.new(true, buildings)
      end
      
    end
  end
end
