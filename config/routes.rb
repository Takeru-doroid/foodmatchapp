Rails.application.routes.draw do
  root "homes#top"
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  resources :users, only: [:show] do
    resources :notifications, only: :index do
      collection do
        delete "destroy_all"
      end
    end  
  end
  resources :categories, only: [:new, :create]
  resources :ingredients, only: [:index, :show, :new, :create]
  resources :dishes, only: [:new, :create]
  resources :category_dishes, only: [:new, :create]
  resources :posts, only: [:index, :new, :create, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
  end
  get 'selections/display_selection', to: 'selections#display_selection'
  post 'selections/calculate_dishes', to: 'selections#calculate_dishes'
end
