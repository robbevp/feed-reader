# frozen_string_literal: true

class RefreshFeedsJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    Feed.find_each do |feed|
      RefreshFeedJob.perform_later(feed)
    end
  end
end
