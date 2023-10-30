# frozen_string_literal: true

class Forms::RadioInputComponent < Forms::BaseComponent
  attr_reader :collection

  def initialize(**args)
    @collection = args.delete(:collection)
    super(**args)
  end
end
