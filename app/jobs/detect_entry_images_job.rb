# frozen_string_literal: true

class DetectEntryImagesJob < ApplicationJob
  queue_as :default

  def perform(entry)
    process(entry, :body) if entry.body.present?
    process(entry, :summary) if entry.summary.present?
  end

  private

  def process(entry, method)
    doc = Nokogiri.parse(entry.send(method))
    doc.css('img').each do |node|
      next if TrackingDetection.tracking_pixel?(node) || !node.key?('src')

      url = node.attribute('src').value
      # Skip if url is inline data
      next if url.match?(%r{data:[a-z]+/[a-z]+;base64})

      ProxiedImage.create!(url:, entry:)
    rescue ActiveRecord::RecordNotUnique
      # If the record is not unique, we simply ignore this and continue
      next
    end
  end
end
