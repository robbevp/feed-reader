# frozen_string_literal: true

require 'test_helper'

class Forms::EmailInputComponentTest < ViewComponent::TestCase
  include FormComponentsHelper

  setup do
    @object = build(:user, email: 'example@example.org')
    @form = form_with(@object)
  end

  test 'should render input with type email' do
    render_inline(Forms::EmailInputComponent.new(form: @form, name: :email))

    assert_selector '.input.input--email'
    assert_selector '.input__label', text: 'Email'
    assert_selector 'input[type="email"][value="example@example.org"].input__field'
  end

  test 'should render hint and error when value is passed' do
    render_inline(Forms::EmailInputComponent.new(form: @form, name: :email, hint: 'foobar@example.org',
                                                 error: 'This field is required'))

    assert_selector '.input.input--invalid'
    assert_selector '.input__hint', text: 'foobar@example.org'
    assert_selector '.input__error', text: 'This field is required'
  end

  test 'should render error from object' do
    @object.email = nil
    @object.validate

    render_inline(Forms::EmailInputComponent.new(form: @form, name: :email))

    assert_selector '.input__error', text: 'Email can\'t be blank'
  end

  test 'should render additional html attributes' do
    render_inline(Forms::EmailInputComponent.new(form: @form, name: :email, class: 'my-class',
                                                 data: { foo: :bar }))

    assert_selector '.input.my-class[data-foo="bar"]'
  end
end
