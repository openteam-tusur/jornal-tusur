Airbrake.configure do |config|
  raise 'Not defined "errors.key" in config/settings.yml' if Settings['errors.key'].blank?
  raise 'Not defined "errors.url" in config/settings.yml' if Settings['errors.url'].blank?
  config.api_key = Settings['errors.key']
  URI.parse(Settings['errors.url']).tap do |url|
    config.host   = url.host
    config.port   = url.port
    config.secure = url.scheme.inquiry.https?
  end
end
