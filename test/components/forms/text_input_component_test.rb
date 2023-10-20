# frozen_string_literal: true

require 'test_helper'

class Forms::TextInputComponentTest < ViewComponent::TestCase
  include FormComponentsHelper

  setup do
    @object = build(:subscription, name: 'My blog')
    @form = form_with(@object)
  end

  test 'should render input with type email' do
    render_inline(Forms::TextInputComponent.new(form: @form, name: :name))

    assert_selector '.input.input--text'
    assert_selector '.input__label', text: 'Name'
    assert_selector 'input[type="text"][value="My blog"].input__field'
  end

  test 'should render hint and error when value is passed' do
    render_inline(Forms::TextInputComponent.new(form: @form, name: :name, hint: 'Choose something good',
                                                error: 'This field is required'))

    assert_selector '.input.input--invalid'
    assert_selector '.input__hint', text: 'Choose something good'
    assert_selector '.input__error', text: 'This field is required'
  end

  test 'should render error from object' do
    @object.name = nil
    @object.validate

    render_inline(Forms::TextInputComponent.new(form: @form, name: :name))

    assert_selector '.input__error', text: 'Name can\'t be blank'
  end

  test 'should render additional html attributes' do
    render_inline(Forms::TextInputComponent.new(form: @form, name: :name, class: 'my-class',
                                                data: { foo: :bar }))

    assert_selector '.input.my-class[data-foo="bar"]'
  end
end
