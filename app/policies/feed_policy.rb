# frozen_string_literal: true

class FeedPolicy < ApplicationPolicy
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
    %i[name url]
  end
end
