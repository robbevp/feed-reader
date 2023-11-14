# frozen_string_literal: true

class FetchProxiedImageJob < ApplicationJob
  queue_as :default

  # Retry when we can't open a TCP connection
  retry_on Errno::EBUSY, wait: :polynomially_longer, attempts: 10

  def perform(proxied_image)
    proxied_image.process
  end
end
