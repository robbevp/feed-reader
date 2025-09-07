# frozen_string_literal: true

require 'test_helper'

class EntrySearchTest < ActiveSupport::TestCase
  test 'should initialize with keywords' do
    search = EntrySearch.new(include_read: true, category_id: 1)

    assert_predicate search, :include_read?
    assert_equal 1, search.category_id
  end

  test 'should filter unread entries' do
    unread_entry = create(:entry, read_at: nil)
    create(:entry, read_at: 1.hour.ago)

    search = EntrySearch.new(include_read: false)

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

  test 'should get next and previous entry' do
    previous = create(:entry, published_at: DateTime.current)
    current = create(:entry, published_at: 2.minutes.ago)
    next_entry = create(:entry, published_at: 4.minutes.ago)

    search = EntrySearch.new

    assert_equal previous, search.previous(Entry, current)
    assert_equal next_entry, search.next(Entry, current)
  end

  test 'should handle duplicate timestamps when getting previous entry' do
    previous = create(:entry, published_at: DateTime.current)
    duplicate = create(:entry, published_at: 2.minutes.ago)
    current = create(:entry, published_at: duplicate.published_at) # This value needs to be exactly the same
    next_entry = create(:entry, published_at: 4.minutes.ago)

    search = EntrySearch.new

    assert_equal duplicate, search.previous(Entry, next_entry)
    assert_equal current, search.previous(Entry, duplicate)
    assert_equal previous, search.previous(Entry, current)
  end

  test 'should handle duplicate timestamps when getting next entry' do
    previous = create(:entry, published_at: DateTime.current)
    duplicate = create(:entry, published_at: 2.minutes.ago)
    current = create(:entry, published_at: duplicate.published_at) # This value needs to be exactly the same
    next_entry = create(:entry, published_at: 4.minutes.ago)

    search = EntrySearch.new

    assert_equal current, search.next(Entry, previous)
    assert_equal duplicate, search.next(Entry, current)
    assert_equal next_entry, search.next(Entry, duplicate)
  end

  test 'should respect filter when getting next and previous entry' do
    create(:entry, :read, published_at: 3.minutes.ago)
    create(:entry, :read, published_at: 1.minute.ago)
    previous = create(:entry, published_at: DateTime.current)
    current = create(:entry, published_at: 2.minutes.ago)
    next_entry = create(:entry, published_at: 4.minutes.ago)

    search = EntrySearch.new

    assert_equal previous, search.previous(Entry, current)
    assert_equal next_entry, search.next(Entry, current)
  end
end
