# frozen_string_literal: true

require 'test_helper'

class EntryTest < ActiveSupport::TestCase
  test 'should not be valid without data' do
    entry = build(:entry, data: nil)

    assert_not_predicate entry, :valid?
    assert_includes entry.errors['data'], "can't be blank"
  end

  test 'should not be valid if external_id is not unique for feed' do
    feed = create(:feed)
    create(:entry, feed:, external_id: 'abc')
    entry = build(:entry, feed:, external_id: 'abc')

    assert_not_predicate entry, :valid?
    assert_includes entry.errors['external_id'], 'has already been taken'
  end

  test 'should not save in database with an external id that is not unique for feed' do
    feed = create(:feed)
    create(:entry, feed:, external_id: 'abc')

    assert_raises ActiveRecord::RecordNotUnique do
      # rubocop:disable Rails/SkipsModelValidations
      # We intentionally skip model validations to test the database constraint
      Entry.insert!(attributes_for(:entry, feed_id: feed.id, external_id: 'abc'))
      # rubocop:enable Rails/SkipsModelValidations
    end
  end
end
