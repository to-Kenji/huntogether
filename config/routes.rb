Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root 'toppages#index'
  resources :users, only: [:index, :show] do
    member do
      get :liked_techniques
    end
  end

  resources :techniques do
    member do
      get :liked_users
    end
  end
  resources :likes, only: [:create, :destroy]
end
