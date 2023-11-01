# frozen_string_literal: true

require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  # Validations
  test 'should not be valid without name' do
    subscription = build(:subscription, name: nil)

    assert_not_predicate subscription, :valid?
    assert_includes subscription.errors['name'], "can't be blank"
  end

  # Callbacks
  test 'should create categories based on text during validations' do
    subscription = build(:subscription, category_text: 'music > bands')

    assert_difference 'Category.count', 2 do
      subscription.validate
    end

    assert_equal 'bands', subscription.category.name
    assert_equal 'music', subscription.category.parent.name
  end

  test 'should re-use existing categories when creating categories' do
    category = create(:category, name: 'music')
    subscription = build(:subscription, category_text: 'music > bands')

    assert_difference 'Category.count', 1 do
      subscription.validate
    end

    assert_equal 'bands', subscription.category.name
    assert_equal category, subscription.category.parent
  end
end
