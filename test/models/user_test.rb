# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  admin           :boolean          default(FALSE), not null
#  email           :citext           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Validations
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

  # Reset password
  test 'should be able to generate reset password token and find by it' do
    user = create(:user, password: 'a' * 12)
    token = user.generate_token_for :password_reset

    assert_equal user, User.find_by_token_for(:password_reset, token)

    user.update(password: 'b' * 12)

    assert_nil User.find_by_token_for(:password_reset, token)
    assert_nil User.find_by_token_for(:password_reset, 'abc--123')
  end
end
