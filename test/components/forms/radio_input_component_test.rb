# frozen_string_literal: true

require 'test_helper'

class Forms::RadioInputComponentTest < ViewComponent::TestCase
  include FormComponentsHelper

  setup do
    @object = build(:user, email: 'example@example.org')
    @form = form_with(@object)
    @options = [['value1', 'Option 1'], ['value2', 'Option 2']]
  end

  test 'should render input with options' do
    render_inline(Forms::RadioInputComponent.new(form: @form, name: :email, collection: @options))

    assert_selector '.radio-buttons'
    assert_selector '.radio-buttons__label', text: 'Email'
    assert_selector 'input[type="radio"][value="value1"].radio-buttons__option-field'
  end

  test 'should render hint and error when value is passed' do
    render_inline(Forms::RadioInputComponent.new(form: @form, name: :email, collection: @options,
                                                 hint: 'foobar@example.org',
                                                 error: 'This field is required'))

    assert_selector '.radio-buttons.radio-buttons--invalid'
    assert_selector '.radio-buttons__hint', text: 'foobar@example.org'
    assert_selector '.radio-buttons__error', text: 'This field is required'
  end

  test 'should render error from object' do
    @object.email = nil
    @object.validate

    render_inline(Forms::RadioInputComponent.new(form: @form, name: :email, collection: @options))

    assert_selector '.radio-buttons__error', text: 'Email can\'t be blank'
  end

  test 'should render additional html attributes' do
    render_inline(Forms::RadioInputComponent.new(form: @form, name: :email, collection: @options,
                                                 class: 'my-class',
                                                 data: { foo: :bar }))

    assert_selector '.radio-buttons.my-class[data-foo="bar"]'
  end
end
