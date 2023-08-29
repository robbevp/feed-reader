# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.none if user.blank?
      return scope.where(id: user.id) unless user.admin?

      scope
    end
  end

  def update?
    record == user
  end

  def permitted_attributes
    return if user.blank?

    attrs = %i[email password password_confirmation password_challenge]
    attrs << :admin if user.admin?
    attrs
  end
end
