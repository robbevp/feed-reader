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
    record.user_id == user&.id
  end

  def update?
    record.user_id == user&.id
  end

  def destroy?
    record.user_id == user&.id
  end

  def permitted_attributes
    own = %i[name subscribable_type category_text]
    own + [subscribable_attributes: %i[id url]]
  end
end
