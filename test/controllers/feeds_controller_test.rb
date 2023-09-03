# frozen_string_literal: true

require 'test_helper'

class FeedsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = sign_in create(:user)
    @feed = create(:feed, user: @user)
  end

  # Index
  test 'should get index' do
    get feeds_url

    assert_response :success
  end

  # New
  test 'should get new' do
    get new_feed_url

    assert_response :success
  end

  # Create
  test 'should create feed' do
    assert_enqueued_jobs 1 do
      assert_difference 'Feed.count' do
        post feeds_url, params: { feed: { name: 'My blog', url: 'https://example.org' } }
      end
    end

    assert_redirected_to feed_url(Feed.last)
  end

  test 'should render new if feed is invalid' do
    assert_no_difference 'Feed.count' do
      post feeds_url, params: { feed: { name: 'My blog', url: nil } }
    end

    assert_response :unprocessable_entity
  end

  # Show
  test 'should get show' do
    get feed_url(@feed)

    assert_response :success
  end

  # Edit
  test 'should get edit' do
    get edit_feed_url(@feed)

    assert_response :success
  end

  # Update
  test 'should update feed' do
    assert_changes '@feed.reload.name' do
      patch feed_url(@feed), params: { feed: { name: 'My new blog' } }
    end

    assert_redirected_to feed_url(@feed)
  end

  test 'should render edit if feed is invalid' do
    assert_no_changes '@feed.reload.name' do
      patch feed_url(@feed), params: { feed: { name: nil } }
    end

    assert_response :unprocessable_entity
  end

  # Destroy
  test 'should destroy feed' do
    assert_difference 'Feed.count', -1 do
      delete feed_url(@feed)
    end

    assert_redirected_to feeds_url
  end
end
