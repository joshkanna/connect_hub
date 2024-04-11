class SendNotificationJob < ApplicationJob
  queue_as :default

  def perform(request)
    request_html = ApplicationController.render(partial: 'shared/notifications', locals: { request: request })
    ActionCable.server.broadcast("notifications_channel", { request: request, request_html: request_html })
  end
end
