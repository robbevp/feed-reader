# frozen_string_literal: true

class SubscriptionStatusComponent < ViewComponent::Base
  SVG_NAMES = {
    warning: 'exclamation-triangle',
    error: 'x-mark',
    none: 'clock'
  }.freeze

  attr_reader :subscription

  def initialize(subscription:)
    super()
    @subscription = subscription
  end

  def render?
    return false unless subscription.refreshable?
    return false if status == :success

    true
  end

  def label
    I18n.t("subscriptions.index.statuses.#{status}")
  end

  def svg_name
    SVG_NAMES[status]
  end

  private

  def status
    return :error unless subscription.subscribable.should_refresh?
    return :warning if subscription.subscribable.any_error?
    return :none if subscription.last_fetched_info.blank?

    :success
  end
end
