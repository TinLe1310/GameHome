class CartController < ApplicationController
  def create
    logger.debug("Adding #{params[:id]} to cart.")
    id = params[:id].to_i
    session[:shopping_cart] << id unless session[:shopping_cart].include?(id)
    game = Game.find(id)
    flash[:notice] = "#{game.title} has been added to cart"

    redirect_to root_path
  end

  def destroy
    id = params[:id].to_i
    session[:shopping_cart].delete(id)
    game = Game.find(id)
    flash[:notice] = "#{game.title} has been removed from cart"

    redirect_to root_path
  end
end
