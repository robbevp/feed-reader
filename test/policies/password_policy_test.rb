# frozen_string_literal: true

require 'test_helper'

class PasswordPolicyTest < ActiveSupport::TestCase
  setup do
    @user = build_stubbed(:user)
  end

  test 'should allow new for anyone' do
    assert_permitted @user, :password, :new
    assert_permitted nil, :password, :new
  end

  test 'should allow create for anyone' do
    assert_permitted @user, :password, :create
    assert_permitted nil, :password, :create
  end

  test 'should allow edit for anyone' do
    assert_permitted @user, :password, :edit
    assert_permitted nil, :password, :edit
  end

  test 'should allow update for anyone' do
    assert_permitted @user, :password, :update
    assert_permitted nil, :password, :update
  end
end
