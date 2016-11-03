module Townsquare
  module API
    class V1 < Grape::API
      resource 'admin/location' do
        route_param :location_id do
          
          get 'buildings' do
            if !admin_authenticate?
              return JSONResult.new(false, "INVALID_SESSION")
            end
            
            JSONResult.new(true, Building.where(:location_id => params[:location_id]))
          end      

          params do
            requires :id, type:Integer, desc: "Id of the building, assign to 0 when creating new"
            requires :name, type:String, desc: "Name of the building"
            requires :address, type:String, desc: "address"
            requires :zipcode, type:String, desc: "zipcode"
            optional :image, type:File, desc: "Image for the building"
          end        
          post 'building/save' do
            admin_user = login_admin_user
            if !admin_user
              return JSONResult.new(false, "INVALID_SESSION")
            end
                        
            image_url = nil
            thumbnail_url = nil
            image_width = 0
            image_height = 0
            thumbnail_width = 0
            thumbnail_height = 0
            if params[:image]
              image_extensions = ["png", "bmp", "jpg", "jpeg"]
              filename = File.basename(params[:image].filename)
              if !image_extensions.any? { |ext| filename.downcase().end_with?(ext) }
                return JSONResult.new(false, "IMAGE_INVALID")
              end

              image_url = upload(params[:image])
              image_size = FastImage.size(image_url)
              image_width = image_size[0]
              image_height = image_size[1]
              image_file_name = Townsquare::Utils.get_file_name(image_url)
              thumbnail_url = Townsquare::CDN.build_url("#{THUMBNAIL_SIZE}_#{image_file_name}")
              image_size = FastImage.size(thumbnail_url)
              thumbnail_width = image_size[0]
              thumbnail_height = image_size[1]
            end
            
            building = Building.find_by(:id => params[:id])
            if building
              building.name = params[:name]
              building.address = params[:address]
              building.updated_by = admin_user.username
              if image_url
                building.image_url = image_url
                building.image_width = image_width
                building.image_height = image_height
                building.thumbnail_url = thumbnail_url
                building.thumbnail_width = thumbnail_width
                building.thumbnail_height = thumbnail_height
              end
              
              building.save
            else
              building = Building.create(:location_id => params[:location_id],
                                         :name => params[:name],
                                         :address => params[:address],
                                         :zipcode => params[:zipcode],
                                         :image_url => image_url,
                                         :image_width => image_width,
                                         :image_height => image_height,
                                         :thumbnail_url => thumbnail_url,
                                         :thumbnail_width => thumbnail_width,
                                         :thumbnail_height => thumbnail_height,
                                         :created_by => admin_user.username)
            end
            
            JSONResult.new(true, building)
          end

          params do
            requires :id, type:Integer, desc: "ID of a building"
          end
          get 'building/:id/del' do
            if !admin_authenticate?
              return JSONResult.new(false, "INVALID_SESSION")
            end
            
            building = Building.find_by(:id => params[:id])
            if building
              building.destroy
            end

            JSONResult.new(true, nil)
          end
                    
        end         
      end
    end
  end
end