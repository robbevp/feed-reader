# frozen_string_literal: true

class RichText
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
  end

  delegate :to_html, :css, to: :doc

end
