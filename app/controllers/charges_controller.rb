class ChargesController < ApplicationController
  def new
  end

  def create
    # Amount in cents
    @amount = 500

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
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
        return_url: 'http://localhost:3000/confirmation'
      }
    )
    #if customer autohrizes the payment, the source
    #object's status will transition to chargeable when
    #it is ready to be used in a charge request
    # ... if customer declines, status will transition to failed

    redirect_to source[:redirect][:url]
  end

  def confirmation
    #here the get request is returned with these
    #params: source, livemode, client_secret
    # you can include other params if you need
    params
    require 'pry'
    binding.pry
  end
end
