require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Knocal
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
    config.i18n.default_locale = :ja

    config.generators do |g|
      g.javascripts false
      g.stylesheets false
      g.template_engine :haml
      g.test_framework false
      g.helper false
    end
  end
end
