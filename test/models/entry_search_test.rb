# frozen_string_literal: true

require 'test_helper'

class EntrySearchTest < ActiveSupport::TestCase
  test 'should initialize with keywords' do
    search = EntrySearch.new(unread: true, category_id: 1)

    assert_predicate search, :unread?
    assert_equal 1, search.category_id
  end

  test 'should filter unread entries' do
    unread_entry = create(:entry, read_at: nil)
    create(:entry, read_at: 1.hour.ago)

    search = EntrySearch.new(unread: true)

    result = search.apply(Entry)
    assert_equal 1, result.length
    assert_equal unread_entry, result.first
  end

  test 'should filter entries by category' do
    category = create(:category)
    entry = create(:entry, subscription: build(:subscription, category:))
    create(:entry, subscription: build(:subscription, category: create(:category)))

    search = EntrySearch.new(category_id: category.id)

    result = search.apply(Entry)
    assert_equal 1, result.length
    assert_equal entry, result.first
  end
end
