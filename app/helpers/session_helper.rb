module SessionHelper
  def log_in(user)
    session[:user_id] = user.id
    #below is unique code added for ActionCable find_verified_user
    cookies.signed[:actioncable_user_id] = user.id
    end
end
