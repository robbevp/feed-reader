# frozen_string_literal: true

class RichText
  STYLE_URL_REGEXP = /url\((http[^\)]+)\)/i

  attr_accessor :doc

  def initialize(text:)
    @doc = Nokogiri::HTML5.parse(text)

    # Iterate over all images and unlink tracking pixels
    css('img[src]').each do |node|
      node.unlink if TrackingDetection.tracking_pixel?(node)
    end
  end

  # Iterate over all urls in the document
  # If the block returns a new url, the element gets replaced
  def handle_img_urls(&)
    css('img[src]').each do |node|
      node.set_attribute('src', yield(node['src']))
    end
    css('style:contains("url")').each do |node|
      node.content = urls_in_styles(node.text, &)
    end
    css('[style*="url"]').each do |node|
      node.set_attribute('style', urls_in_styles(node['style'], &))
    end
  end

  def add_to_head(node_or_string)
    at_css('head').add_child(node_or_string)
  end

  delegate :to_html, :css, :at_css, to: :doc

  private

  def urls_in_styles(text)
    text.scan(STYLE_URL_REGEXP).flatten.each { |url| text.gsub!(url, yield(url)) }
    text
  end
end
