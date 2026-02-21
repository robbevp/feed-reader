# frozen_string_literal: true

class SubscriptionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user:)
    end
  end

  def index?
    user.present?
  end

  def create?
    user.present?
  end

  def show?
    user_owns_record?
  end

  def update?
    user_owns_record?
  end

  def mark_all_as_read?
    user_owns_record?
  end

  def destroy?
    user_owns_record?
  end

  def permitted_attributes
    return if user.blank?

    own = %i[name subscribable_type category_text]
    own + [{ subscribable_attributes: %i[id url] }]
  end

  private

  def user_owns_record?
    record.user_id == user&.id
  end
end
