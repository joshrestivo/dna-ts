require File.expand_path("../config/boot.rb", __FILE__)

run Townsquare::API::Init.new

use ActiveRecord::ConnectionAdapters::ConnectionManagement
use Rack::MethodOverride