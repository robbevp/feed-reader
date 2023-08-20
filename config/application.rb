# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FeedReader
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Set good job as our queue adapter in all environments
    config.active_job.queue_adapter = :good_job

    # Allow option to log to STDOUT
    if ENV['RAILS_LOG_TO_STDOUT'].present?
      logger = ActiveSupport::Logger.new($stdout)
      logger.formatter = config.log_formatter
      config.logger = ActiveSupport::TaggedLogging.new(logger)
    end
  end
end
