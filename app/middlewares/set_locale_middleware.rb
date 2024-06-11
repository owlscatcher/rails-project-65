# frozen_string_literal: true

class SetLocaleMiddleware
  def initialize(app)
    @app = app
  end

  # BEGIN
  def call(env)
    request = Rack::Request.new env

    locale = extract_locale(request) || I18n.default_locale
    I18n.locale = locale.downcase.to_sym

    status, headers, response = @app.call(env)
    headers['Content-Language'] = locale

    [status, headers, response]
  end

  def extract_locale(request)
    locale = request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.first

    I18n.available_locales.map(&:to_s).include?(locale) ? locale : nil
  end
end
