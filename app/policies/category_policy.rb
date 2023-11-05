# frozen_string_literal: true

class CategoryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.none if user.blank?

      # We filter by the users subscriptions and all ancestors, and use this to create a regular query chain
      scope.where(id: Category.ancestors_by_id(scope.where(id: user.subscriptions.select(:category_id)).select(:id),
                                               include_self: true))
    end
  end
end
