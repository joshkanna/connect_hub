class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.includes(:event).where.not(noticed_events: { record_type: 'Message'})
    @notifications.unseen.mark_as_seen
    @notifications = @notifications.sort_by { |notification| notification.created_at }.reverse
    
  end
end