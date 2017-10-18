class UsersController < ApplicationController
  before_action :logged_in_user, only: [:addfavourite, :delfavourite]
  before_action :correct_user,   only: [:addfavourite, :delfavourite]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def addfavourite
    @user=User.find(params[:id])
    @conc=Concert.find(params[:fav_conc])
    @user.concerts << @conc
    redirect_to @user
 
  end

  def delfavourite
    @user=User.find(params[:id])
    @conc=Concert.find(params[:del_conc])
    @user.concerts.delete(@conc)
    redirect_to @user
 
  end

  private

    def user_params
      params.require(:user).permit(:email, :password,
                                   :password_confirmation)
    end

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end
end
