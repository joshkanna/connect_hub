class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username_or_email]) || User.find_by(email: params[:username_or_email])
    
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Logged in successfully."
      redirect_to root_path
    else
      flash.now[:error] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end


  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out"
  end
end

