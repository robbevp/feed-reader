# frozen_string_literal: true

# == Schema Information
#
# Table name: rss_feeds
#
#  id               :bigint           not null, primary key
#  error_count      :integer          default(0), not null
#  last_etag        :string
#  last_fetched_at  :datetime
#  last_modified_at :datetime
#  latest_error     :string
#  url              :text             not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require 'test_helper'

class RssFeedTest < ActiveSupport::TestCase
  # Validations
  test 'should not be valid without url' do
    feed = build(:rss_feed, url: nil)

    assert_not_predicate feed, :valid?
    assert_includes feed.errors['url'], "can't be blank"
  end

  # Refresh feed
  test 'should create entries when refreshing feed' do
    feed = create(:rss_feed)
    stub_request(:any, feed.url)
      .to_return(body: Rails.root.join('test/fixtures/files/example_feed.xml').read)

    assert_difference 'Entry.count' do
      feed.refresh!
    end

    assert_not_nil feed.last_fetched_at
  end

  test 'should ignore existing entries based on external id when refreshing feed' do
    feed = create(:rss_feed)
    stub_request(:any, feed.url)
      .to_return(body: Rails.root.join('test/fixtures/files/example_feed.xml').read)

    create(:entry, subscription: feed.subscription, external_id: 'urn:uuid:1225c695-cfb8-4ebb-aaaa-80da344efa6a')

    assert_no_difference 'Entry.count' do
      feed.refresh!
    end

    assert_not_nil feed.last_fetched_at
  end

  test 'should ignore existing entries based on url when refreshing feed' do
    feed = create(:rss_feed)
    stub_request(:any, feed.url)
      .to_return(body: Rails.root.join('test/fixtures/files/entry_without_id.xml').read)

    create(:entry, subscription: feed.subscription, url: 'http://example.org/2023/08/30/entry1')

    assert_no_difference 'Entry.count' do
      feed.refresh!
    end

    assert_not_nil feed.last_fetched_at
  end

  test 'should store cache information when refreshing feed' do
    feed = create(:rss_feed)
    stub_request(:any, feed.url)
      .to_return(body: Rails.root.join('test/fixtures/files/example_feed.xml').read,
                 headers: { ETag: 'some-string', 'Last-Modified': 'Mon, 21 sep 2024 21:48:00 GMT' })

    feed.refresh!

    assert_equal 'some-string', feed.reload.last_etag
    assert_equal '2024-09-21 21:48:00 UTC', feed.reload.last_modified_at.utc.to_s
  end

  test 'should not change entries when feed returns 304' do
    feed = create(:rss_feed)
    stub_request(:any, feed.url)
      .to_return(status: 304)

    assert_changes 'feed.reload.last_fetched_at' do
      feed.refresh!
    end
  end

  test 'should follow redirect when feed returns 301' do
    stub_request(:any, 'https://www.example.com')
      .to_return(status: 301, headers: { 'Location' => 'https://example.be' })
    stub_request(:any, 'https://example.be')
      .to_return(body: Rails.root.join('test/fixtures/files/example_feed.xml').read)

    feed = create(:rss_feed, url: 'https://www.example.com')

    assert_difference 'Entry.count' do
      feed.refresh!
    end

    assert_not_nil feed.last_fetched_at
  end

  test 'should follow redirect when feed returns 302' do
    stub_request(:any, 'https://www.example.com')
      .to_return(status: 302, headers: { 'Location' => 'https://example.be' })
    stub_request(:any, 'https://example.be')
      .to_return(body: Rails.root.join('test/fixtures/files/example_feed.xml').read)

    feed = create(:rss_feed, url: 'https://www.example.com')

    assert_difference 'Entry.count' do
      feed.refresh!
    end

    assert_not_nil feed.last_fetched_at
  end

  test 'should follow redirect when feed returns path-only redirect' do
    stub_request(:any, 'https://www.example.com/rss.xml')
      .to_return(status: 302, headers: { 'Location' => '/feed.atom' })
    stub_request(:any, 'https://www.example.com/feed.atom')
      .to_return(body: Rails.root.join('test/fixtures/files/example_feed.xml').read)

    feed = create(:rss_feed, url: 'https://www.example.com/rss.xml')

    assert_difference 'Entry.count' do
      feed.refresh!
    end

    assert_not_nil feed.last_fetched_at
  end

  test 'should save error if feed redirects more than 5 times' do
    stub_request(:any, 'https://example.com').to_return(status: 302, headers: { 'Location' => 'https://example.be' })
    stub_request(:any, 'https://example.be').to_return(status: 302, headers: { 'Location' => 'https://example.fr' })
    stub_request(:any, 'https://example.fr').to_return(status: 302, headers: { 'Location' => 'https://example.de' })
    stub_request(:any, 'https://example.de').to_return(status: 302, headers: { 'Location' => 'https://example.no' })
    stub_request(:any, 'https://example.no').to_return(status: 302, headers: { 'Location' => 'https://example.fi' })
    stub_request(:any, 'https://example.fi').to_return(status: 302, headers: { 'Location' => 'https://example.dk' })

    feed = create(:rss_feed, url: 'https://example.com')

    feed.refresh!

    assert_predicate feed, :any_error?
    assert_predicate feed.latest_error, :present?
    assert_nil feed.last_fetched_at
  end

  test 'should save error if feed returns error' do
    stub_request(:any, 'https://example.com').to_return(status: 403)

    feed = create(:rss_feed, url: 'https://example.com')

    feed.refresh!

    assert_predicate feed, :any_error?
    assert_predicate feed.latest_error, :present?
    assert_nil feed.last_fetched_at
  end
end
