Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :assos, only: :index

  resources :assos do
    resources :missions, only: [:show, :new, :create, :delete, :index]
  end

  resources :users do
    resources :favorites, only: :index
  end

  resources :missions, only: :index do
    resources :favorites, only: :create
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :assos, only: [ :index ]
    end
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
