# frozen_string_literal: true

require 'test_helper'

class RefreshRssFeedsJobTest < ActiveJob::TestCase
  setup do
    @feed = create(:rss_feed)
  end

  test 'should schedule job for each feed' do
    assert_enqueued_jobs 1 do
      RefreshRssFeedsJob.perform_now
    end
  end

  test 'should not schedule job for feed with too high error count' do
    create(:rss_feed, error_count: 25)

    assert_enqueued_jobs 1 do
      RefreshRssFeedsJob.perform_now
    end
  end
end
