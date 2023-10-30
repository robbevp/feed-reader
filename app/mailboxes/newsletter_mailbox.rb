# frozen_string_literal: true

class NewsletterMailbox < ApplicationMailbox
  MAIL_KEYS = %w[to from multipart date subject message_id].freeze

  before_processing :set_newsletter

  def process
    data = MAIL_KEYS.index_with { |key| mail[key].to_s }
    data['body'] = mail_body

    Entry.create!(subscription: @newsletter.subscription, title: data['subject'], author: data['from'],
                  published_at: data['date'], body: data['body'], external_id: data['message_id'], data:)
  end

  private

  def set_newsletter
    # Look in direct recipients and find the first on that matches
    recipients.each do |recipient|
      match_data = recipient.match(/newsletter-(\d+)\+(\h+)@/)
      if match_data.present?
        @newsletter = Newsletter.find_by(id: match_data[1], public_id: match_data[2])
        break
      end
    end

    # Mark as bounced if no email matched
    bounced! if @newsletter.blank?
  end

  def mail_body
    if mail.html_part
      mail.html_part.decoded
    elsif mail.text_part
      mail.text_part.decoded
    else
      mail.decoded
    end
  end

  def recipients
    arr = [*mail.recipients]
    # Look in the received header, since some forwards don't modify recipients
    received = mail.received&.first&.decoded&.match(/<([a-z@\d\.\-\+]+)>/i)
    arr.push(received[1]) if received.present?
    arr
  end
end
