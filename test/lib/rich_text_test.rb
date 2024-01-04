# frozen_string_literal: true

require 'test_helper'

class RichTextTest < ActiveSupport::TestCase
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
end
