# frozen_string_literal: true

if Rails.env.production?
  Sentry.init do |config|
    config.dsn = 'https://6eb873ff73c5289d25918060f0d01c30@o4507184816979968.ingest.de.sentry.io/4507411291111504'
    config.breadcrumbs_logger = %i[active_support_logger http_logger]

    config.traces_sample_rate = 1.0
    config.traces_sampler = lambda do |_context|
      true
    end
    config.profiles_sample_rate = 1.0
  end
end
