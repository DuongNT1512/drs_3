Rails.application.routes.draw do

  devise_for :users
  resources :requests
  resources :users

  namespace :admin do
    root "reports#index"
    resources :users, except: [:new, :create]
    resources :requests, except: [:new, :create]
  end

  namespace :manager do
    root "requests#index"
    resources :users, except: [:new, :create]
    resources :requests, except: [:new, :create]
  end
  root "requests#index"
end
