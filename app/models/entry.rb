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
require 'addressable/uri'

class Entry < ApplicationRecord
  FEEDJIRA_KEYS_MAP = {
    author: :author,
    content: :body,
    entry_id: :external_id,
    published: :published_at,
    summary: :summary,
    title: :title,
    url: :url
  }.freeze

  belongs_to :subscription, inverse_of: :entries
  has_and_belongs_to_many :proxied_images

  validates :data, :external_id, presence: true
  validates :external_id, uniqueness: { scope: :subscription }

  after_create_commit -> { DetectEntryImagesJob.perform_later(self) }

  scope :read, -> { where.not(read_at: nil) }
  scope :unread, -> { where(read_at: nil) }
  # Delegate scope to `Subscription`
  scope :by_category, ->(cat_id) { where(subscription: Subscription.by_category(cat_id)) }

  def self.from_feedjira_entry(entry)
    attrs = {}
    FEEDJIRA_KEYS_MAP.each_pair do |old_key, new_key|
      attrs[new_key] = entry.send(old_key)
    end
    # If the RSSFeed does not contain an id, we use the url as the id
    attrs[:external_id] = entry.url if attrs[:external_id].blank?
    new(data: entry.to_h, **attrs)
  end

  def same?(feedjira_entry)
    external_id == (feedjira_entry.entry_id.presence || feedjira_entry.url)
  end

  def read?
    read_at.present?
  end

  def normalize_url(input)
    uri = Addressable::URI.heuristic_parse(input).normalize
    # Some entries might contain absolute/relative path to the page they were on
    uri = URI(url).merge(uri) if url.present?
    uri.to_s
  end

  delegate :user_id, to: :subscription
end
