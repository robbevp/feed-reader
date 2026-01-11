# frozen_string_literal: true

require 'test_helper'

class RunIngressCheckJobTest < ActiveJob::TestCase
  include ActionMailer::TestHelper

  test 'should create ingress and send mail if previous is more than 6 hours old' do
    travel_to(7.hours.ago) { create(:ingress_check, :received) }

    assert_difference 'IngressCheck.count' do
      assert_emails 1 do
        RunIngressCheckJob.perform_now
      end
    end

    assert_no_difference 'IngressCheck.count' do
      RunIngressCheckJob.perform_now
    end
  end

  test 'should destroy checks that are more than 10 days old' do
    travel_to((10.days + 1.hour).ago) { create(:ingress_check, :received) }
    travel_to(9.days.ago) { create(:ingress_check, :received) }
    create(:ingress_check)

    assert_difference 'IngressCheck.count', -1 do
      RunIngressCheckJob.perform_now
    end
  end

  test 'should raise if check is not received within one hour' do
    travel_to(61.minutes.ago) { create(:ingress_check, :received) }
    travel_to(61.minutes.ago) { create(:ingress_check) }
    travel_to(59.minutes.ago) { create(:ingress_check) }

    exception = assert_raises(RunIngressCheckJob::MissingIngressChecksError) do
      RunIngressCheckJob.perform_now
    end

    assert_equal '1 checks are not yet delivered', exception.message
  end
end
