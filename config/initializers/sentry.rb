# frozen_string_literal: true

if Rails.env.production?
  Sentry.init do |config|
    config.dsn = ENV.fetch('SENTRY_SECRET', nil)
    config.breadcrumbs_logger = %i[active_support_logger http_logger]

    config.traces_sample_rate = 1.0
    config.traces_sampler = lambda do |_context|
      true
    end
    config.profiles_sample_rate = 1.0
  end
end
