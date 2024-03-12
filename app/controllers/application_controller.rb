class ApplicationController < ActionController::Base
  before_action :current_user
  before_action :set_query


  def set_query
    @query = User.ransack(params[:q])
  end
  
  def current_user
    if session[:user_id]
      Current.user = User.find_by(id: session[:user_id])
    end
  end

  def require_user_logged_in!
    if Current.user.nil?
      flash[:error] = "You must be signed in to do that."
      redirect_to sign_in_path
    end
  end

  def require_user_logged_out!
    if Current.user
      flash[:error] = "You are already signed in."
      redirect_to main_path
    end
  end

  def home
    if current_user
      redirect_to main_path
    else
      redirect_to sign_in_path
    end
  end

  def disable_nav
    @disable_nav = true
  end
end
