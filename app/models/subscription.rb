# frozen_string_literal: true

class Subscription < ApplicationRecord
  belongs_to :user, inverse_of: :subscriptions
  has_many :entries, dependent: :destroy
  belongs_to :subscribable, polymorphic: true, inverse_of: :subscription

  accepts_nested_attributes_for :subscribable

  validates :name, presence: true

  def refreshable?
    subscribable.respond_to? :refresh!
  end

  def build_subscribable(params)
    self.subscribable = subscribable_type.constantize.new(params)
  end
end
