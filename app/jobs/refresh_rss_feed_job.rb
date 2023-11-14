# frozen_string_literal: true

class RefreshRssFeedJob < ApplicationJob
  queue_as :default

  # Ignore when we can't open a connection - we'll just refresh later on
  discard_on Errno::EBUSY

  def perform(rss_feed)
    rss_feed.refresh!
  end
end
