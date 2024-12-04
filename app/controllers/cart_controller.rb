class CartController < ApplicationController
  before_action :set_cart


  def show
    @cart_items = @cart.cart_items.includes(:product)
  end


  def add_item
    @product = Product.find(params[:product_id])


    # Перевіряємо, чи є товар в кошику
    cart_item = current_cart.cart_items.find_by(product_id: @product.id)


    if cart_item
      # Якщо товар є в кошику, збільшуємо кількість
      cart_item.update(quantity: cart_item.quantity + 1)
    else
      # Якщо товару немає в кошику, додаємо новий
      current_cart.cart_items.create(product: @product, quantity: 1)
    end


    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path, notice: 'Товар додано до кошика!') }
      format.json { render json: { success: true, message: 'Товар додано до кошика!', cart_item: cart_item } }
    end
  end



  def remove_item
    item = current_cart.cart_items.find(params[:id])
    item.destroy
    redirect_to cart_path, notice: 'Товар видалено з кошика'
  end


  private


  def set_cart
    @cart = current_cart
  end
end
