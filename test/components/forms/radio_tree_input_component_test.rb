# frozen_string_literal: true

require 'test_helper'

class Forms::RadioTreeInputComponentTest < ViewComponent::TestCase
  include FormComponentsHelper

  setup do
    # Create some categories to use as options
    parent = create(:category, name: 'parent')
    record = create(:category, parent:, name: 'record')
    create(:category, parent:, name: 'sibling')
    create(:category, parent: record, name: 'child')

    @object = build(:subscription, category: record)
    @form = form_with(@object)
    @options = Category.all
  end

  test 'should render input with options' do
    render_inline(Forms::RadioTreeInputComponent.new(form: @form, name: :category, options: @options,
                                                     value_method: :name, label_method: :name))

    assert_selector '.radio-buttons.radio-buttons--tree'
    assert_selector '.radio-buttons__label', text: 'Category'
    assert_selector 'input[type="radio"].radio-buttons__option-field', count: 4
  end

  test 'should render options as tree' do
    page = render_inline(Forms::RadioTreeInputComponent.new(form: @form, name: :category, options: @options,
                                                            value_method: :name, label_method: :name))

    pp page.to_html

    assert_selector 'ul[data-tree-level="0"] > li > input[type="radio"][value="parent"]'
    assert_selector 'ul[data-tree-level="1"] > li > input[type="radio"]', count: 2
    assert_selector 'ul[data-tree-level="2"] > li > input[type="radio"][value="child"]'
  end

  test 'should render hint and error when value is passed' do
    render_inline(Forms::RadioTreeInputComponent.new(form: @form, name: :category, options: @options,
                                                     value_method: :name, label_method: :name,
                                                     hint: 'foobar@example.org',
                                                     error: 'This field is required'))

    assert_selector '.radio-buttons.radio-buttons--invalid'
    assert_selector '.radio-buttons__hint', text: 'foobar@example.org'
    assert_selector '.radio-buttons__error', text: 'This field is required'
  end

  test 'should render error from object' do
    @object.errors.add(:category, 'Some error')

    render_inline(Forms::RadioTreeInputComponent.new(form: @form, name: :category, options: @options,
                                                     value_method: :name, label_method: :name))

    assert_selector '.radio-buttons__error', text: 'Some error'
  end

  test 'should render additional html attributes' do
    render_inline(Forms::RadioTreeInputComponent.new(form: @form, name: :category, options: @options,
                                                     value_method: :name, label_method: :name,
                                                     class: 'my-class',
                                                     data: { foo: :bar }))

    assert_selector '.radio-buttons.my-class[data-foo="bar"]'
  end
end
