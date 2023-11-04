# frozen_string_literal: true

class DetectEntryImagesJob < ApplicationJob
  queue_as :default

  attr_reader :entry

  def perform(entry)
    %i[body summary].each do |method|
      text = entry.send(method)
      next if text.blank?

      RichText.new(text:).handle_img_urls do |url|
        begin
          # Skip if url is inline data
          next if url.nil? || url.match?(%r{data:[a-z]+/[a-z]+;base64})

          ProxiedImage.create!(url:, entry:)
        rescue ActiveRecord::RecordNotUnique
          # If the record is not unique, we simply ignore this and continue
        end

        # Return url, so the document stays the same
        url
      end
    end
  end
end
