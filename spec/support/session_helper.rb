# frozen_string_literal: true

module SessionHelpers
  def sign_in_as(user)
    visit sign_in_path

    fill_in 'Username or Email', with: user.username
    fill_in 'Password', with: user.password

    click_button 'Log In'
  end
end
