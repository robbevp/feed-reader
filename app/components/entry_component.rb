# frozen_string_literal: true

class EntryComponent < ViewComponent::Base
  attr_reader :entry

  def initialize(entry:)
    super
    @entry = entry
  end

  delegate :title, :author, :published_at, :summary, :body, :url, to: :entry
end