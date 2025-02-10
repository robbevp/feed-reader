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

  test 'should redirect to root if user id is present' do
    sign_in(@user)

    get new_session_url

    assert_redirected_to root_url
  end

  test 'should log in user and set session info' do
    post session_url, params: { session: { email: 'example@example.org', password: 'password1234' } }

    assert_redirected_to root_url
    assert_equal @user.id, session[:user_id]
  end

  test 'should redirect to previous path after sign in' do
    # Make a request so our session cookie contains the previous path
    get entries_url

    post session_url, params: { session: { email: 'example@example.org', password: 'password1234' } }

    assert_redirected_to entries_url
    assert_equal @user.id, session[:user_id]
  end

  test 'should log in user and set long term cookie' do
    post session_url, params: { session: { email: 'example@example.org', password: 'password1234', remember_me: '1' } }

    # We cannot access the content of signed cookies directly (since Rack::Test::CookieJar does not implement this)
    # To verify that our cookie is set and contains the correct values, we create a new cookie jar,
    # load our signed cookie into that, and then read the actual content through `#signed[]`
    cookie_jar = ActionDispatch::Request.new(Rails.application.env_config.deep_dup).cookie_jar
    cookie_jar[:_feed_reader_user_id] = cookies[:_feed_reader_user_id]

    assert_equal @user.id, cookie_jar.signed[:_feed_reader_user_id]
    assert_redirected_to root_url
  end

  test 'should return new if email could not be found' do
    post session_url, params: { session: { email: 'example2@example.org', password: 'password1234' } }

    assert_response :unprocessable_entity
  end

  test 'should return new if password was not correct' do
    post session_url, params: { session: { email: 'example@example.org', password: 'password12345' } }

    assert_response :unprocessable_entity
  end

  test 'should remove user id and cookie from sessions on sign out' do
    sign_in(@user, with_cookie: true)

    delete destroy_session_url

    assert_nil session[:user_id]
    assert_predicate cookies[:_feed_reader_user_id], :blank?
    assert_redirected_to session_url
  end
end
