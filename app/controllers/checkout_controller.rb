class CheckoutController < ApplicationController
  def create
    #Establish connection with Stripe
    @cart_items = session[:cart_items]
    @list_items = []
    @total_amount = 0

    if @cart_items.nil?
      redirect_to root_path
      return
    end

    @cart_items.each do |item|
      game = item["game"]
      quantity = item["quantity"]

      list_item = {
        quantity: quantity,
        price_data: {
          product_data: {
            name: game['title'],
            description: game['release_date']
          },
          unit_amount: (game['official_store_price'].to_i) * 100,
          currency: "CAD",
        }
      }

      @list_items << list_item
      @total_amount += (game['official_store_price'].to_i) * 100 * quantity
    end

    @gst_item = {
      quantity: 1,
      price_data:{
        unit_amount: (@total_amount * 0.05).to_i,
        currency: "CAD",
        product_data:{
          name: "GST",
          description: "Goods and Services Tax",
        }
      }
    }

    @pst_item = {
      quantity: 1,
      price_data:{
        unit_amount: (@total_amount * 0.07).to_i,
        currency: "CAD",
        product_data:{
          name: "PST",
          description: "Provincial Sales Tax",
        }
      }
    }

    @list_items << @gst_item
    @list_items << @pst_item

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      success_url: checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: checkout_cancel_url,
      mode: "payment",
      line_items: @list_items
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
