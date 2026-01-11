# frozen_string_literal: true

require 'test_helper'

class SystemMailboxTest < ActionMailbox::TestCase
  test 'should find and destroy check from mail content' do
    check = create(:ingress_check)
    mail = SystemMailer.ingress_check(check)

    assert_changes 'check.reload.received_at' do
      receive_inbound_email_from_source mail.to_s
    end
  end

  test 'should ignore mail with invalid content' do
    check = create(:ingress_check)
    mail = SystemMailer.ingress_check(check)
    mail.body = <<~BODY
      This body does not contain an ID as we expect
      #{check.public_id}
    BODY

    assert_no_changes 'check.reload.received_at' do
      receive_inbound_email_from_source mail.to_s
    end
  end

  test 'should ignore mail if check was already received' do
    check = create(:ingress_check)
    mail = SystemMailer.ingress_check(check)
    check.update!(received_at: 1.day.ago)

    assert_no_changes 'check.reload.received_at' do
      receive_inbound_email_from_source mail.to_s
    end
  end
end
