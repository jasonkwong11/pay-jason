Rails.configuration.stripe do |config|

  config.publishable_key = ENV['STRIPE_PUBLISHABLE_KEY'] ||= Rails.application.secrets.stripe_publishable_key 
  config.secret_key = ENV['STRIPE_SECRET_KEY'] ||= Rails.application.secrets.stripe_secret_key

end

Stripe.api_key = Rails.configuration.stripe.secret_key