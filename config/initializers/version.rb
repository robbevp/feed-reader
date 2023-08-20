# frozen_string_literal: true

module FeedReader
  class Application
    module Version
      MAJOR = 0
      MINOR = 1
      PATCH = 0
      BUILD = if Rails.root.join('REVISION').exist?
                Rails.root.join('REVISION').read[...7]
              else
                `git log -n 1 --pretty=format:"%h"`.freeze
              end
    end
    VERSION = "#{Version::MAJOR}.#{Version::MINOR}.#{Version::PATCH}-#{Version::BUILD}".freeze

    # Set version header for every request
    config.action_dispatch.default_headers.merge!('X-Feed-Reader-Version' => VERSION)
  end
end
