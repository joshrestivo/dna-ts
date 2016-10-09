module Townsquare

  module API

    class V1 < Grape::API
      version '1.0', using: :path
      default_format :json
      format :json

      get :ping do
        "pong" 
      end
       
    end

  end

end
