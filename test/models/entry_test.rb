# frozen_string_literal: true

# == Schema Information
#
# Table name: entries
#
#  id              :bigint           not null, primary key
#  author          :text
#  body            :text
#  data            :jsonb            not null
#  published_at    :datetime
#  read_at         :datetime
#  summary         :text
#  title           :text
#  url             :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  external_id     :text
#  subscription_id :bigint           not null
#
# Indexes
#
#  index_entries_on_external_id_and_subscription_id  (external_id,subscription_id) UNIQUE
#  index_entries_on_subscription_id                  (subscription_id)
#
# Foreign Keys
#
#  fk_rails_...  (subscription_id => subscriptions.id)
#
require 'test_helper'

class EntryTest < ActiveSupport::TestCase
  test 'should not be valid without data' do
    entry = build(:entry, data: nil)

    assert_not_predicate entry, :valid?
    assert_includes entry.errors['data'], "can't be blank"
  end

  test 'should not be valid if external_id is not unique for subscription' do
    subscription = create(:subscription)
    create(:entry, subscription:, external_id: 'abc')
    entry = build(:entry, subscription:, external_id: 'abc')

    assert_not_predicate entry, :valid?
    assert_includes entry.errors['external_id'], 'has already been taken'
  end

  test 'should not save in database with an external id that is not unique for subscription' do
    subscription = create(:subscription)
    create(:entry, subscription:, external_id: 'abc')

    assert_raises ActiveRecord::RecordNotUnique do
      # rubocop:disable Rails/SkipsModelValidations
      # We intentionally skip model validations to test the database constraint
      Entry.insert!(attributes_for(:entry, subscription_id: subscription.id, external_id: 'abc'))
      # rubocop:enable Rails/SkipsModelValidations
    end
  end

  # Callbacks
  test 'should detect image after create' do
    stub_request(:any, 'https://example.com/image.jpg')
      .to_return(body: Rails.root.join('test/fixtures/files/image.jpg').read)

    assert_difference ['ProxiedImage.count', 'ActiveStorage::Attachment.count'] do
      perform_enqueued_jobs do
        create(:entry, body: '<div><img src="https://example.com/image.jpg" /></div>')
      end
    end
  end

  # Methods
  test 'should be able to normalize urls found in post when containing spaces' do
    entry = build(:entry, url: 'https://example.com/posts/first.html')

    assert_equal 'https://example.com/image%201.jpg', entry.normalize_url('https://example.com/image 1.jpg')
  end

  test 'should be able to normalize urls found in post when containing unicode' do
    entry = build(:entry, url: 'https://example.com/posts/first.html')

    assert_equal 'https://example.com/image%F0%9F%96%A41.jpg', entry.normalize_url('https://example.com/image🖤1.jpg')
    assert_equal 'https://example.com/image%E2%80%941.jpg', entry.normalize_url('https://example.com/image—1.jpg')
  end

  test 'should be able to normalize urls found in post when missing host' do
    entry = build(:entry, url: 'https://example.com/posts/first.html')

    assert_equal 'https://example.com/image.jpg', entry.normalize_url('/image.jpg')
  end
end
