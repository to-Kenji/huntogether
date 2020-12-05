Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root 'toppages#index'
  resources :users, only: [:index, :show]
  resources :techniques
end
