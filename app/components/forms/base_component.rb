# frozen_string_literal: true

class Forms::BaseComponent < ViewComponent::Base
  attr_reader :form, :name, :hint, :disabled, :options

  # rubocop:disable Metrics/ParameterLists
  # We need to have a lot of parameters here, since this is a very generic component
  def initialize(form:, name:, hint: nil, error: nil, disabled: false, **html_attrs)
    super()
    @form = form
    @name = name
    @hint = hint
    @error = error
    @disabled = disabled
    @class = html_attrs.delete(:class).presence || ''
    @html_attrs = html_attrs
  end
  # rubocop:enable Metrics/ParameterLists

  def error
    @error.presence || (form.object.respond_to?(:errors) && form.object.errors.full_messages_for(name).first)
  end

  def valid?
    false
  end

  def invalid?
    error.present?
  end

  def element_id(type)
    [form.object_name, name, type].join('_')
  end
end
