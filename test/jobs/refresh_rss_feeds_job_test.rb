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
end
