# frozen_string_literal: true

class UsersController < ApplicationController
  def edit
    authorize current_user, policy_class: UserPolicy
  end

  def update
    authorize current_user, policy_class: UserPolicy
    if current_user.update(transformed_attributes)
      flash[:success] = t '.success'
      redirect_to profile_path
    else
      flash[:danger] = t '.danger'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def transformed_attributes
    attrs = permitted_attributes(current_user)
    # Make sure the confirmation and challenge fields can't be removed by the user to skip validations
    attrs.with_defaults!({ password_challenge: '', password_confirmation: '' }) if attrs.key? :password
    attrs
  end
end
