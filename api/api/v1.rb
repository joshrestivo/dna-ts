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
        header['Access-Control-Allow-Headers'] = "*"
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

        def login_user
          secret_key = headers['Secret-Key']
          if secret_key != '' && secret_key != nil
            if secret_key != 'ee9c6aaa512cd328c641d21f13bb2654353d36dc'
              customer = Customer.find_by(:secret_key => secret_key)
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
      end
      
    end
  end
end
