class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :initialize_cart, :set_page
  helper_method :cart

  private

  def initialize_cart
    session[:shopping_cart] ||= []
    session[:cart_items] ||= []
  end

  def cart
    Game.find(session[:shopping_cart])
  end

  def set_page
    @about_page = AboutPage.first # Or any other logic to retrieve the page
    @contact_page = ContactPage.first
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name])
  end
end
