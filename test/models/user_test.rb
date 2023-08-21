# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should not be valid without an email' do
    user = build(:user, email: nil)

    assert_not_predicate user, :valid?
    assert_includes user.errors['email'], "can't be blank"
  end

  test 'should not be valid when email was already used' do
    create(:user, email: 'test@example.org')
    user = build(:user, email: 'TEST@example.ORG')

    assert_not_predicate user, :valid?
    assert_includes user.errors['email'], 'has already been taken'
  end

  test 'should not be valid with an invalid email' do
    user = build(:user, email: 'testatexampledotorg')

    assert_not_predicate user, :valid?
    assert_includes user.errors['email'], 'is invalid'
  end

  test 'should not be valid without a password' do
    user = build(:user, password: nil)

    assert_not_predicate user, :valid?
    assert_includes user.errors['password'], "can't be blank"
  end

  test 'should not be valid with a password that is less than 12 characters' do
    user = build(:user, password: 'a' * 11)

    assert_not_predicate user, :valid?
    assert_includes user.errors['password'], 'is too short (minimum is 12 characters)'
  end

  # NOTE: Delete when upgrading to rails 7.1
  test 'should not be valid with a false password challenge' do
    user = create(:user, password: 'a' * 12)

    user.password_challenge = 'b' * 12
    assert_not_predicate user, :valid?
    assert_includes user.errors['password_challenge'], 'is invalid'
  end
end
