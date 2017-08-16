class AdminController < ApplicationController
  http_basic_authenticate_with name:  Tesi::Application.config.usrname, password: Tesi::Application.config.pwd
  def index
  end
end
