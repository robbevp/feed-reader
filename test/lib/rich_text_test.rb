# frozen_string_literal: true

require 'test_helper'

class RichTextTest < ActiveSupport::TestCase
  # Handle_img_urls
  test 'should detect url is srcset' do
    text = RichText.new(
      text: '<div><img srcset="https://example.com/image.jpg, https://example.com/image-2.jpg x2" /></div>'
    )

    result = []
    text.handle_img_urls do |url|
      result.push(url)
      url
    end

    assert_equal 2, result.length
    assert_equal 'https://example.com/image.jpg', result.first
    assert_equal 'https://example.com/image-2.jpg', result.second
  end

  test 'should handle commas in srcset urls' do
    text = RichText.new(
      text: '<div><img srcset="https://example.com/image.jpg?a=b,21, https://example.com/image,2.jpg x2" /></div>'
    )

    result = []
    text.handle_img_urls do |url|
      result.push(url)
      url
    end

    assert_equal 2, result.length
    assert_equal 'https://example.com/image.jpg?a=b,21', result.first
    assert_equal 'https://example.com/image,2.jpg', result.second
  end

  test 'should handle weird whitespace in srcset urls' do
    text = RichText.new(
      text: '<div><img srcset=" https://example.com/image.jpg  ,https://example.com/image-2.jpg (x1 x2) " /></div>'
    )

    result = []
    text.handle_img_urls do |url|
      result.push(url)
      url
    end

    assert_equal 2, result.length
    assert_equal 'https://example.com/image.jpg', result.first
    assert_equal 'https://example.com/image-2.jpg', result.second
  end

  # Apply youtube no cookie
  test 'should switch youtube embeds to youtube-nocookie' do
    text = RichText.new(
      text: '<div><iframe src="https://www.youtube.com/embed/djV11Xbc914"></iframe></div>'
    )

    text.swap_youtube_embeds

    assert_includes text.to_html, '<iframe src="https://www.youtube-nocookie.com/embed/djV11Xbc914">'
    assert_not_includes text.to_html, '<iframe src="https://www.youtube.com/embed/djV11Xbc914">'
  end
end
