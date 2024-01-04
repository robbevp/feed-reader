# frozen_string_literal: true

class RefreshRssFeedJob < ApplicationJob
  queue_as :default

  # Ignore when we can't open a connection or get a server error - we'll just refresh later on
  discard_on Errno::EBUSY, Net::HTTPFatalError

  def perform(rss_feed)
    rss_feed.refresh!
  end
end
