class ApplicationController < ActionController::Base
  before_action :initialize_cart
  helper_method :cart

  private

  def initialize_cart
    session[:shopping_cart] ||= []
  end

  def cart
    Game.find(session[:shopping_cart])
  end
end
