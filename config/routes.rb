Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  root 'toppages#index'

  resources :users, only: :show do
    member do
      get :favorites
      get :followings
      get :followers
    end
  end
  resources :techniques, except: [:index] do
    member do
      get :favors
    end
    resources :comments, only: %i[create destroy]
  end

  get 'techniques' => 'techniques#tagged_index', as: 'tagged_techniques'
  resources :bookmarks, only: %i[create destroy]
  resources :relationships, only: %i[create destroy]
  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'
  resources :timeline, only: [:index]
end
