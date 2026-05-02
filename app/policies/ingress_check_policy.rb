# frozen_string_literal: true

class IngressCheckPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      user&.admin? ? scope.all : scope.none
    end
  end

  def index?
    user&.admin?
  end

  def create?
    user&.admin?
  end
end
