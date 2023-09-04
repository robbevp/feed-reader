# frozen_string_literal: true

class UserMailer < ApplicationMailer
  before_action :set_user

  def reset_password
    @token = @user.password_reset_token(expires_in: 1.hour)
    mail to: @user.email
  end

  private

  def set_user
    @user = params[:user]
  end
end
