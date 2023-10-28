# frozen_string_literal: true

require 'test_helper'

class SubscriptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = sign_in create(:user)
    @subscription = create(:subscription, user: @user)
  end

  # Index
  test 'should get index' do
    get subscriptions_url

    assert_response :success
  end

  # New
  test 'should get new' do
    get new_subscription_url

    assert_response :success
  end

  # Create
  test 'should create subscription with rss feed' do
    assert_enqueued_jobs 1 do
      assert_difference ['Subscription.count', 'RssFeed.count'] do
        post subscriptions_url,
             params: { subscription: { name: 'My blog', subscribable_type: 'RssFeed', subscribable_attributes: { url: 'https://example.org' } } }
      end
    end

    assert_redirected_to subscription_url(Subscription.last)
  end

  test 'should create subscription with newsletter' do
    assert_enqueued_jobs 1 do
      assert_difference ['Subscription.count', 'Newsletter.count'] do
        post subscriptions_url,
             params: { subscription: { name: 'My blog', subscribable_type: 'Newsletter',
                                       subscribable_attributes: { url: nil } } }
      end
    end

    assert_redirected_to subscription_url(Subscription.last)
  end

  test 'should render new if subscription is invalid' do
    assert_no_difference 'Subscription.count' do
      post subscriptions_url, params: { subscription: { name: 'My blog', subscribable_type: nil } }
    end

    assert_response :unprocessable_entity
  end

  # Show
  test 'should get show' do
    get subscription_url(@subscription)

    assert_response :success
  end

  # Edit
  test 'should get edit' do
    get edit_subscription_url(@subscription)

    assert_response :success
  end

  # Update
  test 'should update subscription' do
    assert_changes '@subscription.reload.name' do
      patch subscription_url(@subscription), params: { subscription: { name: 'My new blog' } }
    end

    assert_redirected_to subscription_url(@subscription)
  end

  test 'should render edit if subscription is invalid' do
    assert_no_changes '@subscription.reload.name' do
      patch subscription_url(@subscription), params: { subscription: { name: nil } }
    end

    assert_response :unprocessable_entity
  end

  # Destroy
  test 'should destroy subscription' do
    assert_difference 'Subscription.count', -1 do
      delete subscription_url(@subscription)
    end

    assert_redirected_to subscriptions_url
  end
end
