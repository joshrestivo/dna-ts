module Townsquare
  module API
    class V1 < Grape::API
      resource 'admin' do

        desc "Login"
        params do
          requires :username, type:String, desc: "Admin username"
          requires :password, type: String, desc: "password"
        end
        post 'login' do
          user = User.find_by(:username => params[:username])
          if !user
            return JSONResult.new(false, "INCORRECT")
          end
          
          password_hash = "#{Digest::SHA1.hexdigest(params[:password])}"
          if (user.password != password_hash)
            return JSONResult.new(false, "INCORRECT")
          end
          
          set_admin_auth(user)
          JSONResult.new(true, user)
        end
        
      end
    end
  end
end