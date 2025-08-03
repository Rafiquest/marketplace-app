Rails.application.routes.draw do
  get "sellers/dashboard"
  get "buyers/index"
  get "home/index"

  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  get "buyers", to: "buyers#index"
  get "seller_dashboard", to: "sellers#dashboard"
  get 'my_listings', to: 'listings#my_listings'
  get 'sellers/messages', to: 'sellers#messages', as: 'sellers_messages'

  resources :listings do
    post 'contact', on: :member
  end

  root to: "listings#index"
end
