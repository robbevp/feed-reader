# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :bigint
#
# Indexes
#
#  index_categories_on_name_and_parent_id  (name,parent_id) UNIQUE
#  index_categories_on_parent_id           (parent_id)
#
# Foreign Keys
#
#  fk_rails_...  (parent_id => categories.id)
#
require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # Validations
  test 'should not be valid without a name' do
    category = build(:category, name: nil)

    assert_not_predicate category, :valid?
    assert_includes category.errors['name'], "can't be blank"
  end

  test 'should not be valid if name is not unique for parent' do
    parent = create(:category, name: 'music')
    create(:category, parent:, name: 'music')
    child = build(:category, parent:, name: 'music')

    assert_not_predicate child, :valid?
    assert_includes child.errors['name'], 'has already been taken'
  end

  test 'should not save in database with a name that is not unique for parent' do
    parent = create(:category, name: 'music')
    create(:category, parent:, name: 'music')

    assert_raises ActiveRecord::RecordNotUnique do
      # rubocop:disable Rails/SkipsModelValidations
      # We intentionally skip model validations to test the database constraint
      Category.insert!(attributes_for(:category, name: 'music', parent_id: parent.id))
      # rubocop:enable Rails/SkipsModelValidations
    end
  end

  # `WithRecursiveSearch` concern
  test 'should find ancestors based on ids' do
    parent = create(:category)
    record = create(:category, parent:)
    sibling = create(:category, parent:)
    child = create(:category, parent: record)

    assert_equal 2, Category.ancestors_by_id(child.id).length
    assert_equal 1, Category.ancestors_by_id(record.id).length
    assert_equal 1, Category.ancestors_by_id(sibling.id).length
  end

  test 'should find descendants based on ids' do
    parent = create(:category)
    record = create(:category, parent:)
    sibling = create(:category, parent:)
    create(:category, parent: record)

    assert_equal 3, Category.descendants_by_id(parent.id).length
    assert_equal 1, Category.descendants_by_id(record.id).length
    assert_equal 0, Category.descendants_by_id(sibling.id).length
  end

  test 'should find ancestors with self based on ids' do
    parent = create(:category)
    record = create(:category, parent:)
    sibling = create(:category, parent:)
    child = create(:category, parent: record)

    assert_equal 3, Category.ancestors_by_id(child.id, include_self: true).length
    assert_equal 2, Category.ancestors_by_id(record.id, include_self: true).length
    assert_equal 2, Category.ancestors_by_id(sibling.id, include_self: true).length
  end

  test 'should find descendants with self based on ids' do
    parent = create(:category)
    record = create(:category, parent:)
    sibling = create(:category, parent:)
    create(:category, parent: record)

    assert_equal 4, Category.descendants_by_id(parent.id, include_self: true).length
    assert_equal 2, Category.descendants_by_id(record.id, include_self: true).length
    assert_equal 1, Category.descendants_by_id(sibling.id, include_self: true).length
  end
end
