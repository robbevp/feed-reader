# frozen_string_literal: true

class EntryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(subscription: user.subscriptions)
    end
  end

  def index?
    user.present?
  end

  def show?
    record.user_id == user&.id
  end

  def update?
    record.user_id == user&.id
  end

  def permitted_attributes
    %i[read]
  end
end
