class ChatsController < ApplicationController
  def show

    @user = User.find(params[:user_id])
    @chats = @user.chats.all + Chat.where(user2_id: @user.id)
    
    @chat = Chat.find(params[:id])

    
    @messages = @chat.messages.sort_by { |message| message.created_at }

    @user_2 = User.find(@chat.user2_id)

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
      redirect_to user_chat_path(Current.user, @chat)
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