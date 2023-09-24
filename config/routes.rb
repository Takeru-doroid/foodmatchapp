Rails.application.routes.draw do
  root "homes#top"
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  resources :users, only: [:show]
  resources :ingredients, only: [:show]
  resources :dishes, only: [:show]
  get 'selections/display_selection', to: 'selections#display_selection'
  post 'selections/calculate_dishes', to: 'selections#calculate_dishes'
end
