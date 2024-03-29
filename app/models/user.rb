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

  has_one_attached :avatar

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id", "id_value", "password_digest", "updated_at", "username"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["friends", "friendships", "posts"]
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    PasswordResetsMailer.reset_password(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  
  private

  def downcase_name
    self.username = username.downcase if username.present?
  end
end