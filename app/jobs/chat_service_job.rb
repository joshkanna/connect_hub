# frozen_string_literal: true

class ChatServiceJob < ApplicationJob
  queue_as :default

  def perform(messages)
    # Do something later
    ChatService.new(messages:).call
  end
end
