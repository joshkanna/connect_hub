require 'rails_helper'

RSpec.feature "User Registration", type: :feature do
  scenario "User signs up successfully" do
    visit sign_up_path
    
    fill_in "Username", with: "testuser"
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password"
    fill_in "Confirm Password", with: "password"
    
    click_button "Next"
    
    expect(page).to have_text("Succesfully created account.")
  end
end