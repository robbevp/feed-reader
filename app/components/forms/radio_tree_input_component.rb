# frozen_string_literal: true

class Forms::RadioTreeInputComponent < Forms::BaseComponent
  include Forms::HasOptions

  attr_reader :show_all

  def initialize(show_all: nil, **)
    super(**)
    @show_all = show_all
  end

  def roots
    @roots ||= options.filter { |opt| opt.parent_id.nil? }
  end

  def children_for(option)
    options.filter { |opt| opt.parent_id == option.id }
  end

  def show_all?
    @show_all.present?
  end
end
