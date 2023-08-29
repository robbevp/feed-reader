# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    authorize :session
    redirect_to profile_path if current_user.present?
  end

  def create
    authorize :session
    @user = User.find_by(email: params[:session][:email])
    if @user&.authenticate(params[:session][:password])
      # TODO: Allow option to have long-lived sessions
      session[:user_id] = @user.id
      redirect_to profile_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    authorize :session
    session[:user_id] = nil
    redirect_to sign_in_path
  end
end
