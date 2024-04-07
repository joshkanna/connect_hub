class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :user2, class_name: 'User'

  has_many :messages

end
