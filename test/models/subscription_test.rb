# frozen_string_literal: true

require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  # Validations
  test 'should not be valid without name' do
    subscription = build(:subscription, name: nil)

    assert_not_predicate subscription, :valid?
    assert_includes subscription.errors['name'], "can't be blank"
  end
end
