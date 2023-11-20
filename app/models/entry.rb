# frozen_string_literal: true

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

  validates :data, presence: true
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
    new(data: entry.to_h, **attrs)
  end

  def same?(feedjira_entry)
    if feedjira_entry.entry_id.present?
      external_id == feedjira_entry.entry_id
    else
      url == feedjira_entry.url
    end
  end

  def read?
    read_at.present?
  end

  def normalize_url(input)
    # Some urls might contain spaces, so we replace these
    uri = URI(input.gsub(' ', '%20'))
    # Some entries might contain absolute/relative path to the page they were on
    uri = URI(url).merge(uri) if url.present?
    uri.to_s
  end

  delegate :user_id, to: :subscription
end
