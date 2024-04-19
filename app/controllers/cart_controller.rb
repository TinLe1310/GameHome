class CartController < ApplicationController
  def create
    logger.debug("Adding #{params[:id]} to cart.")
    id = params[:id].to_i
    quantity = 1
    game = Game.find(id)
    session[:shopping_cart] << id if game unless session[:shopping_cart].include?(id)
    session[:cart_items] << { game: game, quantity: quantity } if game
    flash[:notice] = "#{game.title} has been added to cart"

    redirect_to root_path
  end

  def destroy
    id = params[:id].to_i
    game = Game.find(id)
    session[:shopping_cart].delete(id)
    session[:cart_items].each_with_index do |item, index|
      if item['game']['id'] == id
        session[:cart_items].delete_at(index)
        break
      end
    end
    flash[:notice] = "#{game.title} has been removed from cart"

    redirect_to root_path
  end

  def update
    id = params[:id].to_i
    game = Game.find(id)
    quantity = params[:quantity].to_i
    session[:cart_items].each_with_index do |item, index|
      if item['game']['id'] == id
        session[:cart_items][index]['quantity'] = quantity
        break
      end
    end
    flash[:notice] = "#{game.title} has been updated quantity"
    redirect_to root_path
  end
end
