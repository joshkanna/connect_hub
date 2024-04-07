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
<<<<<<< HEAD
    @message = Message.find(params[:id])
    @message.destroy
=======
    
    @message = Message.find(params[:id])
    @chat = @message.chat
    DeleteMessageJob.perform_later(@message)
    redirect_to user_chat_path(@chat), status: :see_other
>>>>>>> testing
  end

  private

  def message_params
    params.require(:message).permit(:content, :user_id, :chat_id)
  end
end