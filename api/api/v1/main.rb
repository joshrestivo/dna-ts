module Townsquare
  module API
    class V1 < Grape::API
      route_param :location_id do
        get 'bulletins' do
          if !user_authenticate?
            return JSONResult.new(false, "INVALID_SESSION")          
          end
          
          bulletins = Bulletin.where(:location_id => params[:location_id]).offset(offset).limit(limit)
          JSONResult.new(true, bulletins)
        end   
      end      
    end
  end
end