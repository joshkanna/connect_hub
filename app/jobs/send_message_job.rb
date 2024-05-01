class SendMessageJob < ApplicationJob
  queue_as :default

  def perform(message)
   

    theirs = ApplicationController.render(partial: 'messages/theirs', 
    locals: { message: message })
    
    ActionCable.server.broadcast("chat_channel_#{message.chat_id}", {  theirs: theirs, message: message })
  end
end
