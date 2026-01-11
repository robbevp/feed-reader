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
  include HasPublicId

  has_one :subscription, as: :subscribable, dependent: :destroy
  has_many :entries, through: :subscription

  def email_address
    "newsletter-#{id}+#{public_id}@#{Rails.application.config.inbound_email_domain}"
  end
end
