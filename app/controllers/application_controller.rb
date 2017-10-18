class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private 
    def admin_user
      if !current_user.isadmin?
        flash[:notice] = 'You do not have the rights to access this information. Please, login as admin '
        redirect_to(login_path) 
      end
    end
end
