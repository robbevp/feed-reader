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
end
