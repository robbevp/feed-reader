# frozen_string_literal: true

require 'test_helper'

class IngressCheckPolicyTest < ActiveSupport::TestCase
  setup do
    @admin = build_stubbed(:user, :admin)
    @user = build_stubbed(:user)
  end

  test 'should allow index for admin' do
    assert_permitted @admin, IngressCheck, :index
    assert_not_permitted @user, IngressCheck, :index
    assert_not_permitted nil, IngressCheck, :index
  end

  test 'should allow create for admin' do
    assert_permitted @admin, IngressCheck, :create
    assert_not_permitted @user, IngressCheck, :create
    assert_not_permitted nil, IngressCheck, :create
  end

  test 'should scope all records for admin' do
    check = IngressCheck.create!

    assert_scope_includes @admin, check
    assert_scope_empty @user, IngressCheck
    assert_scope_empty nil, IngressCheck
  end
end
