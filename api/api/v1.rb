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
          cookie = cookies[:TOWNSQUARE_ADMIN]
          if cookie
            separator_index = cookie.index('-')
            if separator_index
              user_id = cookie[0, separator_index]
              user_uuid = cookie[separator_index + 1, cookie.length - separator_index - 1]
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
        
        def set_admin_auth(user)
          cookies[:TOWNSQUARE_ADMIN] = {
            value: "#{user.id}-#{user.uuid}",
            path: '/',
            expires: Time.now + (20 * 365 * 60 * 60 * 24)
          }
        end
        
        def remove_admin_auth()
          cookies[:TOWNSQUARE_ADMIN] = {
            value: '',
            path: '/',
            expires: Time.now - (20 * 365 * 60 * 60 * 24)
          }
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
        
        page_index = 0        
        locations = Location.order("id asc").offset(page_index * limit).limit(limit)
        closest_location = nil
        closest_distance = -1
        while locations.size > 0 do
          locations.each do |location|
            distance = Townsquare::Geo.distance([params[:latitude], params[:longitude]], [location.latitude, location.longitude])
            if !closest_location || closest_distance > distance
              closest_location = location
              closest_distance = distance
            end 
          end
          
          page_index = page_index + 1
          locations = Location.order("id asc").offset(page_index * limit).limit(limit)
        end
        
        if (params[:client_os] == 'ios' || params[:client_os] == 'android') && (params[:device_token] + '') != ''
          if !Device.where("LOWER(platform) = ? AND LOWER(token) = ?", params[:client_os].downcase(), params[:device_token].downcase()).first
            Device.create(:token => params[:device_token],
                          :platform => params[:client_os])
          end
        end
        
        closest_location.need_client_resource = true
        JSONResult.new(true, closest_location)
      end
      
    end
  end
end
