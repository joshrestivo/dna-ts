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
                    
        end         
      end
    end
  end
end