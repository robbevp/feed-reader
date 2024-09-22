# frozen_string_literal: true

Rails.application.configure do
  # GoodJob recurring jobs
  # See https://github.com/bensheldon/good_job#cron-style-repeatingrecurring-jobs
  config.good_job.enable_cron = true
  config.good_job.cron = {
    refresh_feeds: { # each recurring job must have a unique key
      cron: 'every hour', # cron-style scheduling format by fugit gem
      class: 'RefreshRssFeedsJob', # reference the Job class with a string
      description: 'Recurring job that fetches new entries in rss feeds'
    }
  }
end
