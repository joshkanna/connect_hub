class SendNotificationJob < ApplicationJob
  queue_as :default

  def perform(request, count)
    request_html = ApplicationController.render(partial: 'shared/notifications', locals: { bar: 'desktop', request: request })
    request_html_mobile = ApplicationController.render(partial: 'shared/notifications', locals: { bar: 'mobile', request: request })
    notification_count = ApplicationController.render(partial: 'shared/notification_count', locals: { bar: 'desktop', count: count })
    notification_bottom_count = ApplicationController.render(partial: 'shared/notification_count', locals: { bar: 'mobile', count: count })
    
    
    ActionCable.server.broadcast("notifications_channel_top", { action: "send", request: request, request_html: request_html, notification_count: notification_count })
    ActionCable.server.broadcast("notifications_channel_bottom", { action: "send", request: request, request_html_mobile: request_html_mobile, notification_bottom_count: notification_bottom_count })
  end
end
