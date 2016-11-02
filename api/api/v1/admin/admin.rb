module Townsquare
  module API
    class V1 < Grape::API
      resource 'admin' do

        params do
          requires :username, type:String, desc: "Admin username"
          requires :password, type: String, desc: "password"
        end
        post 'login' do
          user = User.where("LOWER(username) = ?", params[:username].downcase()).first
          if !user
            return JSONResult.new(false, "INCORRECT")
          end
          
          password_hash = params[:username].downcase() + params[:password]
          password_hash = "#{Digest::SHA1.hexdigest(password_hash)}"
          if (user.password != password_hash)
            return JSONResult.new(false, "INCORRECT")
          end
          
          #set_admin_auth(user)
          user.access_token = "#{user.id}-#{user.uuid}"
          JSONResult.new(true, user)
        end

        get 'logout' do
          remove_admin_auth()
          JSONResult.new(true, nil)
        end

        params do
          requires :types, type: Array[String]
        end
        post 'alert_types/save' do
          if !admin_authenticate?
            return JSONResult.new(false, "INVALID_SESSION")
          end
          
          params[:types].each do |type|
            alert_type = AlertType.where("LOWER(name) = ?", type.downcase()).first
            if !alert_type
              AlertType.create(:name => type)
            end
          end
          
          JSONResult.new(true, nil)
        end
         
      end
    end
  end
end