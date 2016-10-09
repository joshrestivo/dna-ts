# Define our constants
TOWNSQUARE_ENV = ENV['TOWNSQUARE_ENV'] ||= ENV['RACK_ENV'] ||= ENV['RAILS_ENV'] ||= 'development' unless defined?(TOWNSQUARE_ENV)
TOWNSQUARE_ROOT = File.expand_path('../..', __FILE__) unless defined?(TOWNSQUARE_ROOT)

AWS_CDN_ACCESS_KEY_ID = 'AKIAI7CCBOFMFV6J75FQ'
AWS_CDN_SECRET_ACCESS_KEY = '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'

TWITTER_CONSUMER_KEY = 'FE5lvbrybLMQZZxPAvSQ'
TWITTER_CONSUMER_SECRET = 'wCu7dJLmc2LXOuVYpImp0HjcPZqIP6OxJBxmfQlirNc'

# Load dependencies
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
require 'active_record'
require 'aws-sdk-v1'
require 'dragonfly'

Bundler.require(:default, TOWNSQUARE_ENV)

Dir["lib/**/*.rb"].sort.each { |library_file| load library_file }

include Townsquare::PushNotification
include Townsquare::CustomErrorFormatter
include Townsquare::SESHelper

database_settings = YAML::load(File.open('config/database.yml'))[TOWNSQUARE_ENV]

DB_CONNECTION = ActiveRecord::Base.establish_connection(
  adapter:  database_settings['adapter'],
  host:     database_settings['host'],
  database: database_settings['database'],
  username: database_settings['username'],
  password: database_settings['password'],
  pool:     database_settings['pool'],
  timeout:  database_settings['timeout']
)

I18n.enforce_available_locales = false
LOG = Logger.new("log/Townsquare.log", 10, 1024000)
if TOWNSQUARE_ENV == 'development'
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end

AWS.config(:region => 'us-east-1',
           :ses => { :region => 'us-east-1'} )
           
Dragonfly.app.configure do
  plugin :imagemagick  
  datastore :file, :root_path => 'public/dragonfly', :server_root => 'public' # directory under which to store files
                   # - defaults to 'dragonfly' relative to current dir   
end

LinkThumbnailer.configure do |config|
  config.image_limit = 5
  config.attributes = [:title, :images]
end

Dir["api/**/*.rb"].sort.each { |api_module| load api_module }
Dir["models/validators/**/*.rb"].sort.each { |validator| load validator }
Dir["models/**/*.rb"].sort.each { |model| load model }
