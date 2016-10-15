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
        header "Access-Control-Allow-Origin", "*"
      end
      
      get :ping do
        "pong" 
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

        def admin_authenticate!
          puts login_admin_user
          current_user || error!('Unauthorized. Invalid or expired cookie.', 401) 
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
      end
      
    end

  end

end
