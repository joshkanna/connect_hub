class ChatsController < ApplicationController
  def show

    @user = User.find(params[:user_id])
    @chats = @user.chats.all + Chat.where(user2_id: @user.id)
    
    @chat = Chat.find(params[:id])
    @user_2 = User.find(@chat.user2_id)

  end

  def new
    @user = User.find(params[:user_id])
   
    @user_2 = User.find_by(id: params[:user2_id])
    puts @user_2.id

    @chat = @user.chats.new
    @message = @chat.messages.new

    
  end

  def create
    @user = User.find(params[:user_id])
   

    @user_2 = User.find_by(id: params[:user2_id])
    puts @user.id
    @chat = @user.chats.new(user_id: @user.id, user2_id: @user_2.id)

    @message = @chat.messages.build(chat_params[:message_attributes])

    if @chat.save && @message.save
      redirect_to chat_path(@chat)
    else
      # Handle error if chat or message creation fails
      flash[:error] = "Failed to create chat or message"
      redirect_to root_path
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:user_id, :user2_id, message_attributes: [:content])
  end


end