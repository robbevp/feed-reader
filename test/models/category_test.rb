# frozen_string_literal: true

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
end
