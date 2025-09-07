# frozen_string_literal: true

class FetchProxiedImageJob < ApplicationJob
  queue_as :default

  # Retry when we can't open a connection or get a server error
  retry_on Errno::EBUSY, Net::HTTPFatalError, Socket::ResolutionError, Net::OpenTimeout, Net::ReadTimeout,
           OpenSSL::SSL::SSLError,
           wait: :polynomially_longer, attempts: 10

  # Ignore any client errors, as we can't fix these issues
  discard_on Net::HTTPClientException

  def perform(proxied_image)
    proxied_image.process
  end
end
