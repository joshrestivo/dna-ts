require File.expand_path("../config/boot.rb", __FILE__)

run Townsquare::API::Init.new

use ActiveRecord::ConnectionAdapters::ConnectionManagement
use Rack::MethodOverride

use Rack::Cors do
  allow do
    origins '*'
    resource '*', :headers => :any, :methods => :any
  end
end