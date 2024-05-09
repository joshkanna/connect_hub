# frozen_string_literal: true

class PasswordResetsController < ApplicationController
  before_action :disable_nav

  def new; end

  def create
    @user = User.find_by(email: params[:email])

    if @user.present?
      @user.send_password_reset
      redirect_to password_resets_path
    else
      flash.now[:error] = 'Email not found'
      render :new, status: :unprocessable_entity
    end
  end

  def index; end

  def edit
    @user = User.find_by(password_reset_token: params[:id])
  end

  def update
    @user = User.find_by(password_reset_token: params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      flash[:notice] = 'Password rest has expired'
      redirect_to new_password_reset_path
    elsif @user.update(password_params)
      flash[:notice] = 'Password has been reset!'
      redirect_to sign_in_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
