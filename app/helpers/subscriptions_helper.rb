# frozen_string_literal: true

module SubscriptionsHelper
  def subscription_status_info(subscription)
    return nil unless subscription.refreshable?

    status = if !subscription.subscribable.should_refresh?
               :error
             elsif subscription.subscribable.any_error?
               :warning
             elsif subscription.last_fetched_info.blank?
               :none
             else
               :success
             end

    { class: "subscription__status--#{status}", label: I18n.t("subscriptions.index.statuses.#{status}") }
  end
end
