Rails.configuration.stripe do |config|

  config.publishable_key = ENV['STRIPE_PUBLISHABLE_KEY'] ||= Rails.application.secrets.stripe_publishable_key 
  config.secret_key = ENV['STRIPE_SECRET_KEY'] ||= Rails.application.secrets.stripe_secret_key

end

#Stripe.api_key = Rails.configuration.stripe.secret_key
Stripe.api_key = "sk_test_Dvlw0GvmUfj9PcXQzHaCBi5m"


StripeEvent.configure do |events|
  events.all do |event|

    if event.type == 'source.chargeable'
      #once the source is chargeable, from your webhook
      #handler (here), you can make a charge request
      #using the source ID as the value for the source
      #parameter to complete the payment

      charge = Stripe::Charge.create({
        amount: 8000,
        currency: 'usd',
        source: @@source_id
      })

    end

    if event.type == 'source.failed'
      #A Source object failed to become chargeable
      # as your customer declined to authenticate the payment.
    end

    if event.type == 'source.cancelled'
      #A Source object expired and cannot be used to create a charge.
    end

#CHARGE EVENTS

    if event.type == 'charge.succeeded'
      #notify customer that the payment process
      #has been completed and the order is confirmed
    end

    if event.type == 'charge.pending'
      #the charge is pending (async payments only, ie: credit cards)
    end

    if event.type == 'charge.failed'
      #the charge has failed and the payment could not be completed
    end
  end
end