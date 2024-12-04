class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  def show
    @cart_items = @cart.cart_items.includes(:product)
  end

  def add_item
    product = Product.find(params[:product_id])
    item = @cart.cart_items.find_or_initialize_by(product: product)
    item.quantity += params[:quantity].to_i
    if item.save
      redirect_to cart_path, notice: 'Товар додано до корзини!'
    else
      redirect_to product_path(product), alert: 'Не вдалося додати товар.'
    end
  end

  def remove_item
    item = @cart.cart_items.find(params[:id])
    item.destroy
    redirect_to cart_path, notice: 'Товар видалено з корзини.'
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end
end

