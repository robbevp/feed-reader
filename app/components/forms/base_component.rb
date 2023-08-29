# frozen_string_literal: true

class Forms::BaseComponent < ViewComponent::Base
  attr_reader :form, :name, :hint

  def initialize(form:, name:, hint: nil, error: nil, **html_attrs)
    super
    @form = form
    @name = name
    @hint = hint
    @error = error
    @class = html_attrs.delete(:class).presence || ''
    @html_attrs = html_attrs
  end

  def error
    @error.presence || (form.object && form.object.errors.full_messages_for(name).first)
  end

  def valid?
    false
  end

  def invalid?
    error.present?
  end
end
