Rails.application.routes.draw do

  devise_for :users
  resources :requests

  namespace :admin do
    root "users#index"
    resources :users, except: [:new, :create]
    resources :requests, except: [:new, :create]
    resources :positions
    resources :divisions
  end

  namespace :manager do
    root "requests#index"
    resources :users, except: [:new, :create]
    resources :requests, except: [:new, :create]
  end
  root "requests#index"
end
