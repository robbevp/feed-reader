# frozen_string_literal: true

class UserMailer < ApplicationMailer
  before_action :set_user

  def reset_password
    @token = @user.generate_token_for(:password_reset)
    mail to: @user.email
  end

  private

  def set_user
    @user = params[:user]
  end
end
