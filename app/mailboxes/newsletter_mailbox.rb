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
    match_data = mail.to.first.match(/newsletter-(\d+)\+(\h+)@/)
    @newsletter = Newsletter.find_by(id: match_data[1], public_id: match_data[2])
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
end
