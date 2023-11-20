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
    return if summary.blank?

    text = RichText.new(text: summary)
    text.handle_img_urls { |url| find_proxy_blob_for_url(url) }
    text.to_html
  end

  def transformed_body
    text = RichText.new(text: body)
    text.handle_img_urls { |url| find_proxy_blob_for_url(url) }
    text.add_to_head(helpers.vite_stylesheet_tag('entry-body.css'))
    text.to_html
  end

  delegate :title, :author, :published_at, :summary, :body, :url, to: :entry

  private

  def find_proxy_blob_for_url(url)
    proxy = proxied_images.find { |p| p.url == entry.normalize_url(url) }
    return url unless proxy.present? && proxy.image.attached?

    helpers.rails_blob_path(proxy.image)
  end

  def proxied_images
    @proxied_images ||= entry.proxied_images.includes(image_attachment: :blob)
  end
end
