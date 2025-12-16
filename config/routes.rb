Rails.application.routes.draw do
  root "posts#index"
  devise_for :users
  
  resources :posts
  resources :comments, only: [:create, :destroy]

  resources :users, only: [:new, :create]

  get  "/login",  to: "sessions#new"
  post "/login",  to: "sessions#create"
  delete '/logout', to: 'sessions#destroy', as: 'logout'
end
