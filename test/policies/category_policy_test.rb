# frozen_string_literal: true

require 'test_helper'

class CategoryPolicyTest < ActiveSupport::TestCase
  test 'should scope categories where subscription belongs to user' do
    user = create(:user)
    parent_category = create(:category)
    category = create(:category, parent: parent_category)
    create(:subscription, category:, user:)
    other_category = create(:category)

    assert_scope_includes user, [parent_category, category]
    assert_scope_not_includes user, other_category
    assert_scope_empty nil, Category
  end
end
