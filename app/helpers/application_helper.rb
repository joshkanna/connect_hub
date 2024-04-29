module ApplicationHelper
  def user_friends(user)
    friends = []
    Friendship.where(friend: user).each { |friendship| friends << friendship.user unless friends.include?(friendship.user)}
    @user_friends = user.friends +  friends
  end
end
