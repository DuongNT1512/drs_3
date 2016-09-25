Rails.application.routes.draw do

  devise_for :users
  resources :requests, except: :show
  resources :reports

  namespace :admin do
    root "reports#index"
    resources :users, except: [:new, :create]
    resources :requests, except: [:new, :create]
    resources :reports, only: :index
    resources :positions
    resources :divisions
  end

  namespace :manager do
    root "requests#index"
    resources :users, except: [:new, :create]
    resources :requests, except: [:new, :create]
    resources :reports, only: :index
  end
  root "requests#index"
end
