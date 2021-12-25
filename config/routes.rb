Rails.application.routes.draw do
  root 'top_pages#index'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :contacts, only: [:new, :create, :index]
  resources :services
  resources :account_activations, only: [:edit]
end
