# frozen_string_literal: true

require 'test_helper'

class SessionPolicyTest < ActiveSupport::TestCase
  setup do
    @user = build_stubbed(:user)
  end

  test 'should allow new for anyone' do
    assert_permitted @user, :session, :new
    assert_permitted nil, :session, :new
  end

  test 'should allow create for anyone' do
    assert_permitted @user, :session, :create
    assert_permitted nil, :session, :create
  end

  test 'should allow destroy for user' do
    assert_permitted @user, :session, :destroy
    assert_not_permitted nil, :session, :destroy
  end
end
