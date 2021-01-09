Rails.application.routes.draw do
  get 'bookmarks/create'
  get 'bookmarks/destroy'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  
  root 'toppages#index'

  resources :users, only: [:index, :show] do
    member do
      get :favorites
    end
  end
  resources :techniques do
    member do
      get :favors
    end
    resources :comments, only: [:create, :destroy]
  end

  resources :bookmarks, only: [:create, :destroy]
  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'


end
