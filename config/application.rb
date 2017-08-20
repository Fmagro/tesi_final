require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Tesi
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    # fetching username and password from external file
    # config.usrname = File.read("../USERNAME")
    # config.pwd = File.read("../PWD")   

    # fetching apikey for google maps 
    config.api_key = File.read("API_KEY")  
  end
end
