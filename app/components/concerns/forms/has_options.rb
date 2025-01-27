# frozen_string_literal: true

module Forms::HasOptions
  extend ActiveSupport::Concern

  # We need to define `initialize` outside of included, so that we can still add another init in the actual class
  def initialize(options: [], value_method: :first, label_method: :second, **)
    super(**)
    @options = options.map { |opt| opt.is_a?(ApplicationRecord) ? opt : Array.wrap(opt) }
    @label_method = label_method
    @value_method = value_method
  end

  included do
    attr_reader :options, :value_method, :label_method
  end
end
