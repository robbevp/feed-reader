# frozen_string_literal: true

class EntryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(feed: user.feeds)
    end
  end

  def index?
    user.present?
  end

  def show?
    record.feed.user_id == user&.id
  end

  def update?
    record.feed.user_id == user&.id
  end

  def permitted_attributes
    %i[read]
  end
end
