# frozen_string_literal: true

require 'test_helper'

class ProxiedImageTest < ActiveSupport::TestCase
  # Validations
  test 'should not be valid without a url' do
    image = build(:proxied_image, url: nil)

    assert_not_predicate image, :valid?
    assert_includes image.errors['url'], "can't be blank"
  end

  test 'should not save in database with an url that is not unique' do
    stub_request(:any, 'http://example.com/image.jpg')
      .to_return(body: Rails.root.join('test/fixtures/files/image.jpg').read)

    create(:proxied_image, url: 'http://example.com/image.jpg')

    assert_raises ActiveRecord::RecordNotUnique do
      # rubocop:disable Rails/SkipsModelValidations
      # We intentionally skip model validations to test the database constraint
      ProxiedImage.insert!(attributes_for(:proxied_image, url: 'http://example.com/image.jpg'))
      # rubocop:enable Rails/SkipsModelValidations
    end
  end

  # Method
  test 'should attach image during process' do
    proxy = build(:proxied_image, url: 'https://example.com/image.jpg')
    stub_request(:any, 'https://example.com/image.jpg')
      .to_return(body: Rails.root.join('test/fixtures/files/image.jpg').read)

    assert_difference ['ActiveStorage::Attachment.count', 'ActiveStorage::Blob.count'] do
      # Automatically calls `.process` in `after_create_commit` callback
      proxy.save!
    end

    assert_predicate proxy.image, :attached?
  end

  test 'should attach image without content type based on response' do
    proxy = build(:proxied_image, url: 'https://example.com/image.png')
    stub_request(:any, 'https://example.com/image.png')
      .to_return(body: Rails.root.join('test/fixtures/files/image.jpg').read)

    assert_difference ['ActiveStorage::Attachment.count', 'ActiveStorage::Blob.count'] do
      # Automatically calls `.process` in `after_create_commit` callback
      proxy.save!
    end

    assert_equal 'image/jpeg', proxy.image.content_type
    assert_equal 'image.jpg', proxy.image.filename.to_s
  end

  test 'should follow redirect when url returns 301' do
    proxy = build(:proxied_image, url: 'https://example.com/image.jpg')

    stub_request(:any, 'https://example.com/image.jpg')
      .to_return(status: 301, headers: { 'Location' => 'https://example.be/image.jpg' })
    stub_request(:any, 'https://example.be/image.jpg')
      .to_return(body: Rails.root.join('test/fixtures/files/image.jpg').read)

    assert_difference ['ActiveStorage::Attachment.count', 'ActiveStorage::Blob.count'] do
      # Automatically calls `.process` in `after_create_commit` callback
      proxy.save!
    end

    assert_predicate proxy.image, :attached?
  end

  test 'should follow redirect when url returns 302' do
    proxy = build(:proxied_image, url: 'https://example.com/image.jpg')

    stub_request(:any, 'https://example.com/image.jpg')
      .to_return(status: 302, headers: { 'Location' => 'https://example.be/image.jpg' })
    stub_request(:any, 'https://example.be/image.jpg')
      .to_return(body: Rails.root.join('test/fixtures/files/image.jpg').read)

    assert_difference ['ActiveStorage::Attachment.count', 'ActiveStorage::Blob.count'] do
      # Automatically calls `.process` in `after_create_commit` callback
      proxy.save!
    end

    assert_predicate proxy.image, :attached?
  end

  test 'should follow redirect when url returns path-only redirect' do
    proxy = build(:proxied_image, url: 'https://example.com/image.jpg')

    stub_request(:any, 'https://example.com/image.jpg')
      .to_return(status: 302, headers: { 'Location' => '/image.png' })
    stub_request(:any, 'https://example.com/image.png')
      .to_return(body: Rails.root.join('test/fixtures/files/image.jpg').read)

    assert_difference ['ActiveStorage::Attachment.count', 'ActiveStorage::Blob.count'] do
      # Automatically calls `.process` in `after_create_commit` callback
      proxy.save!
    end

    assert_predicate proxy.image, :attached?
  end

  test 'should raise error if url redirects more than 5 times' do
    proxy = build(:proxied_image, url: 'https://example.com/image.jpg')

    stub_request(:any, 'https://example.com/image.jpg').to_return(status: 302,
                                                                  headers: { 'Location' => 'https://example.be' })
    stub_request(:any, 'https://example.be').to_return(status: 302, headers: { 'Location' => 'https://example.fr' })
    stub_request(:any, 'https://example.fr').to_return(status: 302, headers: { 'Location' => 'https://example.de' })
    stub_request(:any, 'https://example.de').to_return(status: 302, headers: { 'Location' => 'https://example.no' })
    stub_request(:any, 'https://example.no').to_return(status: 302, headers: { 'Location' => 'https://example.fi' })
    stub_request(:any, 'https://example.fi').to_return(status: 302, headers: { 'Location' => 'https://example.dk' })

    assert_raises TooManyRedirectsError do
      # Automatically calls `.process` in `after_create_commit` callback
      proxy.save!
    end

    assert_not_predicate proxy.image, :attached?
  end

  test 'should raise error if url returns error' do
    stub_request(:any, 'https://example.com/image.jpg').to_return(status: 500)

    proxy = build(:proxied_image, url: 'https://example.com/image.jpg')

    assert_raises Net::HTTPFatalError do
      # Automatically calls `.process` in `after_create_commit` callback
      proxy.save!
    end

    assert_not_predicate proxy.image, :attached?
  end
end
