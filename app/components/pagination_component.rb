# frozen_string_literal: true

class PaginationComponent < ViewComponent::Base
  include Pagy::Frontend

  attr_reader :pagy

  def initialize(pagy:, **opts)
    super()
    @pagy = pagy
    @class = opts.delete(:class)
  end

  def previous_link
    return nil unless pagy.prev

    @previous_link ||= pagy_url_for(pagy, pagy.prev)
  end

  def next_link
    return nil unless pagy.next

    @next_link ||= pagy_url_for(pagy, pagy.next)
  end
end
