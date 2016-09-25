Rails.application.routes.draw do

  devise_for :users
  resources :requests
  namespace :admin do
    root "users#index"
    resources :users, only: [:index, :show, :destroy, :edit]
    resources :requests, except: [:new, :create]
  end
  root "requests#index"
end
