class RegistrationsController < ApplicationController
  before_action :require_user_logged_out!
  before_action :disable_nav

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Succesfully created account."
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end