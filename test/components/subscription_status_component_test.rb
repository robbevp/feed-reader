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
    component = SubscriptionStatusComponent.new(subscription: @subscription)

    assert_equal 'Not fetched yet', component.label
    assert_equal 'clock', component.svg_name
  end

  test 'should return correct SVG and label when it has errors' do
    @subscription.subscribable.update(error_count: 5)

    component = SubscriptionStatusComponent.new(subscription: @subscription)

    assert_equal 'Last fetch failed', component.label
    assert_equal 'exclamation-triangle', component.svg_name
  end

  test 'should return correct SVG and label when it has too many errors' do
    @subscription.subscribable.update(error_count: 25)

    component = SubscriptionStatusComponent.new(subscription: @subscription)

    assert_equal 'Too many errors', component.label
    assert_equal 'x-mark', component.svg_name
  end
end
