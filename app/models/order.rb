class Order < ApplicationRecord
  belongs_to :user

  # Використовуємо масиви для статусу і способу доставки
  STATUS_OPTIONS = ["pending", "paid", "shipped"]
  DELIVERY_METHODS = ["Стандарт", "Експрес ", "Самовивіз"]

  # Перевіряємо, чи значення статусу і способу доставки належать до можливих варіантів
  validates :status, inclusion: { in: STATUS_OPTIONS }
  validates :delivery_method, inclusion: { in: DELIVERY_METHODS }
  validates :delivery_address, presence: true, length:  { minimum: 5, maximum: 55 }

  # Додатково можна визначити методи для зручності
  def pending?
    status == "pending"
  end

  def paid?
    status == "paid"
  end

  def shipped?
    status == "shipped"
  end

  def standard_delivery?
    delivery_method == "standard"
  end

  def express_delivery?
    delivery_method == "express"
  end

  def pickup_delivery?
    delivery_method == "pickup"
  end
end
