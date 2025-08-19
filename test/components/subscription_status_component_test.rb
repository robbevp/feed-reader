# frozen_string_literal: true

require 'test_helper'

class SubscriptionStatusComponentTest < ViewComponent::TestCase
  setup do
    @subscription = create(:subscription, subscribable: create(:rss_feed))
  end

  test 'should not render when there is no error and feed has been fetched' do
    @subscription.subscribable.update(last_fetched_at: Time.current)

    render_inline(SubscriptionStatusComponent.new(subscription: @subscription))

    refute_component_rendered
  end

  test 'should not render when subscribable is not refreshable' do
    @subscription.update(subscribable: create(:newsletter))

    render_inline(SubscriptionStatusComponent.new(subscription: @subscription))

    refute_component_rendered
  end

  test 'should return correct SVG and label when not fetched yet' do
    render_inline SubscriptionStatusComponent.new(subscription: @subscription)

    assert_selector '.icon[aria-labelledby]'
    assert_equal I18n.t('subscriptions.index.statuses.none'), page.find('svg title').text
    assert_selector ".icon[data-icon-name='clock']"
  end

  test 'should return correct SVG and label when it has errors' do
    @subscription.subscribable.update(error_count: 5)

    render_inline SubscriptionStatusComponent.new(subscription: @subscription)

    assert_selector '.icon[aria-labelledby]'
    assert_equal I18n.t('subscriptions.index.statuses.warning'), page.find('svg title').text
    assert_selector ".icon[data-icon-name='exclamation-triangle']"
  end

  test 'should return correct SVG and label when it has too many errors' do
    @subscription.subscribable.update(error_count: 25)

    render_inline SubscriptionStatusComponent.new(subscription: @subscription)

    assert_selector '.icon[aria-labelledby]'
    assert_equal I18n.t('subscriptions.index.statuses.error'), page.find('svg title').text
    assert_selector ".icon[data-icon-name='x-mark']"
  end
end
