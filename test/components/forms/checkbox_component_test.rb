# frozen_string_literal: true

require 'test_helper'

class Forms::CheckboxComponentTest < ViewComponent::TestCase
  include FormComponentsHelper

  setup do
    @object = build(:user, :admin)
    @form = form_with(@object)
  end

  test 'should render checkbox' do
    render_inline(Forms::CheckboxComponent.new(form: @form, name: :admin))

    assert_selector '.checkbox'
    assert_selector '.checkbox__label', text: 'Admin'
    assert_selector 'input[type="checkbox"][value="1"][checked="checked"].checkbox__field'
  end

  test 'should render hint and error when values are passed' do
    render_inline(Forms::CheckboxComponent.new(form: @form, name: :admin,
                                               hint: 'Use with caution!',
                                               error: 'This field is required'))

    assert_selector '.checkbox.checkbox--invalid'
    assert_selector '.checkbox__hint', text: 'Use with caution!'
    assert_selector '.checkbox__error', text: 'This field is required'
  end

  test 'should render error from object' do
    @object.errors.add(:admin, 'Some error')

    render_inline(Forms::CheckboxComponent.new(form: @form, name: :admin))

    assert_selector '.checkbox__error', text: 'Some error'
  end

  test 'should render additional html attributes' do
    render_inline(Forms::CheckboxComponent.new(form: @form, name: :admin, class: 'my-class',
                                               data: { foo: :bar }))

    assert_selector '.checkbox.my-class[data-foo="bar"]'
  end
end
