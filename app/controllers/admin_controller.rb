class AdminController < ApplicationController
  http_basic_authenticate_with name:  "admin", password: "12345"
  def index
  end
end
