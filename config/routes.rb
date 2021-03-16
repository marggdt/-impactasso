Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :assos do
    resources :missions, only: [:new, :create, :delete, :index]
  end


  resources :users do
    resources :favorites, only: :index
  end

  resources :missions, only: :show do
    resources :favorites, only: :create
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
