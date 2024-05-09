# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  has_many :noticed_events, as: :record, dependent: :destroy, class_name: 'Noticed::Event'
  has_many :notifications, through: :noticed_events, class_name: 'Noticed::Notification'
end
