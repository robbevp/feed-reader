# frozen_string_literal: true

require 'test_helper'

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user, email: 'info@example.org')
  end

  # New
  test 'should get new' do
    get new_password_url

    assert_response :success
  end

  # Create
  test 'should be able to request new password' do
    assert_enqueued_emails 1 do
      post password_url, params: { password: { email: 'info@example.org' } }
    end

    assert_redirected_to new_session_path
  end

  test 'should ignore emails that do not exist' do
    assert_no_enqueued_emails do
      post password_url, params: { password: { email: 'info2@example.org' } }
    end

    assert_redirected_to new_session_url
  end

  # Edit
  test 'should be able to get edit with valid token' do
    token = @user.password_reset_token

    get edit_password_url, params: { token: }

    assert_response :success
  end

  test 'should redirect from edit when token is invalid' do
    token = @user.password_reset_token(expires_in: 0.seconds)

    get edit_password_url, params: { token: }

    assert_redirected_to new_password_url
  end

  # Update
  test 'should be able to set new password with valid token' do
    token = @user.password_reset_token

    assert_changes '@user.reload.password_digest' do
      patch password_url, params: { token:, password: { password: 'a' * 12, password_confirmation: 'a' * 12 } }
    end

    assert_redirected_to new_session_url
  end

  test 'should redirect from update when token is invalid' do
    token = @user.password_reset_token(expires_in: 0.seconds)

    patch password_url, params: { token: }

    assert_redirected_to new_password_url
  end

  test 'should return edit if user is invalid' do
    token = @user.password_reset_token

    assert_no_changes '@user.reload.password_digest' do
      patch password_url, params: { token:, password: { password: 'a' * 12, password_confirmation: 'b' * 12 } }
    end

    assert_response :unprocessable_entity
  end

  test 'should return edit if user tries to skip confirmation' do
    token = @user.password_reset_token

    assert_no_changes '@user.reload.password_digest' do
      patch password_url, params: { token:, password: { password: 'a' * 12 } }
    end

    assert_response :unprocessable_entity
  end
end
