class ApplicationController < ActionController::Base
  helper_method :current_cart

  def current_cart
    # Якщо корзина пов'язана з користувачем
    if user_signed_in?
      @current_cart ||= Cart.find_or_create_by(user_id: current_user.id)
    else
      # Якщо корзина анонімного користувача
      session[:cart_id] ||= Cart.create.id
      @current_cart ||= Cart.find(session[:cart_id])
    end
  end
end

