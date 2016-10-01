Rails.application.routes.draw do

  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  resources :requests, except: :show
  resources :reports
  resources :users

  namespace :admin do
    root "reports#index"
    resources :users, except: [:new, :create]
    resources :requests, except: [:new, :create]
    resources :reports, only: :index
    resources :positions
    resources :divisions
    resources :languages
  end

  namespace :manager do
    root "requests#index"
    resources :users, except: [:new, :create]
    resources :requests, except: [:new, :create]
    resources :reports, only: :index
  end

  root "requests#index"
end
