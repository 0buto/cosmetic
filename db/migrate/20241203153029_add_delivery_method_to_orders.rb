class AddDeliveryMethodToOrders < ActiveRecord::Migration[8.0]
  def change
    add_column :orders, :delivery_method, :string
  end
end
