# frozen_string_literal: true

class RefreshRssFeedsJob < ApplicationJob
  queue_as :default

  def perform
    RssFeed.for_refresh.find_each do |feed|
      RefreshRssFeedJob.perform_later(feed)
    end
  end
end
