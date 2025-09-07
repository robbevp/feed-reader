# frozen_string_literal: true

require 'test_helper'

class PaginationComponentTest < ViewComponent::TestCase
  setup do
    @array = Array.new(100) { |i| i }
    # This mimics the behaviour if the `pagy` method in our controller, see https://ddnexus.github.io/pagy/docs/api/backend/#writing-your-own-pagy-methods
    @pagy = Pagy.new(count: @array.count, page: 1, limit: 5)
  end

  test 'should render links' do
    render_inline(PaginationComponent.new(pagy: @pagy))

    assert_selector '.pagination'
    assert_selector '.pagination__link', count: 8
    assert_selector '.pagination__gap', count: 1
  end

  test 'should add attributes to current page' do
    render_inline(PaginationComponent.new(pagy: @pagy))

    assert_selector '[aria-current="page"]', count: 1
    assert_selector '.pagination__link[aria-current="page"][aria-disabled="true"]', text: '1'
  end

  test 'should render additional class' do
    render_inline(PaginationComponent.new(pagy: @pagy, class: 'my-class'))

    assert_selector '.pagination.my-class'
  end
end
