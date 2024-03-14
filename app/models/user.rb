class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true, uniqueness: { case_sensitive: false }

  before_validation :downcase_name
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address"}


  has_many :posts
  has_many :comments

  # for friend requests
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :sent_friend_requests, class_name: 'FriendRequest', foreign_key: :sender_id
  has_many :received_friend_requests, class_name: 'FriendRequest', foreign_key: :receiver_id

  

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id", "id_value", "password_digest", "updated_at", "username"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["friends", "friendships", "posts"]
  end

  private

  def downcase_name
    self.username = username.downcase if username.present?
  end
end