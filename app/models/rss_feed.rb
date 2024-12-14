# frozen_string_literal: true

# == Schema Information
#
# Table name: rss_feeds
#
#  id               :bigint           not null, primary key
#  last_etag        :string
#  last_fetched_at  :datetime
#  last_modified_at :datetime
#  url              :text             not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class RssFeed < ApplicationRecord
  has_one :subscription, as: :subscribable, dependent: :destroy
  has_many :entries, through: :subscription

  validates :url, presence: true

  after_create_commit -> { RefreshRssFeedJob.perform_later(self) }

  def refresh!
    fetch_feed!

    self.last_fetched_at = DateTime.current
    save!
  end

  delegate :user, to: :subscription

  private

  def handle_response(response)
    # We set the values from the headers here, but save them at the end of `refresh!`
    self.last_etag = response['etag']
    self.last_modified_at = response['last-modified']

    Feedjira.parse(response.body).entries.each do |entry|
      next if entries.any? { |e| e.same?(entry) }

      subscription.entries.push Entry.from_feedjira_entry(entry)
    end
  end

  def fetch_feed!
    uri = URI(url)
    limit = 5
    while limit >= 0
      http = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.is_a?(URI::HTTPS))
      response = http.get(uri, headers)
      case response
      when Net::HTTPSuccess
        return handle_response(response)
      when Net::HTTPNotModified
        # If the feed was not modified, we can simply stop
        return
      when Net::HTTPRedirection, Net::HTTPMovedPermanently
        limit -= 1
        # We follow the redirect and merge the current and new URI
        # this way, redirects that only contain a path get handled correctly.
        uri = uri.merge(URI(response['Location']))
      else
        response.error!
      end
    end
    raise TooManyRedirectsError, 'More than 5 redirects in a row. Aborting request.'
  end

  def headers
    {
      # If-Modified-Since expects a value of `Wed, 21 Oct 2015 07:28:00 GMT`, see [MDN](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/If-Modified-Since#syntax)
      'If-Modified-Since': last_modified_at&.utc&.strftime('%a, %d %b %Y %T GMT'),
      'If-None-Match': last_etag
    }.compact
  end
end
