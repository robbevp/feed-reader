# frozen_string_literal: true

class Category < ApplicationRecord
  belongs_to :parent, class_name: 'Category', optional: true, inverse_of: :children
  has_many :children, class_name: 'Category', foreign_key: :parent_id, dependent: :destroy, inverse_of: :parent
  has_many :subscriptions, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: { scope: :parent }
end
