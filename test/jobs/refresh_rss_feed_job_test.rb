# frozen_string_literal: true

require 'test_helper'

class RefreshRssFeedJobTest < ActiveJob::TestCase
  setup do
    @feed = create(:rss_feed)
    stub_request(:any, @feed.url)
      .to_return(body: Rails.root.join('test/fixtures/files/example_feed.xml').read)
  end

  test 'should run refresh on feed' do
    assert_difference 'Entry.count' do
      assert_changes '@feed.reload.last_fetched_at' do
        RefreshRssFeedJob.perform_now(@feed)
      end
    end
  end
end
