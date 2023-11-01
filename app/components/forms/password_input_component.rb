# frozen_string_literal: true

class Forms::PasswordInputComponent < Forms::BaseComponent
  def initialize(**)
    super(**)
    raise 'Options is not supported for password inputs' if options.present?
  end
end
