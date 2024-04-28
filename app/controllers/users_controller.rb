class UsersController < ApplicationController
  before_action :require_user_logged_in!

  

  def profile
    @user = User.find(params[:id])
    @posts = @user.posts.all

    @bio = @user.bio
  end

  def inbox
    @user = User.find(params[:id])
    @chats = @user.chats.all + Chat.where(user2_id: @user.id)

    @chats = @chats.sort_by { |chat| chat.messages.last.updated_at unless chat.messages.empty? }.reverse
  end

  def remove_profile_pic
    @user = User.find(params[:id])
    @user.avatar.purge
    redirect_to profile_user_path(@user)
  end

  def update
    @user = User.find(params[:id])

    avatar_changed = user_params.key?(:avatar)

    @user.avatar.purge if @user.avatar.attached? && avatar_changed

    if @user.update(user_params)
      redirect_to profile_user_path(@user)
    end
  end

  def send_friend_request
    receiver = User.find(params[:id])
    @request = current_user.sent_friend_requests.create(receiver: receiver, status: 'pending')
    @count = receiver.received_friend_requests.pending.count

    NewRequestNotifier.with(record: @request).deliver(receiver)
    
    SendNotificationJob.perform_later(@request, @count)
    
    redirect_to profile_user_path(receiver)
  end

  def cancel_friend_request
    request = current_user.sent_friend_requests.find(params[:request_id])
    receiver = request.receiver
    count = receiver.received_friend_requests.pending.count - 1

    DeleteNotificationJob.perform_later(request, count)
    
    redirect_to profile_user_path(User.find(params[:id]))
  end

  def accept_friend_request
    request = FriendRequest.find(params[:request_id])
    request.update(status: 'accepted')
    Friendship.create(user: request.sender, friend: request.receiver)
    Friendship.create(user: request.receiver, friend: request.sender)
    
    redirect_to main_path
  end

  def reject_friend_request
    request = FriendRequest.find(params[:request_id])
    request.update(status: 'rejected')
    redirect_to main_path
  end

  def remove_friend
    friend = User.find(params[:id])
    friendship = Friendship.find_by(user_id: current_user.id, friend_id: friend.id)
    friendship.destroy
    friendship = Friendship.find_by(user_id: friend.id, friend_id: current_user.id)
    friendship.destroy

    redirect_to profile_user_path(friend)
  end

  private
  def user_params
    params.require(:user).permit(:avatar, :bio)
  end
end