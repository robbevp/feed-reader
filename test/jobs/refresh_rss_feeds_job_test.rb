# frozen_string_literal: true

require 'test_helper'

class RefreshFeedsJobTest < ActiveJob::TestCase
  setup do
    @feed = create(:feed)
  end

  test 'should schedule job for each feed' do
    assert_enqueued_jobs 1 do
      RefreshFeedsJob.perform_now
    end
  end
end
