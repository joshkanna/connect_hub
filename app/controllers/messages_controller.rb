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


    if @message.save
      
      SendMessageJob.perform_later(@message)
      NewMessageNotifier.with(record: @message, chat: @message.chat).deliver(@message.chat.user == @message.user ? @message.chat.user2 : @message.chat.user )
      redirect_to user_chat_path(user_id: @message.user.id, id: @message.chat.id)
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def destroy
    
    @message = Message.find(params[:id])
    @chat = @message.chat
    DeleteMessageJob.perform_later(@message)
    redirect_to user_chat_path(@chat), status: :see_other
  end

  private

  def message_params
    params.require(:message).permit(:content, :user_id, :chat_id)
  end
end