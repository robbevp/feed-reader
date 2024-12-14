# frozen_string_literal: true

# == Schema Information
#
# Table name: newsletters
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  public_id  :string           not null
#
# Indexes
#
#  index_newsletters_on_public_id  (public_id) UNIQUE
#
class Newsletter < ApplicationRecord
  PUBLIC_ID_LENGTH = 12
  MAX_RETRY = 100

  has_one :subscription, as: :subscribable, dependent: :destroy
  has_many :entries, through: :subscription

  before_create :set_public_id

  def email_address
    "newsletter-#{id}+#{public_id}@#{Rails.application.config.inbound_email_domain}"
  end

  private

  def set_public_id
    return if public_id.present?

    MAX_RETRY.times do
      self.public_id = generate_public_id
      return unless self.class.exists?(public_id:)
    end
    raise "Failed to generate a unique public id after #{MAX_RETRY} attempts"
  end

  def generate_public_id
    SecureRandom.hex(PUBLIC_ID_LENGTH)
  end
end
