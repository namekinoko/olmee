Rails.application.routes.draw do
  root 'top_pages#index'
  resources :users
end
