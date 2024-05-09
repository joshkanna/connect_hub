# frozen_string_literal: true

# To deliver this notification:
#
# NewMessageNotifier.with(record: @post, message: "New post").deliver(User.all)

class NewMessageNotifier < ApplicationNotifier
  deliver_by :action_cable do |config|
    config.stream = -> { recipient }
    config.message = :to_websocket
    config.unless = -> { record.user.username == 'chatbot' }
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
  required_param :chat

  def to_websocket(notification)
    chats = notification.recipient.chats.all + Chat.where(user2_id: notification.recipient.id)
    chats = chats.sort_by { |chat| chat.messages.last.updated_at unless chat.messages.empty? }.reverse
    chat_users = ApplicationController.render(partial: 'shared/chat_users',
                                              locals: { chats:,
                                                        user: notification.recipient })

    {
      messageCount: notification.recipient.notifications.includes(:event).where(noticed_events: { record_type: 'Message' }).unread.count, chatUsers: chat_users
    }
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
