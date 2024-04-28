class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates_presence_of :body
  # noticed 
  has_many :noticed_events, as: :record, dependent: :destroy, class_name: "Noticed::Event"
  has_many :notifications, through: :noticed_events, class_name: "Noticed::Notification"
end
