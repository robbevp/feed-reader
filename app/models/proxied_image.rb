# frozen_string_literal: true

class ProxiedImage < ApplicationRecord
  belongs_to :entry, inverse_of: :proxied_images

  has_one_attached :image

  validates :url, presence: true

  after_create_commit -> { FetchProxiedImageJob.perform_later(self) }

  def process
    Tempfile.create(encoding: 'ascii-8bit') do |file|
      file.write fetch_image
      filename = normalized_uri.path.split('/').last.split('.').first
      content_type = Marcel::MimeType.for(file)
      ext = Marcel::Magic.new(content_type).extensions.first
      image.attach(io: file, filename: "#{filename}.#{ext}", content_type:)
    end
  end

  private

  def fetch_image
    uri = normalized_uri
    limit = 5
    while limit >= 0
      http = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.is_a?(URI::HTTPS))
      response = http.get(uri)
      case response
      when Net::HTTPSuccess
        return response.body
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

  def normalized_uri
    # Some urls might contain spaces, so we replace these
    uri = URI(url.gsub(' ', '%20'))
    # Some entries might contain absolute/relative path to the page they were on
    uri = URI(entry.url).merge(uri) if entry.url.present?
    uri
  end
end
