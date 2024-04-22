# frozen_string_literal: true

# Create
class CheckoutController < ApplicationController
  def create
    # Establish connection with Stripe
    @cart_items = session[:cart_items]
    @current_user = current_user
    address = @current_user[:address]

    @user_gst = Tax.find_by(province: address).GST
    @user_pst = Tax.find_by(province: address).PST
    @user_hst = Tax.find_by(province: address).HST

    @list_items = []
    @total_amount = 0

    if @cart_items.nil?
      redirect_to root_path
      return
    end

    @cart_items.each do |item|
      game = item['game']
      quantity = item['quantity']

      list_item = {
        quantity:,
        price_data: {
          product_data: {
            name: game['title'],
            description: game['release_date']
          },
          unit_amount: game['official_store_price'].to_i * 100,
          currency: 'CAD'
        }
      }

      @list_items << list_item
      @total_amount += game['official_store_price'].to_i * 100 * quantity
    end

    if @user_gst.positive?
      @gst_item = {
        quantity: 1,
        price_data: {
          unit_amount: (@total_amount * @user_gst).to_i,
          currency: 'CAD',
          product_data: {
            name: 'GST',
            description: 'Goods and Services Tax'
          }
        }
      }

      @list_items << @gst_item
    end

    if @user_pst.positive?
      @pst_item = {
        quantity: 1,
        price_data: {
          unit_amount: (@total_amount * @user_pst).to_i,
          currency: 'CAD',
          product_data: {
            name: 'PST',
            description: 'Provincial Sales Tax'
          }
        }
      }

      @list_items << @pst_item
    end

    if @user_hst.positive?
      @hst_item = {
        quantity: 1,
        price_data: {
          unit_amount: (@total_amount * @user_hst).to_i,
          currency: 'CAD',
          product_data: {
            name: 'HST',
            description: 'Harmonized Sales Tax'
          }
        }
      }

      @list_items << @hst_item
    end

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      success_url: "#{checkout_success_url}?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: checkout_cancel_url,
      mode: 'payment',
      line_items: @list_items
    )

    redirect_to @session.url, allow_other_host: true
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  end

  def cancel; end
end
