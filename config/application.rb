require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Fels213
  class Application < Rails::Application
    Config::Integration::Rails::Railtie.preload
    config.time_zone = Settings.time_zone
  end
end
