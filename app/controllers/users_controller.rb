class UsersController < ApplicationController
  before_action :require_user_logged_in!

  def profile
    @user = User.find(params[:id])
  end

  def send_friend_request
    receiver = User.find(params[:id])
    Current.user.sent_friend_requests.create(receiver: receiver, status: 'pending')
    redirect_to profile_user_path(Current.user), notice: 'Friend request sent successfully!'
  end

  def cancel_friend_request
    request = Current.user.sent_friend_requests.find(params[:request_id])
    request.destroy
    redirect_to Current.user, notice: 'Friend Request Canceled'
  end

  def accept_friend_request
    request = FriendRequest.find(params[:request_id])
    request.update(status: 'accepted')
    Friendship.create(user: request.sender, friend: request.receiver)
    Friendship.create(user: request.receiver, friend: request.sender)
    
    redirect_to profile_user_path(Current.user), notice: 'Friend request accepted!'
  end

  def reject_friend_request
    request = FriendRequest.find(params[:request_id])
    request.update(status: 'rejected')
  end
end