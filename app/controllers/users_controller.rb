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
  end

  def remove_profile_pic
    @user = User.find(params[:id])
    @user.avatar.purge
    redirect_to profile_user_path(@user)
  end

  def update
    @user = User.find(params[:id])
    @user.avatar.purge if @user.avatar.attached?

    if @user.update(user_params)
      redirect_to profile_user_path(@user)
    end
  end

  def send_friend_request
    receiver = User.find(params[:id])
    @request = Current.user.sent_friend_requests.create(receiver: receiver, status: 'pending')
    

    SendNotificationJob.perform_later(@request)
    
    redirect_to profile_user_path(receiver)
  end

  def cancel_friend_request
    request = Current.user.sent_friend_requests.find(params[:request_id])
    request_html = ApplicationController.render(partial: 'shared/notifications', locals: {request: request })


    ActionCable.server.broadcast("notifications_channel", { action: "delete", request: request, request_html: request_html })

    request.destroy

    redirect_to profile_user_path(User.find(params[:id]))
  end

  def accept_friend_request
    request = FriendRequest.find(params[:request_id])
    request.update(status: 'accepted')
    Friendship.create(user: request.sender, friend: request.receiver)
    Friendship.create(user: request.receiver, friend: request.sender)
    
    redirect_to main_path, notice: 'Friend request accepted!'
  end

  def reject_friend_request
    request = FriendRequest.find(params[:request_id])
    request.update(status: 'rejected')
  end

  def remove_friend
    friend = User.find(params[:id])
    friendship = Friendship.find_by(user_id: Current.user.id, friend_id: friend.id)
    friendship.destroy
    friendship = Friendship.find_by(user_id: friend.id, friend_id: Current.user.id)
    friendship.destroy

    redirect_to profile_user_path(friend)
  end

  private
  def user_params
    params.require(:user).permit(:avatar, :bio)
  end
end