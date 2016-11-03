module Townsquare
  module API
    class V1 < Grape::API
      resource 'admin' do
        
        helpers do
          def get_default_resource
            default_resource = ClientResource.find_by(:is_default => true)
            if !default_resource
              default_resource = ClientResource.first
            end
            
            default_resource
          end
        end

        get 'resources' do
          if !admin_authenticate?
            return JSONResult.new(false, "INVALID_SESSION")
          end
          
          resources = ClientResource.all.order("name asc")
          JSONResult.new(true, resources)
        end

        params do
          requires :id, type:Integer, desc: "Id of the resource, assign to 0 when creating new"
          requires :name, type:String, desc: "Name of a resource suite"
          requires :is_default, type:Boolean, desc: "Set the resource as default"
        end        
        post 'resource/save' do
          admin_user = login_admin_user
          if !admin_user
            return JSONResult.new(false, "INVALID_SESSION")
          end
          
          resource = nil
          if params[:id] != 0
            resource = ClientResource.where("id = #{params[:id]}").first
            if !resource
              return JSONResult.new(false, "NOT_EXISTED")
            end
            
            if params[:name].downcase() != resource.name.downcase()
              if ClientResource.where("LOWER(name) = ?", params[:name].downcase()).first
                return JSONResult.new(false, "DUPLICATE")
              end
            end
            
            if params[:is_default]
              ClientResource.update_all(:is_default => false)
            end
               
            resource.name = params[:name]              
            resource.is_default = params[:is_default]
            resource.updated_by = admin_user.username
            resource.save            
          else
            resource = ClientResource.where("LOWER(name) = ?", params[:name].downcase()).first
            if resource
              return JSONResult.new(false, "DUPLICATE")
            else
              # Get default resource
              default_resource = get_default_resource()              
              if params[:is_default]
                ClientResource.update_all(:is_default => false)
              end
              
              resource = ClientResource.create(:name => params[:name], :is_default => params[:is_default], :created_by => admin_user.username)
              if default_resource
                default_details = ClientResourceDetail.where(:client_resource_id => default_resource.id)
                default_details.each do |default_detail|
                  ClientResourceDetail.create(:client_resource_id => resource.id,
                                              :unique_name => default_detail.unique_name,
                                              :display_text => default_detail.display_text,
                                              :created_by => admin_user.username)
                end
              end
            end 
          end
          
          JSONResult.new(true, resource)
        end
        
        params do
          requires :resource_id, type:Integer, desc: "Id of a resource"
          requires :unique_name, type:String, desc: "Unique name of the UI component"
          requires :display_text, type:String, desc: "Display of the UI component"
        end
        post 'resource/value/save' do
          admin_user = login_admin_user
          if !admin_user
            return JSONResult.new(false, "INVALID_SESSION")
          end
          
          resource = ClientResourceDetail.where("client_resource_id = ? AND LOWER(unique_name) = ?", params[:resource_id], params[:unique_name].downcase()).first
          if resource     
            resource.display_text = params[:display_text]
            resource.updated_by = admin_user.username
            resource.save
          end
          
          JSONResult.new(true, nil)
        end

        params do
          requires :unique_name, type:String, desc: "Unique name of an UI component"
          requires :values, type:String, desc: "Array of JSON for other resources"
        end
        post 'resource/key/add' do
          admin_user = login_admin_user
          if !admin_user
            return JSONResult.new(false, "INVALID_SESSION")
          end
          
          values = JSON.parse(params[:values])
          default_resource = get_default_resource()
          resources = ClientResource.all
          resources.each do |resource|
            ui = ClientResourceDetail.where("client_resource_id = ? AND LOWER(unique_name) = ?", resource.id, params[:unique_name].downcase()).first
            existed = false
            values.each do |value|
              if resource.id == value["resource_id"].to_i
                existed = true
                if ui
                  ui.display_text = value["display_text"]
                  ui.save
                else
                  ClientResourceDetail.create(:client_resource_id => resource.id, :unique_name => params[:unique_name], :display_text => value["display_text"], :created_by => admin_user.username)
                end
              end              
            end
            
            if !existed
              return JSONResult.new(false, "VALUE_MISSING")
            end
          end
          
          JSONResult.new(true, nil)
        end

        params do
          requires :unique_name, type:String, desc: "Unique name of the UI component"
        end
        post 'resource/key/del' do
          if !admin_authenticate?
            return JSONResult.new(false, "INVALID_SESSION")
          end
          
          ClientResourceDetail.where("LOWER(unique_name) = ?", params[:unique_name].downcase()).destroy_all
          JSONResult.new(true, nil)
        end
         
      end
    end
  end
end