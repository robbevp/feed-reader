# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Pundit::Authorization

  default_form_builder ::ComponentFormBuilder

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  private

  def user_not_authorized
    return user_not_present if current_user.blank?

    flash[:danger] = t 'application_controller.helpers.user_not_authorized.forbidden'
    redirect_to request.referer || root_url
  end

  def user_not_present
    flash[:danger] = t 'application_controller.helpers.user_not_authorized.sign_in'
    session[:redirect_after_sign_in] = request.fullpath
    redirect_to new_session_path
  end
end
