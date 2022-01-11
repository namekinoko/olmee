Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  root 'top_pages#index'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :contacts, only: [:new, :create, :index]
  resources :services
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :groups, only: [:index, :new, :create, :destroy, :edit]
end
