# frozen_string_literal: true

# == Schema Information
#
# Table name: ingress_checks
#
#  id          :bigint           not null, primary key
#  received_at :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  public_id   :text             not null
#
# Indexes
#
#  index_ingress_checks_on_public_id  (public_id) UNIQUE
#
class IngressCheck < ApplicationRecord
  include HasPublicId
end
