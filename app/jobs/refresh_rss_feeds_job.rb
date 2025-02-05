# frozen_string_literal: true

class RefreshRssFeedsJob < ApplicationJob
  queue_as :default

  def perform
    RssFeed.find_each do |feed|
      RefreshRssFeedJob.perform_later(feed) if feed.should_refresh?
    end
  end
end
