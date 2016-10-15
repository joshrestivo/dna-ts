module Townsquare
  module API
    class V1 < Grape::API
      resource '' do
       
        get 'countries' do
          JSONResult.new(true, Country.all)
        end

        params do
          requires :country_code, type:String, desc: "Country code"
        end
        get 'resources/:country_code' do
          resources = ClientResource.where(:country_code => params[:country_code])
          JSONResult.new(true, resources)
        end
       
        get 'alert_types' do
          JSONResult.new(true, AlertType.select("name").all().map {|item| item["name"]})
        end

      end
    end
  end
end