# frozen_string_literal: true

dsn = ENV.fetch('SENTRY_DSN', nil)

if dsn.present?
  Sentry.init do |config|
    config.dsn = dsn
    config.breadcrumbs_logger = %i[active_support_logger http_logger]
    config.traces_sample_rate = ENV.fetch('SENTRY_TRACES_SAMPLE_RATE', 0).to_f
  end
end
