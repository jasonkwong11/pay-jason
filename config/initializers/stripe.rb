Rails.configuration.stripe do |config|

  config.publishable_key = ENV['STRIPE_PUBLISHABLE_KEY'] ||= Rails.application.secrets.stripe_publishable_key 
  config.secret_key = ENV['STRIPE_SECRET_KEY'] ||= Rails.application.secrets.stripe_secret_key

end

Stripe.api_key = Rails.configuration.stripe.secret_key
#Stripe.api_key = "sk_test_Dvlw0GvmUfj9PcXQzHaCBi5m"
# ^^this is a test api_key. make sure you use the commented out production one above when deploying

StripeEvent.configure do |events|
  events.subscribe 'source.chargeable' do |event|
    puts "inside of source.chargeable event"

    source_id = event.source_id

    #use the source_id to find the associated Order object:
    order = Order.find_by(source_id: source_id)

    charge = Stripe::Charge.create({
      amount: 8000,
      currency: 'usd',
      source: source_id
    })

    order.charge_id = charge.id
    order.save
  end

  events.subscribe 'source.failed' do |event|
    puts "inside of subscribed source.failed"
  end

  events.subscribe 'source.cancelled' do |event|
    puts "inside of subscribed source.cancelled"
  end
end

StripeEvent.configure do |events|
  events.all do |event|
    if event.type == 'source.chargeable'
      #once the source is chargeable, from your webhook
      #handler (here), you can make a charge request
      #using the source ID as the value for the source
      #parameter to complete the payment
      #look at the event object and find the source_id ===
      source_id = event.source_id

      #use the source_id to find the associated Order object:
      order = Order.find_by(source_id: source_id)

      charge = Stripe::Charge.create({
        amount: 8000,
        currency: 'usd',
        source: source_id
      })

      order.charge_id = charge.id
      order.save
      ##order is successful, send email to customer

    end

    if event.type == 'source.failed'
      puts "inside of source.failed event"
      #A Source object failed to become chargeable
      # as your customer declined to authenticate the payment.

=begin
  1.find the Order object using the source_id
  2.set the Order object's status field to 'failed', and save the object
  3. send email to customer saying order failed because payment wasn't authenticated
=end
    end

    if event.type == 'source.cancelled'
      puts 'inside of source.cancelled event'
      #A Source object expired and cannot be used to create a charge.

=begin
  1.find the Order object using the source_id
  2.set the Order object's status field to 'cancelled', and save the object
  3. send email to customer saying order failed because you left the checkout flow early
=end
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
      #send email and set the order to failed
    end
  end
end