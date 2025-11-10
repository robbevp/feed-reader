# frozen_string_literal: true

require 'pagy/toolbox/helpers/support/series'

class PaginationComponent < ViewComponent::Base
  attr_reader :pagy

  def initialize(pagy:, **opts)
    super()
    @pagy = pagy
    @class = opts.delete(:class)
  end

  def previous_link
    return nil unless pagy.previous

    @previous_link ||= page_url(pagy.previous)
  end

  def next_link
    return nil unless pagy.next

    @next_link ||= page_url(pagy.next)
  end

  delegate :page_url, to: :pagy
end
