module Townsquare
  module API
    class V1 < Grape::API
      resource 'admin' do
        
        route_param 'location/:id' do
          get 'bulletins' do
            if !admin_authenticate?
              return JSONResult.new(false, "INVALID_SESSION")
            end
            
            JSONResult.new(true, Bulletin.where(:location_id => params[:id]))
          end      
           
          params do
            requires :id, type:Integer, desc: "Id of the bulletin, assign to 0 when creating new"
            requires :location_id, type:Integer, desc: "ID of location"
            requires :title, type:String, desc: "Title of bulletin"
            requires :description, type:String, desc: "Description of bulletin"
            requires :valid_from, type:DateTime, desc: "Valid from"
            requires :valid_to, type:DateTime, desc: "Valid to"
            optional :image, type:File, desc: "Image for the bulletin"
          end
          post 'bulletin/save' do
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
              image_url = upload(params[:image])
            end
            
            bulletin = Bulletin.find_by(:id => params[:id])
            if bulletin
              bulletin.title = params[:title]
              bulletin.description = params[:description]
              bulletin.valid_from = params[:valid_from]
              bulletin.valid_to = params[:valid_to]
              bulletin.updated_by = admin_user.username
              if image_url
                bulletin.image_url = image_url
                bulletin.image_width = image_width
                bulletin.image_height = image_height
                bulletin.thumbnail_url = thumbnail_url
                bulletin.thumbnail_width = thumbnail_width
                bulletin.thumbnail_height = thumbnail_height
              end
              
              bulletin.save      
            else
              bulletin = Bulletin.create(:title => params[:title],
                                         :description => params[:description],
                                         :location_id => params[:location_id],
                                         :valid_from => params[:valid_from],
                                         :valid_to => params[:valid_to],
                                         :image_url => image_url,
                                         :image_width => image_width,
                                         :image_height => image_height,
                                         :thumbnail_url => thumbnail_url,
                                         :thumbnail_width => thumbnail_width,
                                         :thumbnail_height => thumbnail_height,
                                         :created_by => admin_user.username)
            end
            
            JSONResult.new(true, bulletin)
          end             

          params do
            requires :bulletin_id, type:Integer, desc: "ID of a location"
          end
          get 'bulletin/:bulletin_id/del' do
            if !admin_authenticate?
              return JSONResult.new(false, "INVALID_SESSION")
            end
            
            bulletin = Bulletin.find_by(:id => params[:bulletin_id])
            if bulletin
              bulletin.destroy
            end
            
            JSONResult.new(true, nil)
          end
        end
         
      end
    end
  end
end