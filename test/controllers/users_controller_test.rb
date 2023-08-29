# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user, password: 'password1234')
    sign_in @user
  end

  test 'should get edit' do
    get profile_url

    assert_response :success
  end

  test 'should update user profile' do
    assert_changes '@user.reload.email' do
      patch profile_url, params: { user: { email: 'test@example.org' } }
    end

    assert_redirected_to profile_url
  end

  test 'should update user password if all fields are filled in' do
    assert_changes '@user.reload.password_digest' do
      patch profile_url,
            params: { user: { password: 'password5678', password_confirmation: 'password5678',
                              password_challenge: 'password1234' } }
    end

    assert_redirected_to profile_url
  end

  test 'should return edit if user is invalid' do
    assert_no_changes '@user.reload.password_digest' do
      patch profile_url,
            params: { user: { password: 'password', password_confirmation: 'password',
                              password_challenge: 'password1234' } }
    end

    assert_response :unprocessable_entity
  end

  test 'should return edit if user did not include confirmation' do
    assert_no_changes '@user.reload.password_digest' do
      patch profile_url, params: { user: { password: 'password5678', password_challenge: 'password1234' } }
    end

    assert_response :unprocessable_entity
  end

  test 'should return edit if user did not include password challenge' do
    assert_no_changes '@user.reload.password_digest' do
      patch profile_url, params: { user: { password: 'password5678', password_confirmation: 'password5678' } }
    end

    assert_response :unprocessable_entity
  end
end
