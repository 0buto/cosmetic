class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:charge]
  before_action :authenticate_user!
  before_action :set_cart, only: [:new, :create, :checkout, :charge]

  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.total_price = @cart.total_price
    @order.status = 'pending' # Встановлюємо статус замовлення як "pending" за замовчуванням

    if @order.save
      redirect_to "/orders/#{@order.id}/checkout", notice: "Замовлення створено. Перейдіть до оплати."
    else
      render :new, alert: "Помилка при оформленні замовлення."
    end
  end

  def checkout
    @order = current_user.orders.find(params[:id])
  end

  def charge
    @order = current_user.orders.find(params[:id])
    amount = (@order.total_price * 100).to_i # Stripe працює з копійками

    begin
      charge = Stripe::Charge.create({
                                       amount: amount,
                                       currency: "uah",
                                       source: params[:stripeToken],
                                       description: "Замовлення ##{@order.id}",
                                     })

      if charge.paid
        @order.update(status: 'paid') # Встановлюємо статус на "paid"
        redirect_to root_path, notice: "Замовлення успішно оплачено!"
      else
        redirect_to orders_checkout_path(order_id: @order.id), alert: "Оплата не вдалася. Спробуйте ще раз."
      end
    rescue Stripe::CardError => e
      redirect_to orders_checkout_path(order_id: @order.id), alert: e.message
    end
  end

  private

  def set_cart
    @cart = current_user.cart
  end

  def order_params
    params.require(:order).permit(:delivery_method, :delivery_address)
  end
end

