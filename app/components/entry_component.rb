# frozen_string_literal: true

class EntryComponent < ViewComponent::Base
  attr_reader :entry

  def initialize(entry:)
    super
    @entry = entry
  end

  def body?
    body&.length&.positive?
  end

  def transformed_summary
    return if entry.summary.blank?

    doc = Nokogiri::HTML5.parse(entry.summary)
    replace_images(doc).to_html.strip
  end

  def transformed_body
    doc = Nokogiri::HTML5.parse(entry.body)
    replace_images(doc).to_html.strip
  end

  delegate :title, :author, :published_at, :summary, :body, :url, to: :entry

  private

  def replace_images(doc)
    doc.css('img').each do |node|
      node.unlink if TrackingDetection.tracking_pixel?(node)

      proxy = find_proxied_image(node)
      next unless proxy.present? && proxy.image.attached?

      node.set_attribute('src', helpers.rails_blob_path(proxy.image))
    end
    doc
  end

  def find_proxied_image(node)
    proxied_images.find { |p| p.url == node.attribute('src')&.value }
  end

  def proxied_images
    @proxied_images ||= entry.proxied_images.includes(image_attachment: :blob)
  end
end
