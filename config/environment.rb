# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

Tesi::Application.config.usrname =File.read("../USERNAME")

Tesi::Application.config.pwd = File.read("../PWD")
