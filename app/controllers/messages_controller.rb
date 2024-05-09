# frozen_string_literal: true

class MessagesController < ApplicationController
  def index; end

  def show; end

  def new; end

  def create
    @message = Message.new(message_params)

    @message.user = User.find(params[:message][:user_id])

    @chat = @message.chat

    respond_to do |format|
      if @message.save
        SendMessageJob.perform_now(@message)

        if @chat.user == User.find_by(username: 'chatbot')
          format.turbo_stream do
            render turbo_stream: turbo_stream.append('messages', partial: 'messages/message',
                                                                 locals: { message: @message })
          end
          format.html { redirect_to user_chat_path(@message.user, @chat) }

          ChatService.new(messages: @chat.messages).call
        else
          NewMessageNotifier.with(record: @message,
                                  chat: @message.chat).deliver(@message.chat.user == @message.user ? @message.chat.user2 : @message.chat.user)
          format.turbo_stream do
            render turbo_stream: turbo_stream.append('messages', partial: 'messages/message',
                                                                 locals: { message: @message })
          end
          format.html { redirect_to @chat, notice: 'Message was successfully created.' }
        end
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('new_message', partial: 'messages/form',
                                                                   locals: { message: @message })
        end
        format.html { render :new, status: :unprocessable_entity }
      end
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
