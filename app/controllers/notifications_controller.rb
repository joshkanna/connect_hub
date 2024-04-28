class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.includes(:event).where.not(noticed_events: { record_type: 'Message'})

    @notifications.mark_as_seen
  end
end