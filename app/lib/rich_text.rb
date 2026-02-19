# frozen_string_literal: true

class RichText
  STYLE_URL_REGEXP = /url\((http[^)]+)\)/i

  attr_accessor :doc

  def initialize(text:)
    @doc = Nokogiri::HTML5.parse(text)

    # Iterate over all images and unlink tracking pixels
    css('img[src]').each do |node|
      node.unlink if TrackingDetection.tracking_pixel?(node)

      # Don't send referrer when requesting images
      node.set_attribute('referrerpolicy', 'no-referrer')
    end
  end

  # Iterate over all urls in the document
  # If the block returns a new url, the element gets replaced
  def handle_img_urls(&) # rubocop:disable Metrics/AbcSize
    css('img[src]').each do |node|
      node.set_attribute('src', yield(node['src']))
    end
    css('img[srcset],picture source[srcset]').each do |node|
      node.set_attribute('srcset', urls_in_srcset(node['srcset'], &))
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

  # Swap youtube embeds with youtube-nocookie
  def swap_youtube_embeds
    css('iframe[src*="youtube.com/embed"]').each do |node|
      node.set_attribute('src', node['src'].gsub('youtube.com', 'youtube-nocookie.com'))
    end
  end

  delegate :to_html, :css, :at_css, to: :doc

  private

  def urls_in_srcset(srcset)
    # srcset is tricky to parse, since the url might contain commas and the descriptor is optional
    # Since we only care about the urls, we just try to find the first string after each comma
    # See https://html.spec.whatwg.org/multipage/images.html#parsing-a-srcset-attribute
    skip_until_comma = false
    copy = srcset.strip # We need to make a copy, since we can't scan and modify at the same time
    copy.scan(/[^\s]+/) do |match|
      if match[0] == ','
        skip_until_comma = false
        match = match[1..]
      end

      if skip_until_comma
        skip_until_comma = match[-1] != ','
        next
      end

      skip_until_comma = match[-1] != ','
      match = match[...-1] unless skip_until_comma
      srcset.gsub!(match, yield(match))
    end
    srcset
  end

  def urls_in_styles(text)
    text.scan(STYLE_URL_REGEXP).flatten.each { |url| text.gsub!(url, yield(url)) }
    text
  end
end
