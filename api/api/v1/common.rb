module Townsquare
  module API
    class V1 < Grape::API
      resource '' do
       
        get 'countries' do
          if !authenticate?
            return JSONResult.new(false, "INVALID_SESSION")
          end
          
          JSONResult.new(true, Country.all)
        end
       
        get 'alert_types' do
          if !authenticate?
            return JSONResult.new(false, "INVALID_SESSION")
          end

          JSONResult.new(true, AlertType.select("name").all().map {|item| item["name"]})
        end
        
        desc 'General upload file'
        params do
          requires :media, type: File, desc: "File to upload"
        end
        post 'upload' do
          if !authenticate?
            return JSONResult.new(false, "INVALID_SESSION")
          end
                    
          url = upload(params[:media])
          JSONResult.new(true, url)
        end
        
      end      
    end
  end
end