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
    user_owns_record?
  end

  def update?
    user_owns_record?
  end

  def destroy?
    user_owns_record?
  end

  def permitted_attributes
    %i[read] if user.present?
  end

  def permitted_attributes_for_index
    %i[include_read category_id] if user.present?
  end

  private

  def user_owns_record?
    record.user_id == user&.id
  end
end
