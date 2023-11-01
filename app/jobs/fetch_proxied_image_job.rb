# frozen_string_literal: true

class FetchProxiedImageJob < ApplicationJob
  queue_as :default

  def perform(proxied_image)
    proxied_image.process
  end
end
