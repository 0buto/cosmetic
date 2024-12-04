Rails.application.routes.draw do
  get "reviews/new"
  get "reviews/create"
  get "reviews/index"
  get "pages/contacts"
  devise_for :users


  resources :reviews, only: [:index, :new, :create]


  # маршрут для контактної сторінки
  get 'contacts', to: 'pages#contacts', as: 'contacts'

  # Маршрути для корзини
  get '/cart', to: 'cart#show', as: 'cart'
  post '/cart/add_item', to: 'cart#add_item', as: 'add_item_cart'  # Маршрут для додавання товару
  delete '/cart/remove_item/:id', to: 'cart#remove_item', as: 'remove_item_cart'  # Маршрут для видалення товару


  # Маршрут для домашньої сторінки
  get "home/index"
  root 'home#index'


  # Ресурси для замовлень
  resources :orders, only: [:new, :create] do
    member do
      get 'checkout'  # Сторінка оформлення замовлення
      post 'charge'   # Обробка оплати
    end
  end
end


