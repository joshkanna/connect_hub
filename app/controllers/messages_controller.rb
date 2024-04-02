class MessagesController < ApplicationController
  def index

  end
  
  def show

  end
  
  def new

  end

  def create
  

    @message = Message.new(message_params)

    @message.user = User.find(params[:message][:user_id])
    @message.chat = Chat.find(params[:message][:chat_id])

    if @message.save
      SendMessageJob.perform_later(@message)

    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def destroy
    @message = Message.find(params[:id])
    @message.destroy
  end

  private

  def message_params
    params.require(:message).permit(:content, :user_id, :chat_id)
  end
end