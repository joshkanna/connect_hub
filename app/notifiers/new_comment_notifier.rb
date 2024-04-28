# To deliver this notification:
#
# NewCommentNotifier.with(record: @post, message: "New post").deliver(User.all)

class NewCommentNotifier < ApplicationNotifier
  deliver_by :action_cable do |config|
    config.stream = ->{ recipient }
    config.message = :to_websocket
  end
  # Add your delivery methods
  #
  # deliver_by :email do |config|
  #   config.mailer = "UserMailer"
  #   config.method = "new_post"
  # end
  #
  # bulk_deliver_by :slack do |config|
  #   config.url = -> { Rails.application.credentials.slack_webhook_url }
  # end
  #
  # deliver_by :custom do |config|
  #   config.class = "MyDeliveryMethod"
  # end

  # Add required params
  

  def to_websocket(notification)
    { count: notification.recipient.notifications.includes(:event).where.not(noticed_events: { record_type: 'Message'}).unseen.count }
  end

  notification_methods do
    def message
      "#{record.user.username} commented #{record.body}"
    end
    
    def url
      user_post_path(recipient, record.post.id)
    end
  end
end
