# frozen_string_literal: true

class ProxiedImage < ApplicationRecord
  belongs_to :entry, inverse_of: :proxied_images

  has_one_attached :image

  validates :url, presence: true

end
