# frozen_string_literal: true

class PasswordPolicy < ApplicationPolicy
  def create?
    true
  end

  def update?
    true
  end
end
