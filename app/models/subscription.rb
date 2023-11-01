# frozen_string_literal: true

class Subscription < ApplicationRecord
  belongs_to :user, inverse_of: :subscriptions
  has_many :entries, dependent: :destroy
  belongs_to :subscribable, polymorphic: true, inverse_of: :subscription
  belongs_to :category, inverse_of: :subscriptions, optional: true

  accepts_nested_attributes_for :subscribable

  validates :name, presence: true

  before_validation :create_categories_from_text

  def refreshable?
    subscribable.respond_to? :refresh!
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
