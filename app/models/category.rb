# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :bigint
#
# Indexes
#
#  index_categories_on_name_and_parent_id  (name,parent_id) UNIQUE
#  index_categories_on_parent_id           (parent_id)
#
# Foreign Keys
#
#  fk_rails_...  (parent_id => categories.id)
#
class Category < ApplicationRecord
  include WithRecursiveSearch

  belongs_to :parent, class_name: 'Category', optional: true, inverse_of: :children
  has_many :children, class_name: 'Category', foreign_key: :parent_id, dependent: :destroy, inverse_of: :parent
  has_many :subscriptions, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: { scope: :parent }
end
