class MainController < ApplicationController
  include ApplicationHelper
  def index
    @user = current_user
    @friends_w_posts = []
    user_friends(@user).each { |friend| @friends_w_posts << friend unless friend.posts.empty? }
  end
end