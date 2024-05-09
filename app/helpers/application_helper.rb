# frozen_string_literal: true

module ApplicationHelper
  def user_friends(user)
    friends = []
    Friendship.where(friend: user).find_each do |friendship|
      friends << friendship.user unless friends.include?(friendship.user)
    end
    @user_friends = user.friends + friends
  end
end
