# frozen_string_literal: true

require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user, email: 'example@example.org', password: 'password1234')
  end

  test 'should get new' do
    get new_session_url

    assert_response :success
  end

  test 'should redirect to `user_url` if user id is present' do
    sign_in(@user)

    get new_session_url

    assert_redirected_to user_url
  end

  test 'should log in user' do
    post session_url, params: { session: { email: 'example@example.org', password: 'password1234' } }

    assert_redirected_to user_url
    assert_equal @user.id, session[:user_id]
  end

  test 'should return new if email could not be found' do
    post session_url, params: { session: { email: 'example2@example.org', password: 'password1234' } }

    assert_response :unprocessable_entity
  end

  test 'should return new if password was not correct' do
    post session_url, params: { session: { email: 'example@example.org', password: 'password12345' } }

    assert_response :unprocessable_entity
  end

  test 'should remove cookie on sign out' do
    sign_in(@user)

    delete destroy_session_url

    assert_nil session[:user_id]
    assert_redirected_to session_url
  end
end
