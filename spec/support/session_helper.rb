
module SessionHelpers
  def sign_in_as(user)
    visit sign_in_path
    
    fill_in "Username or Email", with: "testuser"
    fill_in "Password", with: "password"
    
    click_button "Log In"
  end
end
