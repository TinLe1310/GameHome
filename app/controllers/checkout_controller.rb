class CheckoutController < ApplicationController
  def create
    #Establish connection with Stripe
    @game = Game.find(params[:id])

    if @game.nil?
      redirect_to root_path
      return
    end

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      success_url: checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: checkout_cancel_url,
      mode: "payment",
      line_items: [
        {
          quantity: 1,
          price_data: {
            product_data: {
              name: @game.title,
              description: @game.release_date
            },
            unit_amount: (@game.official_store_price.to_i) * 100,
            currency: "CAD",
          }
        },
        {
          quantity: 1,
          price_data:{
            unit_amount: (@game.official_store_price.to_i) * 5,
            currency: "CAD",
            product_data:{
              name: "GST",
              description: "Goods and Services Tax",
            }
          }
        },
        {
          quantity: 1,
          price_data:{
            unit_amount: (@game.official_store_price.to_i) * 7,
            currency: "CAD",
            product_data:{
              name: "PST",
              description: "Provincial Sales Tax",
            }
          }
        }
      ]
    )

    redirect_to @session.url, allow_other_host: true
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  end

  def cancel

  end

end
