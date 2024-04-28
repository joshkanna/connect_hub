class ApplicationController < ActionController::Base
  before_action :current_user
  before_action :set_query

  helper_method :current_user
  before_action :cookie_set

  def set_query
    @query = User.ransack(params[:q])
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
   end

  def require_user_logged_in!
    if current_user.nil?
      flash[:error] = "You must be signed in to do that."
      redirect_to sign_in_path
    end
  end

  def require_user_logged_out!
    if current_user
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

  def refresh_page
    @refresh_page = true
  end

  def cookie_set
    @user = current_user
    return unless current_user
    cookies[:user_id] = @user.id
  end
end
