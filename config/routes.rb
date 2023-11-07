Rails.application.routes.draw do
  root "homes#top"
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  resources :users, only: [:show]
  resources :categories, only: [:new, :create]
  resources :ingredients, only: [:index, :show, :new, :create]
  resources :dishes, only: [:new, :create]
  resources :category_dishes, only: [:new, :create]
  get 'selections/display_selection', to: 'selections#display_selection'
  post 'selections/calculate_dishes', to: 'selections#calculate_dishes'
end
