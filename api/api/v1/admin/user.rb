module Townsquare
  module API
    class V1 < Grape::API
      resource 'admin' do
        
        get 'users' do
          if !admin_authenticate?
            return JSONResult.new(false, "INVALID_SESSION")
          end
          
          JSONResult.new(true, User.all)          
        end
        
        params do
          requires :name, type:String, desc: "Name of user"
          requires :username, type:String, desc: "UserName of user"
          requires :password, type:String, desc: "Password"
          requires :email, type:String, desc: "Email"
        end
        post 'user/create' do
          admin_user = login_admin_user
          if !admin_user
            return JSONResult.new(false, "INVALID_SESSION")
          end
          
          user = User.where("LOWER(username) = ?", params[:username].downcase()).first
          if user
            return JSONResult.new(false, "USERNAME_EXISTED")
          end

          user = User.where("LOWER(email) = ?", params[:email].downcase()).first
          if user
            return JSONResult.new(false, "EMAIL_EXISTED")
          end
          
          password_hash = params[:username].downcase() + params[:password]
          password_hash = "#{Digest::SHA1.hexdigest(password_hash)}"
          user = User.create(:name => params[:name],
                             :username => params[:username],
                             :password => password_hash,
                             :email => params[:email],
                             :created_by => admin_user.username)
          JSONResult.new(true, user)
        end
        
        params do
          requires :id, type:Integer, desc: "Id of the user"
          requires :name, type:String, desc: "Name of user"
          requires :email, type:String, desc: "Email"
        end
        post 'user/update' do
          admin_user = login_admin_user
          if !admin_user
            return JSONResult.new(false, "INVALID_SESSION")
          end
          
          user = User.find_by(:id => params[:id])
          if user
            if User.where("LOWER(email) = ? AND email != ?", params[:email].downcase(), user.email).first
              return JSONResult.new(false, "EMAIL_EXISTED")
            end 
            
            user.email = params[:email]
            user.name = params[:name]
            user.updated_by = admin_user.username
            user.save           
            return JSONResult.new(true, user)
          end
            
          JSONResult.new(false, "NOT_EXISTED")
        end
        
        params do
          requires :id, type:Integer, desc: "Id of the user"
        end
        get 'user/:id/del' do
          admin_user = login_admin_user
          if !admin_user
            return JSONResult.new(false, "INVALID_SESSION")
          end
          
          user = User.find_by(:id => params[:id])
          if !user
            return JSONResult.new(false, "NOT_EXISTED")
          end
          
          if user.username.downcase() == admin_user.username.downcase()
            return JSONResult.new(false, "DELETE_YOURSELF")
          end 
          
          if user.username.downcase() == 'admin'
            return JSONResult.new(false, "DELETE_SUPER_ADMIN")
          end
            
          user.destroy
          return JSONResult.new(true, nil)
        end
        
        params do
          requires :id, type:Integer, desc: "Id of the user"
          requires :password, type:String, desc: "New password"
        end
        post 'user/pwd/reset' do
          admin_user = login_admin_user
          if !admin_user
            return JSONResult.new(false, "INVALID_SESSION")
          end
          
          user = User.find_by(:id => params[:id])
          if user
            if user.username == 'admin' && admin_user.username != 'admin'
              return JSONResult.new(false, "RESET_SUPER_ADMIN")
            end
            
            password_hash = user.name.downcase() + params[:password]
            password_hash = "#{Digest::SHA1.hexdigest(password_hash)}"
            user.password = password_hash            
            return JSONResult.new(true, user)
          end
            
          JSONResult.new(false, "NOT_EXISTED")
        end
         
      end
    end
  end
end