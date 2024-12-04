class Cart < ApplicationRecord
  has_many :cart_items
  has_many :products, through: :cart_items
  belongs_to :user

  def add_product(product)
    cart_item = cart_items.find_by(product: product)

    if cart_item
      cart_item.increment(:quantity)
      cart_item.save
    else
      cart_items.create(product: product, quantity: 1)
    end
  end

  def total_price
    cart_items.includes(:product).sum { |item| item.product.price * item.quantity }
  end
end
