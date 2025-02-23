# frozen_string_literal: true

# == Schema Information
#
# Table name: subscriptions
#
#  id                :bigint           not null, primary key
#  category_text     :string
#  name              :string           not null
#  subscribable_type :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  category_id       :bigint
#  subscribable_id   :bigint           not null
#  user_id           :bigint           not null
#
# Indexes
#
#  index_subscriptions_on_category_id   (category_id)
#  index_subscriptions_on_subscribable  (subscribable_type,subscribable_id)
#  index_subscriptions_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_id => users.id)
#
require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  # Validations
  test 'should not be valid without name' do
    subscription = build(:subscription, name: nil)

    assert_not_predicate subscription, :valid?
    assert_includes subscription.errors['name'], "can't be blank"
  end

  # Normalizes
  test 'should normalize categy text' do
    subscription = build(:subscription, category_text: ' Music>Bands  > Concerts')
    subscription.validate

    assert_equal 'Music > Bands > Concerts', subscription.category_text

    subscription.category_text = ' '
    subscription.validate

    assert_nil subscription.category_text
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

  # Class methods
  test 'should build category text options' do
    create(:subscription, category_text: nil)
    create(:subscription, category_text: 'Music > Bands > Concerts')
    create(:subscription, category_text: 'Music > Venues')
    create(:subscription, category_text: 'Art > Exhibitions')

    expected = ['Art', 'Art > Exhibitions', 'Music', 'Music > Bands', 'Music > Bands > Concerts', 'Music > Venues']

    assert_equal expected, Subscription.category_text_options
  end
end
