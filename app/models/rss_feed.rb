# frozen_string_literal: true

class RssFeed < ApplicationRecord
  has_one :subscription, as: :subscribable, dependent: :destroy
  has_many :entries, through: :subscription

  validates :url, presence: true

  after_create_commit -> { RefreshRssFeedJob.perform_later(self) }

  def refresh!
    fetch_feed.entries.each do |entry|
      next if entries.any? { |e| e.same?(entry) }

      subscription.entries.push Entry.from_feedjira_entry(entry)
    end

    self[:last_fetched_at] = DateTime.current
    save!
  end

  delegate :user, to: :subscription

  private

  def fetch_feed
    uri = URI(url)
    limit = 5
    while limit >= 0
      http = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.is_a?(URI::HTTPS))
      response = http.get(uri)
      case response
      when Net::HTTPSuccess
        return Feedjira.parse(response.body)
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
end
