# To deliver this notification:
#
# NewFriendshipNotifier.with(record: @post, message: "New post").deliver(User.all)

class NewFriendshipNotifier < ApplicationNotifier
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
  #

  def to_websocket(notification)
    { count: notification.recipient.notifications.includes(:event).where.not(noticed_events: { record_type: 'Message'}).unseen.count }
  end

  notification_methods do
    def message
      if recipient == record.user
        "#{record.friend.username} is now your friend"
      elsif recipient == record.friend
        "#{record.user.username} is now your friend"
      end
    end
    
    def url
      if recipient == record.user
        profile_user_path(record.friend)
      elsif recipient == record.friend
        profile_user_path(record.user)
      end
    end
  end
end
