# frozen_string_literal: true

require 'test_helper'

class RefreshFeedJobTest < ActiveJob::TestCase
  include FeedHelper

  setup do
    @feed = create(:feed)
    mock_all_feeds
  end

  test 'should run refresh on feed' do
    assert_difference 'Entry.count' do
      assert_changes '@feed.reload.last_fetched_at' do
        RefreshFeedJob.perform_now(@feed)
      end
    end
  end
end
