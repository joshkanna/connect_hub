# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'User Registration', type: :feature do
  scenario 'User successfully creates new post' do
    user = create(:user, username: 'testuser', email: 'test@example.com', password: 'password')

    visit sign_in_path
    sign_in_as(user)

    visit new_user_post_path(user)

    fill_in 'Title', with: 'New Post'
    fill_in 'Body', with: 'Lorem Ipsum.'

    click_button 'Post'

    expect(page).to have_current_path(user_post_path(user, Post.find(1)))
  end

  scenario 'User succesfully edits a post' do
    user = create(:user, username: 'testuser', email: 'test@example.com', password: 'password')

    visit sign_in_path
    sign_in_as(user)

    visit new_user_post_path(user)

    fill_in 'Title', with: 'New Post'
    fill_in 'Body', with: 'Lorem Ipsum.'

    click_button 'Post'

    click_button(id: 'seeMore')
    click_link 'Edit'

    fill_in 'Title', with: 'edited Post'
    fill_in 'Body', with: 'Lorem Ipsum.'

    click_button 'Edit'

    expect(page).to have_current_path(user_post_path(user, Post.find(1)))
    expect(page).to have_text('edited Post')
  end

  scenario 'User succesfully creates a comment' do
    user = create(:user, username: 'testuser', email: 'test@example.com', password: 'password')
    user2 = create(:user, username: 'testuser2', email: 'test2@example.com', password: 'password')

    Friendship.create(user_id: user.id, friend_id: user2.id)
    Friendship.create(user_id: user2.id, friend_id: user.id)

    post = Post.create(id: 1, title: 'Hey', body: 'World', user_id: user.id)

    visit sign_in_path
    sign_in_as(user2)

    visit user_post_path(user, post)
    expect(page).to have_text('Add a comment:')

    fill_in 'Body', with: "What's up"
    click_button 'Create Comment'

    expect(page).to have_text("@#{user2.username}")
    expect(page).to have_text("What's up")
  end
end
