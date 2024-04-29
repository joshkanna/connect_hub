# app/helpers/message_helper.rb
module MessageHelper
  def time_until_next_unit(message)
    time_elapsed = Time.now - message.created_at


    if time_elapsed < 1.minute
      number = 'now'
      unit = ''
    elsif time_elapsed < 1.hour
      number = (time_elapsed / 60).to_i
      unit = "m"
    elsif time_elapsed < 1.day
      number = (time_elapsed / 3600).to_i
      unit = "h"
    elsif time_elapsed < 1.week
      number = (time_elapsed / (3600 * 24)).to_i
      unit = "d"
    elsif time_elapsed < 1.year
      number = (time_elapsed / (3600 * 24 * 7)).to_i
      unit = "w"
    else
      number = (time_elapsed / (3600 * 24 * 365)).to_i
      unit = "y"
    end

    "#{number} #{unit}"
  end

  def message_notifications(user, chat)
    @message_notifications = user.notifications.includes(:event).where(noticed_events: { record_type: 'Message', params: { chat: chat } } )
  end
end
