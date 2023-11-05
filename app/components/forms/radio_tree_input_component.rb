# frozen_string_literal: true

class Forms::RadioTreeInputComponent < Forms::BaseComponent
  include Forms::HasOptions

  def roots
    @roots ||= options.filter { |opt| opt.parent_id.nil? }
  end

  def children_for(option)
    options.filter { |opt| opt.parent_id == option.id }
  end
end
