# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'User Profile', type: :feature do
  scenario 'User can view their posts index page' do
    user = create(:user, username: 'testuser', email: 'test@example.com', password: 'password')

    visit sign_in_path
    sign_in_as(user)

    visit profile_user_path(user)

    click_button 'Post'

    expect(page).to have_text('Posts')
  end

  scenario 'User can view their friends' do
    user = create(:user, username: 'testuser', email: 'test@example.com', password: 'password')

    visit sign_in_path
    sign_in_as(user)

    visit profile_user_path(user)

    click_link "#{user.friends.count} friends"

    expect(page).to have_content('friends')
  end

  scenario 'User can view their friend requests' do
    user = create(:user, username: 'testuser', email: 'test@example.com', password: 'password')
    user2 = create(:user, username: 'testuser2', email: 'test2@example.com', password: 'password')

    visit sign_in_path
    sign_in_as(user)
    FriendRequest.create(sender_id: user2.id, receiver_id: user.id, status: 'pending')

    visit profile_user_path(user)

    expect(page).to have_text('Pending Friend Requests')
    expect(page).to have_content(user2.username)
    expect(page).to have_text('Accept')
    expect(page).to have_text('Reject')
  end

  scenario 'User can view other profile pages' do
    user = create(:user, username: 'testuser', email: 'test@example.com', password: 'password')
    user2 = create(:user, username: 'testuser2', email: 'test2@example.com', password: 'password')

    visit sign_in_path
    sign_in_as(user)

    visit profile_user_path(user2)

    expect(page).to have_text("@#{user2.username}")
    expect(page).to have_text('Send Friend Request')

    click_button 'Posts'
    expect(page).to have_text("User not in Friend's list.")
  end

  scenario "User can view their friend's posts" do
    user = create(:user, username: 'testuser', email: 'test@example.com', password: 'password')
    user2 = create(:user, username: 'testuser2', email: 'test2@example.com', password: 'password')

    Friendship.create(user_id: user.id, friend_id: user2.id)
    Friendship.create(user_id: user2.id, friend_id: user.id)

    visit sign_in_path
    sign_in_as(user)

    visit profile_user_path(user2)

    click_button 'Posts'
    expect(page).to have_text('Posts')
  end
end
