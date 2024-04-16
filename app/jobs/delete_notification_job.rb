class DeleteNotificationJob < ApplicationJob
  queue_as :default

  def perform(request, count)
    # Do something later
    request_html = ApplicationController.render(partial: 'shared/notifications', locals: { request: request })
    request_html_mobile = ApplicationController.render(partial: 'shared/notifications_mobile', locals: { request: request })
    notification_count = ApplicationController.render(partial: 'shared/notification_count', locals: { count: count })
    notification_bottom_count = ApplicationController.render(partial: 'shared/notification_bottom_count', locals: { count: count })
    
    ActionCable.server.broadcast("notifications_channel_top", { action: "delete", request: request, request_html: request_html, notification_count: notification_count })
    ActionCable.server.broadcast("notifications_channel_bottom", { action: "delete", request: request, request_html_mobile: request_html_mobile, notification_bottom_count: notification_bottom_count })
    request.destroy
  end
end
