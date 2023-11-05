# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # Ransack 4.0 introduced allowlisting of attributes and associations
  # We disable this, since our models should not be aware of the current user
  # Filtering of params should happen in the controller and not in the model
  def self.ransackable_attributes(_auth_object = nil)
    authorizable_ransackable_attributes
  end

  def self.ransackable_associations(_auth_object = nil)
    authorizable_ransackable_associations
  end
end
