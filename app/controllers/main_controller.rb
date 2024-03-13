class MainController < ApplicationController
  def index
    @user = Current.user
    @friends_w_posts = []
    @user.friends.each { |friend| @friends_w_posts << friend unless friend.posts.empty? }
  end
end