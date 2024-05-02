class ChatsController < ApplicationController
  before_action :refresh_page
  before_action :messaging
  def show
    
    @user = User.find(params[:user_id])
    @chats = @user.chats.all + Chat.where(user2_id: @user.id)
    
    @chats.each { |chat| chat.destroy if chat.messages.empty? }

    if Chat.all.empty?
      redirect_to inbox_user_path(@user)
    else
      @chats = @chats.sort_by { |chat| chat.messages.last.updated_at unless chat.messages.empty? }.reverse

      @chat = Chat.find(params[:id])
      
      current_user.notifications.includes(:event).where(noticed_events: { record_type: 'Message', params: { chat: @chat }}).unread.mark_as_read

      @messages = @chat.messages.sort_by { |message| message.created_at }
      @user_2 = User.find(@chat.user2_id)
    end
  end

  def new
    @user = User.find(params[:user_id])
   
    @user_2 = User.find(params[:user2_id])
    

    @chat = @user.chats.new(user_id: @user.id, user2_id: @user_2.id)
    @message = @chat.messages.new

  end

  def create
    @user = User.find(params[:user_id])
   

    @user_2 = User.find_by(id: params[:chat][:user2_id])

    if @user_2.nil?
      flash[:error] = "User not found"
      redirect_to root_path
      return
    end

    puts "User id: #{@user.id}"

    puts "User 2 id: #{@user_2.id}"
    @chat = @user.chats.new(user_id: @user.id, user2_id: @user_2.id)
    puts "User2 id again: #{@chat.user2_id}"
    @chat.save
    @message = @chat.messages.build(user_id: @user.id, chat_id: @chat.id, content: chat_params[:message_attributes][:content])
    puts "Message User id: #{@message.user_id}"
    if @message.save
      NewMessageNotifier.with(record: @message, chat: @message.chat).deliver(@message.chat.user == @message.user ? @message.chat.user2 : @message.chat.user )
      redirect_to user_chat_path(current_user, @chat)
    else

      flash[:error] = "Failed to create chat or message"
      redirect_to root_path
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:user_id, :user2_id, message_attributes: [:content])
  end


end