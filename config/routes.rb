Rails.application.routes.draw do
  require "sidekiq/web"

  devise_for :users,
    controllers: {omniauth_callbacks: "omniauth_callbacks"}
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
    mount Sidekiq::Web, at: "/sidekiq"
  end

  namespace :manager do
    root "requests#index"
    resources :users, except: [:new, :create]
    resources :requests, except: [:new, :create]
    resources :reports, only: :index
    mount Sidekiq::Web, at: "/sidekiq"
  end

  root "requests#index"
end
