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

        get 'logout' do
          remove_admin_auth()
          JSONResult.new(true, nil)
        end

        params do
          requires :country_code, type:String, desc: "Country code"
        end
        get 'resources/:country_code' do
          resources = ClientResource.where(:country_code => params[:country_code])
          JSONResult.new(true, resources)
        end
        
        params do
          requires :country_code, type:String, desc: "Country code"
          requires :unique_name, type:String, desc: "Unique name of the UI component"
          requires :display_text, type:String, desc: "Display of the UI component"
        end
        post 'resource/save' do     
          resource = ClientResource.where(:country_code => params[:country_code], :unique_name => params[:unique_name]).first_or_create     
          resource.display_text = params[:display_text]
          resource.save
          JSONResult.new(true, resource)
        end

        params do
          requires :country_code, type:String, desc: "Country code"
          requires :unique_name, type:String, desc: "Unique name of the UI component"
        end
        post 'resource/del' do
          resource = ClientResource.find_by(:country_code => params[:country_code], :unique_name => params[:unique_name])
          if resource
            resource.destroy
          end
          JSONResult.new(true, nil)
        end
       
        get 'alert_types' do
          JSONResult.new(true, AlertType.select("name").all().map {|item| item["name"]})
        end

        params do
          requires :types, type: Array[String]
        end
        post 'alert_types/save' do
          params[:types].each do |type|
            AlertType.where(:name => type).first_or_create
          end
          JSONResult.new(true, nil)
        end
       
        get 'countries' do
          JSONResult.new(true, Country.all)
        end
         
      end
    end
  end
end