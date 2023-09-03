# frozen_string_literal: true

class Feed < ApplicationRecord
  belongs_to :user, inverse_of: :feeds
  has_many :entries, dependent: :destroy

  validates :name, presence: true
  validates :url, presence: true, uniqueness: { scope: :user }

  def refresh!
    fetch_feed.entries.each do |entry|
      next if entries.any? { |e| e.same?(entry) }

      entries.push Entry.from_feedjira_entry(entry)
    end

    self[:last_fetched_at] = DateTime.current
    save!
  end

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
