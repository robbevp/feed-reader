# frozen_string_literal: true

class PasswordsController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def new
    authorize :password
  end

  def create
    authorize :password
    @user = User.find_by(email: params[:password][:email])
    UserMailer.with(user: @user).reset_password.deliver_later if @user.present?
    # NOTE: we always send a success message, to obfusciate whether a user exists or not
    flash[:success] = t '.success'
    redirect_to new_session_path
  end

  def edit; end

  def update
    if @user.update(transformed_attributes)
      flash[:success] = t '.success'
      redirect_to new_session_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find_by_password_reset_token params[:token]

    if @user.nil?
      flash[:danger] = t '.invalid_token'
      redirect_to new_password_path
    end

    authorize @user, policy_class: PasswordPolicy
  end

  def transformed_attributes
    params.require(:password).permit(:password, :password_confirmation)
          .with_defaults!({ password: '', password_confirmation: '' })
  end
end
