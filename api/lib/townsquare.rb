module Townsquare

  module API

    class Init < Rack::Cascade
      def initialize
        super [ Townsquare::API::V1 ]
      end
    end

  end

end
