# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

require './app/middlewares/set_locale_middleware'

Bundler.require(*Rails.groups)

module RailsProject65
  class Application < Rails::Application
    config.load_defaults 7.1

    config.autoload_lib(ignore: %w[assets tasks])

    config.generators.template_engine = :slim

    config.i18n.available_locales = %i[ru en]
    config.i18n.default_locale = :ru
  end
end
