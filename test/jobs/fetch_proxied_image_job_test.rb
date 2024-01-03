# frozen_string_literal: true

require 'test_helper'

class FetchProxiedImageJobTest < ActiveJob::TestCase
  setup do
    @image = create(:proxied_image, url: 'https://example.com/image.jpg')
    stub_request(:any, 'https://example.com/image.jpg')
      .to_return(body: Rails.root.join('test/fixtures/files/image.jpg').read)
  end

  test 'should schedule job for each feed' do
    assert_difference ['ActiveStorage::Attachment.count', 'ActiveStorage::Blob.count'] do
      FetchProxiedImageJob.perform_now(@image)
    end

    assert_predicate @image.reload.image, :attached?
  end

  test 'should discard images that return 404' do
    stub_request(:any, 'https://example.com/image.jpg')
      .to_return(status: [404, 'Image not found'])

    assert_no_difference ['ActiveStorage::Attachment.count', 'ActiveStorage::Blob.count'] do
      FetchProxiedImageJob.perform_now(@image)
    end

    assert_not_predicate @image.reload.image, :attached?
  end
end
