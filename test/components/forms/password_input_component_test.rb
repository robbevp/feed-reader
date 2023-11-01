# frozen_string_literal: true

require 'test_helper'

class Forms::PasswordInputComponentTest < ViewComponent::TestCase
  include FormComponentsHelper

  setup do
    @object = build(:user, email: 'example@example.org')
    @form = form_with(@object)
  end

  test 'should render input with type password' do
    render_inline(Forms::PasswordInputComponent.new(form: @form, name: :password))

    assert_selector '.input.input--password'
    assert_selector '.input__label', text: 'Password'
    assert_selector 'input[type="password"].input__field'
  end

  test 'should render hint and error when value is passed' do
    render_inline(Forms::PasswordInputComponent.new(form: @form, name: :password, hint: 'Choose wisely',
                                                    error: 'This field is required'))

    assert_selector '.input.input--invalid'
    assert_selector '.input__hint', text: 'Choose wisely'
    assert_selector '.input__error', text: 'This field is required'
  end

  test 'should render error from object' do
    @object.password = nil
    @object.validate

    render_inline(Forms::PasswordInputComponent.new(form: @form, name: :password))

    assert_selector '.input.input--invalid'
    assert_selector '.input__error', text: 'Password can\'t be blank'
  end

  test 'should render additional html attributes' do
    render_inline(Forms::PasswordInputComponent.new(form: @form, name: :password, class: 'my-class',
                                                    data: { foo: :bar }))

    assert_selector '.input.my-class[data-foo="bar"]'
  end

  test 'should raise error if passed options' do
    options = ['opt1', ['opt2', 'Option 2']]

    assert_raises ArgumentError do
      render_inline(Forms::PasswordInputComponent.new(form: @form, name: :password, options:))
    end
  end
end
