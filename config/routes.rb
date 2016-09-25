Rails.application.routes.draw do

  devise_for :users
  resources :requests
  namespace :admin do
    root "users#index"
    resources :users, only: [:index, :show, :destroy]
  end
  root "requests#index"
end
