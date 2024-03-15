class PasswordResetsMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.password_mailer.reset_password.subject
  #
  def reset_password(user)
    @user = user
    @greeting = "Hello"

    mail to: user.email, :subject => "Reset password instruction"
  end
end
