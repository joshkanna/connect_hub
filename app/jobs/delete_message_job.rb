class DeleteMessageJob < ApplicationJob
  queue_as :default

  def perform(message)
    # Do something later
    mine = ApplicationController.render(partial: 'messages/mine',
    locals: { message: message })

    theirs = ApplicationController.render(partial: 'messages/theirs',
    locals: { message: message })
    ActionCable.server.broadcast("message_channel", { action: "delete", message: message, mine: mine, theirs: theirs })
    message.destroy
  end
end
