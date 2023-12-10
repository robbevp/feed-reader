# frozen_string_literal: true

require 'test_helper'

class DetectEntryImagesJobTest < ActiveJob::TestCase
  test 'should do nothing if body and summary are empty' do
    entry = create(:entry, body: nil, summary: nil)

    assert_no_difference 'ProxiedImage.count' do
      DetectEntryImagesJob.perform_now(entry)
    end
  end

  test 'should create proxied image for img element with source' do
    body = '<div><img src="https://example.com/image.jpg" /></div>'
    entry = create(:entry, body:)

    assert_difference 'ProxiedImage.count' do
      DetectEntryImagesJob.perform_now(entry)
    end
  end

  test 'should create proxied image for img element with srcset' do
    body = '<div><img srcset="https://example.com/image.jpg, https://example.com/image-2.jpg x2" /></div>'
    entry = create(:entry, body:)

    assert_difference 'ProxiedImage.count', 2 do
      DetectEntryImagesJob.perform_now(entry)
    end
  end

  test 'should create proxied image for style elements with url' do
    body = '<style>.class{background:url(https://example.com/image.jpg)}</style>'
    entry = create(:entry, body:)

    assert_difference 'ProxiedImage.count' do
      DetectEntryImagesJob.perform_now(entry)
    end
  end

  test 'should create proxied image for inline styles with url' do
    body = '<div style="background:url(https://example.com/image.jpg)"></div>'
    entry = create(:entry, body:)

    assert_difference 'ProxiedImage.count' do
      DetectEntryImagesJob.perform_now(entry)
    end
  end

  test 'should ignore existing proxied images' do
    body = '<div><img src="https://example.com/image.jpg" /></div>'
    entry = create(:entry, body:)
    create(:proxied_image, url: 'https://example.com/image.jpg')

    assert_difference 'ProxiedImage.first.entries.count' do
      DetectEntryImagesJob.perform_now(entry)
    end
  end

  test 'should ignore images that are tracking pixels' do
    body = '<div><img src="https://example.com/image.jpg" width="1" height="1" /></div>'
    entry = create(:entry, body:)

    assert_no_difference 'ProxiedImage.count' do
      DetectEntryImagesJob.perform_now(entry)
    end
  end

  test 'should ignore images that have inline data' do
    body = '<div><img src="data:image/jpeg;base64,some_image" /></div>'
    entry = create(:entry, body:)

    assert_no_difference 'ProxiedImage.count' do
      DetectEntryImagesJob.perform_now(entry)
    end
  end
end
