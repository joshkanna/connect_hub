class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat

  accepts_nested_attributes_for :chat

  has_many :noticed_events, as: :record, dependent: :destroy, class_name: "Noticed::Event"
  has_many :notifications, through: :noticed_events, class_name: "Noticed::Notification"
end
