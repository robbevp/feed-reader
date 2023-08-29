# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  default_form_builder ::ComponentFormBuilder

  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
