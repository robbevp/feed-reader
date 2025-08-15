# frozen_string_literal: true

class RefreshRssFeedJob < ApplicationJob
  queue_as :default

  def perform(rss_feed)
    rss_feed.refresh!
  end
end
