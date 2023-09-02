# frozen_string_literal: true

require 'test_helper'

class RefreshFeedJobTest < ActiveJob::TestCase
  setup do
    @feed = create(:feed)
    stub_request(:any, @feed.url)
      .to_return(body: Rails.root.join('test/fixtures/files/example_feed.xml').read)
  end

  test 'should run refresh on feed' do
    assert_difference 'Entry.count' do
      assert_changes '@feed.reload.last_fetched_at' do
        RefreshFeedJob.perform_now(@feed)
      end
    end
  end
end
