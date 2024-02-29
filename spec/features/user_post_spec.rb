require 'rails_helper'

RSpec.feature "User Registration", type: :feature do
  scenario "User successfully creates new post" do
    user = create(:user, username: "testuser", email: "test@example.com", password: "password")

    visit sign_in_path 
    sign_in_as(user)
    
    visit new_user_post_path(user)

    fill_in "Title", with: "New Post"
    fill_in "Body", with: "Lorem Ipsum."

    click_button "Post"

    expect(page).to have_current_path(user_post_path(user, Post.find(1)))
  end

  scenario "User succesfully edits a post" do
    user = create(:user, username: "testuser", email: "test@example.com", password: "password")

    visit sign_in_path 
    sign_in_as(user)
    
    visit new_user_post_path(user)

    fill_in "Title", with: "New Post"
    fill_in "Body", with: "Lorem Ipsum."

    click_button "Post"

    click_button(id: "seeMore")
    click_link "Edit"

    fill_in "Title", with: "edited Post"
    fill_in "Body", with: "Lorem Ipsum."
    
    click_button "Edit"
    
    expect(page).to have_current_path(user_post_path(user, Post.find(1)))
    expect(page).to have_text("edited Post")
    
  end
end