# frozen_string_literal: true

class DeleteMessageJob < ApplicationJob
  queue_as :default

  def perform(message)
    # Do something later
    mine = ApplicationController.render(partial: 'messages/mine',
                                        locals: { message: })

    theirs = ApplicationController.render(partial: 'messages/theirs',
                                          locals: { message: })
    ActionCable.server.broadcast('message_channel', { action: 'delete', message:, mine:, theirs: })
    message.destroy
  end
end
