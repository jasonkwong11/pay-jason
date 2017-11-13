class ChargesController < ApplicationController
#  skip_before_action :verify_authenticity_token, only: :events

  def new
  end

  def create
    # Amount in cents
    @amount = 8000

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Eleven Education customer',
      :currency    => 'usd'
    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  def alipay
    source = Stripe::Source.create(
      type: "alipay",
      amount: 8000,
      currency: 'usd',
      redirect: {
        return_url: 'http://www.eleveneducation.com/pending'
      }
    )
    #if customer autohrizes the payment, the source
    #object's status will transition to chargeable when
    #it is ready to be used in a charge request
    # ... if customer declines, status will transition to failed

    order_args = {
      source_id: source[:id],
      amount: source[:amount],
      client_secret: source[:client_secret],
      created: source[:created],
      currency: source[:currency],
      livemode: source[:livemode],
      owner_address: source[:owner][:address],
      owner_email: source[:owner][:email],
      owner_name: source[:owner][:name],
      owner_phone: source[:owner][:phone],
      verified_address: source[:owner][:verified_address],
      verified_email: source[:owner][:verified_email],
      verified_name: source[:owner][:verified_name],
      verified_phone: source[:owner][:verified_phone],
      status: source[:status],
      payment_type: source[:type],
      usage: source[:usage],
      alipay_statement_descriptor: source[:alipay][:statement_descriptor],
      alipay_native_url: source[:alipay][:native_url],
      alipay_data_string: source[:alipay][:data_string]
    }

    order = Order.find_or_create_by(order_args)

    redirect_to source[:redirect][:url]
  end

  def pending
    #here the get request is returned with these
    #params: source, livemode, client_secret
    # you can include other params if you need
    params
    render status: 200
  end
=begin
  def events
    event = Stripe::Event.retrieve(params[:id])
    # do something with charge success event
    render nothing: true, status: 201
    rescue Stripe::APIConnectionError, Stripe::StripeError
      render nothing: true, status: 400
    end
  end
=end
end
