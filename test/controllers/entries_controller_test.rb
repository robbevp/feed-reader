# frozen_string_literal: true

require 'test_helper'

class EntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = sign_in create(:user)
    @entry = create(:entry, feed: build(:feed, user: @user))
  end

  # Index
  test 'should get index' do
    get entries_url

    assert_response :success
  end

  # Show
  test 'should get show' do
    get entry_url(@entry)

    assert_response :success
  end

  # Update
  test 'should mark entry as read' do
    assert_changes '@entry.reload.read_at' do
      patch entry_url(@entry), params: { entry: { read: true } }
    end

    assert_redirected_to @entry
    assert_predicate @entry, :read?
  end

  test 'should mark entry as unread' do
    @entry.update(read_at: 1.day.ago)

    assert_changes '@entry.reload.read_at' do
      patch entry_url(@entry), params: { entry: { read: false } }
    end

    assert_redirected_to @entry
    assert_not_predicate @entry, :read?
  end
end
