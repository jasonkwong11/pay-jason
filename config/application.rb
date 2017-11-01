require_relative 'boot'

require 'rails/all'

require 'dotenv/load' if (ENV['RUBY_ENV'] == "development" || ENV['RUBY_ENV'] == "test")
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PayJason
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.stripe.publishable_key = "pk_live_9xFRTY0sZJFyv6pBJfmkUXpw"

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
