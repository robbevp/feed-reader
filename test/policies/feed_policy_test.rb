# frozen_string_literal: true

require 'test_helper'

class SubscriptionPolicyTest < ActiveSupport::TestCase
  setup do
    @user = build_stubbed(:user)
  end

  test 'should allow index for user' do
    assert_permitted @user, Subscription, :index
    assert_not_permitted nil, Subscription, :index
  end

  test 'should allow new for user' do
    assert_permitted @user, Subscription, :new
    assert_not_permitted nil, Subscription, :new
  end

  test 'should allow create for user' do
    assert_permitted @user, Subscription, :create
    assert_not_permitted nil, Subscription, :create
  end

  test 'should allow show if user is owner' do
    subscription = build_stubbed(:subscription, user: @user)

    assert_permitted @user, subscription, :show
    assert_not_permitted build_stubbed(:user), subscription, :show
    assert_not_permitted nil, subscription, :show
  end

  test 'should allow edit if user is owner' do
    subscription = build_stubbed(:subscription, user: @user)

    assert_permitted @user, subscription, :edit
    assert_not_permitted build_stubbed(:user), subscription, :edit
    assert_not_permitted nil, subscription, :edit
  end

  test 'should allow update if user is owner' do
    subscription = build_stubbed(:subscription, user: @user)

    assert_permitted @user, subscription, :update
    assert_not_permitted build_stubbed(:user), subscription, :update
    assert_not_permitted nil, subscription, :update
  end

  test 'should allow mark_all_as_read if user is owner' do
    subscription = build_stubbed(:subscription, user: @user)

    assert_permitted @user, subscription, :mark_all_as_read
    assert_not_permitted build_stubbed(:user), subscription, :mark_all_as_read
    assert_not_permitted nil, subscription, :mark_all_as_read
  end

  test 'should allow destroy if user is owner' do
    subscription = build_stubbed(:subscription, user: @user)

    assert_permitted @user, subscription, :destroy
    assert_not_permitted build_stubbed(:user), subscription, :destroy
    assert_not_permitted nil, subscription, :destroy
  end

  test 'should allow permitted attributes for user' do
    assert_permitted_attributes @user, Subscription
    assert_no_permitted_attributes nil, Subscription
  end

  test 'should scope subscriptions that belong to user' do
    user = create(:user)
    subscription = create(:subscription, user:)
    other_subscription = create(:subscription)

    assert_scope_includes user, subscription
    assert_scope_not_includes user, other_subscription
    assert_scope_empty nil, Subscription
  end
end
