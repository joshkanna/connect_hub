require 'rails_helper'

RSpec.feature "User Session", type: :feature do
  scenario "User logs up successfully" do
    user = create(:user, username: "testuser", email: "test@example.com", password: "password")
    visit sign_in_path
    
    fill_in "Username or Email", with: "testuser"
    fill_in "Password", with: "password"
    
    click_button "Log In"
    
    expect(page).to have_text("Logged in successfully.")
  end

  scenario "User logs out succesfully" do 
    user = create(:user, username: "testuser", email: "test@example.com", password: "password")

    sign_in_as(user)

    click_link "@#{user.username}"

    click_button "Log Out"

    expect(page).to have_text("Logged out")
  end
end