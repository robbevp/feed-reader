# frozen_string_literal: true

require 'test_helper'

class EntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    @entry = create(:entry, subscription: build(:subscription, user: @user))
  end

  # Index
  test 'should get index' do
    sign_in @user

    get entries_url

    assert_response :success
  end

  test 'should redirect to sign in if user is not authorized' do
    get entries_url

    assert_redirected_to new_session_path
  end

  # Show
  test 'should get show' do
    sign_in @user

    get entry_url(@entry)

    assert_response :success
  end

  # Update
  test 'should mark entry as read' do
    sign_in @user

    assert_changes '@entry.reload.read_at' do
      patch entry_url(@entry), params: { entry: { read: true } }
    end

    assert_redirected_to @entry
    assert_predicate @entry, :read?
  end

  test 'should mark entry as unread' do
    sign_in @user

    @entry.update(read_at: 1.day.ago)

    assert_changes '@entry.reload.read_at' do
      patch entry_url(@entry), params: { entry: { read: false } }
    end

    assert_redirected_to @entry
    assert_not_predicate @entry, :read?
  end
end
