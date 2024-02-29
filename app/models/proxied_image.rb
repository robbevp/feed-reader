# frozen_string_literal: true

class ProxiedImage < ApplicationRecord
  has_and_belongs_to_many :entries

  has_one_attached :image

  validates :url, presence: true

  after_create_commit -> { FetchProxiedImageJob.perform_later(self) }

  def process
    Tempfile.create(encoding: 'ascii-8bit') do |file|
      file.write fetch_image
      filename = URI(url).path.split('/').last&.split('.')&.first || 'proxied-image'
      content_type = Marcel::MimeType.for(file)
      ext = Marcel::Magic.new(content_type).extensions.first
      image.attach(io: file, filename: "#{filename}.#{ext}", content_type:)
    end
  end

  private

  def fetch_image
    uri = URI(url)
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
end
