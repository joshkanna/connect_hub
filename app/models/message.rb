class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat

  accepts_nested_attributes_for :chat
end
