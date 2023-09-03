# frozen_string_literal: true

require 'test_helper'

class FeedTest < ActiveSupport::TestCase
  # Validations
  test 'should not be valid without name' do
    feed = build(:feed, name: nil)

    assert_not_predicate feed, :valid?
    assert_includes feed.errors['name'], "can't be blank"
  end

  test 'should not be valid without url' do
    feed = build(:feed, url: nil)

    assert_not_predicate feed, :valid?
    assert_includes feed.errors['url'], "can't be blank"
  end

  test 'should not be valid if url is not unique for user' do
    user = create(:user)
    create(:feed, url: 'https://example.org', user:)

    feed = build(:feed, url: 'https://example.org', user:)

    assert_not_predicate feed, :valid?
    assert_includes feed.errors['url'], 'has already been taken'
  end

  test 'should not save in database with a url that is not unique for user' do
    user = create(:user)
    create(:feed, url: 'https://example.org', user:)

    assert_raises ActiveRecord::RecordNotUnique do
      # rubocop:disable Rails/SkipsModelValidations
      # We intentionally skip model validations to test the database constraint
      Feed.insert!(attributes_for(:feed, url: 'https://example.org', user_id: user.id))
      # rubocop:enable Rails/SkipsModelValidations
    end
  end

  # Refresh feed
  test 'should create entries when refreshing feed' do
    feed = create(:feed)
    stub_request(:any, feed.url)
      .to_return(body: Rails.root.join('test/fixtures/files/example_feed.xml').read)

    assert_difference 'Entry.count' do
      feed.refresh!
    end

    assert_not_nil feed.last_fetched_at
  end

  test 'should ignore existing entries based on external id when refreshing feed' do
    feed = create(:feed)
    create(:entry, feed:, external_id: 'urn:uuid:1225c695-cfb8-4ebb-aaaa-80da344efa6a')
    stub_request(:any, feed.url)
      .to_return(body: Rails.root.join('test/fixtures/files/example_feed.xml').read)

    assert_no_difference 'Entry.count' do
      feed.refresh!
    end

    assert_not_nil feed.last_fetched_at
  end

  test 'should ignore existing entries based on url when refreshing feed' do
    feed = create(:feed)
    create(:entry, feed:, url: 'http://example.org/2023/08/30/entry1')
    stub_request(:any, feed.url)
      .to_return(body: Rails.root.join('test/fixtures/files/entry_without_id.xml').read)

    assert_no_difference 'Entry.count' do
      feed.refresh!
    end

    assert_not_nil feed.last_fetched_at
  end

  test 'should follow redirect when feed returns 301' do
    stub_request(:any, 'https://www.example.com')
      .to_return(status: 301, headers: { 'Location' => 'https://example.be' })
    stub_request(:any, 'https://example.be')
      .to_return(body: Rails.root.join('test/fixtures/files/example_feed.xml').read)

    feed = create(:feed, url: 'https://www.example.com')

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

    feed = create(:feed, url: 'https://www.example.com')

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

    feed = create(:feed, url: 'https://www.example.com/rss.xml')

    assert_difference 'Entry.count' do
      feed.refresh!
    end

    assert_not_nil feed.last_fetched_at
  end

  test 'should raise error if feed redirects more than 5 times' do
    stub_request(:any, 'https://example.com').to_return(status: 302, headers: { 'Location' => 'https://example.be' })
    stub_request(:any, 'https://example.be').to_return(status: 302, headers: { 'Location' => 'https://example.fr' })
    stub_request(:any, 'https://example.fr').to_return(status: 302, headers: { 'Location' => 'https://example.de' })
    stub_request(:any, 'https://example.de').to_return(status: 302, headers: { 'Location' => 'https://example.no' })
    stub_request(:any, 'https://example.no').to_return(status: 302, headers: { 'Location' => 'https://example.fi' })
    stub_request(:any, 'https://example.fi').to_return(status: 302, headers: { 'Location' => 'https://example.dk' })

    feed = create(:feed, url: 'https://example.com')

    assert_raises TooManyRedirectsError do
      feed.refresh!
    end

    assert_nil feed.last_fetched_at
  end

  test 'should raise error if feed returns error' do
    stub_request(:any, 'https://example.com').to_return(status: 500)

    feed = create(:feed, url: 'https://example.com')

    assert_raises Net::HTTPFatalError do
      feed.refresh!
    end

    assert_nil feed.last_fetched_at
  end
end
