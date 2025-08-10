# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    authorize :session
    redirect_to root_path if current_user.present?
  end

  def create
    authorize :session
    @user = User.find_by(email: params[:session][:email])
    if @user&.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      set_remember_cookie

      redirect_to after_sign_in_path
    else
      render 'new', status: :unprocessable_content
    end
  end

  def destroy
    authorize :session
    session.delete(:user_id)
    cookies.delete(:_feed_reader_user_id)
    redirect_to new_session_path
  end

  private

  def after_sign_in_path
    session.delete(:redirect_after_sign_in) || root_path
  end

  def set_remember_cookie
    return unless params[:session][:remember_me] == '1'

    cookies.signed[:_feed_reader_user_id] = {
      value: @user.id,
      expires: 2.months
    }
  end
end
