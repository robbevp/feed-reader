# frozen_string_literal: true

class FetchProxiedImageJob < ApplicationJob
  queue_as :default

  # Retry when we can't open a TCP connection
  retry_on Errno::EBUSY, wait: :polynomially_longer, attempts: 10

  # Ignore any resource that return a 404 error
  discard_on ImageNotFoundError

  def perform(proxied_image)
    proxied_image.process
  end
end
