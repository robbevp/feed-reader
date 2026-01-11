# frozen_string_literal: true

require 'test_helper'

class SystemMailerTest < ActionMailer::TestCase
  test 'should send ingress check mail' do
    check = create(:ingress_check)

    mail = SystemMailer.ingress_check(check)

    assert_emails 1 do
      mail.deliver_now
    end

    assert_equal ['system@example.com'], mail.to
    assert_includes mail.body.to_s, check.public_id
  end
end
