# frozen_string_literal: true

require 'test_helper'

class EntryComponentTest < ViewComponent::TestCase
  test 'should render attributes' do
    entry = build(:entry, title: 'My blog post', author: 'Me')

    render_inline(EntryComponent.new(entry:))

    assert_selector '.entry'
    assert_selector '.entry__title', text: 'My blog post'
    assert_selector '.entry__author', text: 'Me'
  end

  test 'should remove tracking pixels when rendering' do
    body = '<div><img src="https://example.com/image.jpg" width="1" height="1" /></div>'
    entry = build(:entry, body:)

    render_inline(EntryComponent.new(entry:))

    assert_selector '.entry__content'
    assert_includes page.find('.entry__content')[:srcdoc], '<body><div></div></body>'
  end

  test 'should use summary if body is nil' do
    summary = '<div><img src="https://example.com/image.jpg" width="1" height="1" /></div>'
    entry = build(:entry, body: nil, summary:)

    render_inline(EntryComponent.new(entry:))

    assert_selector '.entry__content'
    assert_selector 'img', count: 0
  end

  test 'should keep image when not proxied' do
    body = '<div><img src="https://example.com/image.jpg"></div>'
    entry = build(:entry, body:)

    render_inline(EntryComponent.new(entry:))

    assert_selector '.entry__content'
    assert_includes page.find('.entry__content')[:srcdoc], '<body><div><img src="https://example.com/image.jpg"></div></body>'
  end

  test 'should replace image src when proxied' do
    body = '<div><img src="https://example.com/image.jpg"></div>'
    stub_request(:any, 'https://example.com/image.jpg')
      .to_return(body: Rails.root.join('test/fixtures/files/image.jpg').read)

    # Creating the entry will detect the image and proxy the image
    entry = perform_enqueued_jobs { create(:entry, body:) }

    render_inline(EntryComponent.new(entry:))

    assert_selector '.entry__content'

    regex = %r{<img src="/rails/active_storage/blobs/redirect/[A-z\d\=\-]+/image.jpg">}

    assert_match regex, page.find('.entry__content')[:srcdoc]
  end

  test 'should replace style element urls when proxied' do
    body = '<style>.class{background:url(https://example.com/image.jpg)}</style>'
    stub_request(:any, 'https://example.com/image.jpg')
      .to_return(body: Rails.root.join('test/fixtures/files/image.jpg').read)

    # Creating the entry will detect the image and proxy the image
    entry = perform_enqueued_jobs { create(:entry, body:) }

    render_inline(EntryComponent.new(entry:))

    assert_selector '.entry__content'

    regex = %r{<style>.class{background:url\(/rails/active_storage/blobs/redirect/[A-z\d\=\-]+/image.jpg\)}</style>}

    assert_match regex, page.find('.entry__content')[:srcdoc]
  end

  test 'should replace inline style urls when proxied' do
    body = '<div style="background:url(https://example.com/image.jpg)"></div>'
    stub_request(:any, 'https://example.com/image.jpg')
      .to_return(body: Rails.root.join('test/fixtures/files/image.jpg').read)

    # Creating the entry will detect the image and proxy the image
    entry = perform_enqueued_jobs { create(:entry, body:) }

    render_inline(EntryComponent.new(entry:))

    assert_selector '.entry__content'

    regex = %r{<div style="background:url\(/rails/active_storage/blobs/redirect/[A-z\d\=\-]+/image.jpg\)"></div>}

    assert_match regex, page.find('.entry__content')[:srcdoc]
  end

  test 'should inject `entry-body` stylesheet in head' do
    body = '<div></div>'
    entry = build(:entry, body:)

    render_inline(EntryComponent.new(entry:))

    assert_selector '.entry__content'
    regex = %r{<head>[\s\S]*<link rel="stylesheet" href="/vite-test/assets/entry-body-[\dA-z]+.css">[\s\S]*</head>}

    assert_match regex, page.find('.entry__content')[:srcdoc]
  end

  test 'should inject base with target in head' do
    body = '<div></div>'
    entry = build(:entry, body:)

    render_inline(EntryComponent.new(entry:))

    assert_selector '.entry__content'
    regex = %r{<head>[\s\S]*<base target="_parent">[\s\S]*</head>}

    assert_match regex, page.find('.entry__content')[:srcdoc]
  end
end
