# frozen_string_literal: true

require 'test_helper'

class NewsletterMailboxTest < ActionMailbox::TestCase
  setup do
    @newsletter = create(:newsletter)
  end

  test 'should create entry when receiving mail' do
    assert_difference 'Entry.count' do
      receive_inbound_email_from_mail do |mail|
        mail.to "newsletter-#{@newsletter.id}+#{@newsletter.public_id}@example.com"
        mail.from '"me" <me@example.com>'
        mail.subject 'Hello world!'
        mail.body 'Hello?'
      end
    end

    assert_equal 'me <me@example.com>', Entry.last.author
    assert_equal 'Hello world!', Entry.last.title
  end

  test 'should use html part when available' do
    assert_difference 'Entry.count' do
      receive_inbound_email_from_mail do |mail|
        mail.to "newsletter-#{@newsletter.id}+#{@newsletter.public_id}@example.com"
        mail.from '"me" <me@example.com>'
        mail.subject 'Hello world!'
        mail.text_part do |part|
          part.body 'Is there anybody out there?'
        end

        mail.html_part do |part|
          part.body '<h1>Is there anybody out there?</h1>'
        end
      end
    end

    assert_equal 'me <me@example.com>', Entry.last.author
    assert_equal '<h1>Is there anybody out there?</h1>', Entry.last.body
  end

  test 'should find newsletter from all recipients' do
    assert_difference 'Entry.count' do
      receive_inbound_email_from_mail do |mail|
        mail.to 'hello@example.com'
        mail.cc = "newsletter-#{@newsletter.id}+#{@newsletter.public_id}@example.com"
        mail.from '"me" <me@example.com>'
        mail.subject 'Hello world!'
        mail.body 'Hello?'
      end
    end

    assert_equal 'me <me@example.com>', Entry.last.author
    assert_equal 'Hello world!', Entry.last.title
  end

  test 'should bounce email when public id is mismatched' do
    assert_no_difference 'Entry.count' do
      receive_inbound_email_from_mail do |mail|
        mail.to "newsletter-#{@newsletter.id}+abc@example.com"
        mail.from '"me" <me@example.com>'
        mail.subject 'Hello world!'
        mail.body 'Hello?'
      end
    end

    assert_equal 'bounced', ActionMailbox::InboundEmail.last.status
  end

  test 'should bounce email when id does not exist' do
    assert_no_difference 'Entry.count' do
      receive_inbound_email_from_mail do |mail|
        mail.to "newsletter-#{@newsletter.id + 1}+#{@newsletter.public_id}@example.com"
        mail.from '"me" <me@example.com>'
        mail.subject 'Hello world!'
        mail.body 'Hello?'
      end
    end

    assert_equal 'bounced', ActionMailbox::InboundEmail.last.status
  end
end
