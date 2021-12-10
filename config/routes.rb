Rails.application.routes.draw do
  root 'top_pages#index'
  get 'users/new'
  resources :users
end
