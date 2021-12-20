Rails.application.routes.draw do
  root 'top_pages#index'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/main', to: 'services#main'
  resources :users
  resources :contacts, only: [:new, :create, :index]
end
