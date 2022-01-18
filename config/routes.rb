Rails.application.routes.draw do
  root 'top_pages#index'
  get 'password_resets/new'
  get 'password_resets/edit'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  resources :users
  resources :contacts, only: [:new, :create, :index]
  resources :services
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :groups do
    resources :chats, only: [:index, :create]
    member do
      get :join
      get :cancel
    end
  end
  
end
