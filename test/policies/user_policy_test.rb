# frozen_string_literal: true

require 'test_helper'

class UserPolicyTest < ActiveSupport::TestCase
  setup do
    @admin = build_stubbed(:user, :admin)
    @user = build_stubbed(:user)
  end

  test 'should allow edit for owner' do
    assert_permitted @admin, @admin, :edit
    assert_permitted @user, @user, :edit
    assert_not_permitted nil, nil, :edit
  end

  test 'should not allow edit for different user' do
    assert_not_permitted @admin, @user, :edit
    assert_not_permitted @user, @admin, :edit
  end

  test 'should allow update for owner' do
    assert_permitted @admin, @admin, :update
    assert_permitted @user, @user, :update
    assert_not_permitted nil, nil, :update
  end

  test 'should not allow update for different user' do
    assert_not_permitted @admin, @user, :update
    assert_not_permitted @user, @admin, :update
  end

  test 'should allow permitted attributes for any user' do
    assert_permitted_attributes @admin, User
    assert_permitted_attributes @user, User
    assert_no_permitted_attributes nil, User
  end

  test 'should only allow `admin` attribute for admins' do
    assert_attributes_permitted @admin, User, :admin
    assert_not_attributes_permitted @user, User, :admin
    assert_not_attributes_permitted nil, User, :admin
  end

  test 'should only include self in scope' do
    user = create(:user)
    other_user = create(:user)

    assert_scope_empty nil, User
    assert_scope_includes user, user
    assert_scope_not_includes user, other_user
  end

  test 'should scope all users for admin' do
    user = create(:user)
    admin = create(:user, :admin)

    assert_scope_includes admin, [admin, user]
  end
end
