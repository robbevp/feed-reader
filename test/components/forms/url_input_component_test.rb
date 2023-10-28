# frozen_string_literal: true

require 'test_helper'

class Forms::UrlInputComponentTest < ViewComponent::TestCase
  include FormComponentsHelper

  setup do
    @object = build(:rss_feed, url: 'https://www.example.org')
    @form = form_with(@object)
  end

  test 'should render input with type email' do
    render_inline(Forms::UrlInputComponent.new(form: @form, name: :url))

    assert_selector '.input.input--url'
    assert_selector '.input__label', text: 'Url'
    assert_selector 'input[type="url"][value="https://www.example.org"].input__field'
  end

  test 'should render hint and error when value is passed' do
    render_inline(Forms::UrlInputComponent.new(form: @form, name: :url, hint: 'Choose something good',
                                               error: 'This field is required'))

    assert_selector '.input.input--invalid'
    assert_selector '.input__hint', text: 'Choose something good'
    assert_selector '.input__error', text: 'This field is required'
  end

  test 'should render error from object' do
    @object.url = nil
    @object.validate

    render_inline(Forms::UrlInputComponent.new(form: @form, name: :url))

    assert_selector '.input__error', text: 'Url can\'t be blank'
  end

  test 'should render additional html attributes' do
    render_inline(Forms::UrlInputComponent.new(form: @form, name: :url, class: 'my-class',
                                               data: { foo: :bar }))

    assert_selector '.input.my-class[data-foo="bar"]'
  end
end
