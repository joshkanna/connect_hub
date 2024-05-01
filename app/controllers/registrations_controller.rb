class RegistrationsController < ApplicationController
  before_action :require_user_logged_out!
  before_action :disable_nav

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Succesfully created account."
      @chatbot = User.find_by(username: 'chatbot')
      @chat = Chat.create(user_id: @chatbot.id, user2_id: @user.id)
      @message = @chat.messages.create(user_id: @chatbot.id, chat_id: @chat.id, content: "Hey there! welcome to our chat! I'm here to help and chat with you. How can I assist you today?")
      NewMessageNotifier.with(record: @message, chat: @message.chat).deliver(@message.chat.user == @message.user ? @message.chat.user2 : @message.chat.user )
      redirect_to root_path
    else
      @user.destroy
      render :new, status: :unprocessable_entity
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end