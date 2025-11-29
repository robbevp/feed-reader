# frozen_string_literal: true

require 'test_helper'

class EntryPolicyTest < ActiveSupport::TestCase
  setup do
    @user = build_stubbed(:user)
    @entry = build_stubbed(:entry, subscription: build_stubbed(:subscription, user: @user))
  end

  test 'should allow index for user' do
    assert_permitted @user, Entry, :index
    assert_not_permitted nil, Entry, :index
  end

  test 'should allow show if user owns record' do
    assert_permitted @user, @entry, :show
    assert_not_permitted build_stubbed(:user), @entry, :show
    assert_not_permitted nil, @entry, :show
  end

  test 'should allow edit if user owns record' do
    assert_permitted @user, @entry, :edit
    assert_not_permitted build_stubbed(:user), @entry, :edit
    assert_not_permitted nil, @entry, :edit
  end

  test 'should allow update if user owns record' do
    assert_permitted @user, @entry, :update
    assert_not_permitted build_stubbed(:user), @entry, :update
    assert_not_permitted nil, @entry, :update
  end

  test 'should allow destroy if user owns record' do
    assert_permitted @user, @entry, :destroy
    assert_not_permitted build_stubbed(:user), @entry, :destroy
    assert_not_permitted nil, @entry, :destroy
  end

  test 'should return permitted attributes for user' do
    assert_permitted_attributes @user, Entry
    assert_no_permitted_attributes nil, Entry
  end

  test 'should return permitted attributes for user on index' do
    assert_permitted_attributes @user, Entry, :index
    assert_no_permitted_attributes nil, Entry, :index
  end

  test 'should scope entries where subscription belongs to user' do
    user = create(:user)
    entry = create(:entry, subscription: create(:subscription, user:))
    other_entry = create(:entry)

    assert_scope_includes user, entry
    assert_scope_not_includes user, other_entry
    assert_scope_empty nil, Entry
  end
end
