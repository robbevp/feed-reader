# frozen_string_literal: true

# == Schema Information
#
# Table name: subscriptions
#
#  id                :bigint           not null, primary key
#  category_text     :string
#  name              :string           not null
#  subscribable_type :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  category_id       :bigint
#  subscribable_id   :bigint           not null
#  user_id           :bigint           not null
#
# Indexes
#
#  index_subscriptions_on_category_id   (category_id)
#  index_subscriptions_on_subscribable  (subscribable_type,subscribable_id)
#  index_subscriptions_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_id => users.id)
#
class Subscription < ApplicationRecord
  belongs_to :user, inverse_of: :subscriptions
  has_many :entries, dependent: :destroy
  belongs_to :subscribable, polymorphic: true, inverse_of: :subscription
  belongs_to :category, inverse_of: :subscriptions, optional: true

  accepts_nested_attributes_for :subscribable

  normalizes :category_text, with: ->(text) { text.split('>').map(&:strip).join(' > ') if text.present? }

  validates :name, presence: true

  before_validation :create_categories_from_text

  scope :by_category, ->(cat_id) { where(category: Category.descendants_by_id(cat_id, include_self: true)) }

  def refreshable?
    subscribable.respond_to? :refresh!
  end

  def any_unread?
    entries.unread.exists?
  end

  def last_fetched_info
    return nil unless refreshable? && subscribable.last_fetched_at.present?

    I18n.l(subscribable.last_fetched_at)
  end

  def build_subscribable(params)
    self.subscribable = subscribable_type.constantize.new
    params.each_pair do |key, value|
      subscribable.send(:"#{key}=", value) if subscribable.has_attribute? key
    end
  end

  def self.category_text_options
    where.not(category_text: nil).pluck(:category_text).map do |text|
      text.split('>').each_with_object([]) do |part, arr|
        arr.push [arr.last, part.strip].compact.join(' > ')
      end
    end.flatten.uniq.sort
  end

  private

  def create_categories_from_text
    return unless category_text_changed? && category_text.present?

    current = nil
    category_text.split('>').map(&:strip).each do |name|
      current = Category.find_or_create_by(name:, parent: current)
    end
    self.category = current
  end
end
