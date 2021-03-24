Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'search', to: 'pages#search'
  resources :assos, only: [:index, :show] do
    resources :missions, only: [:show, :new, :create, :delete, :index]
  end


  resources :users

  resources :missions, only: [:index, :show] do
    resources :favorites, only: [] do
      collection do
        get :toggle_favorite
      end
    end
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :assos, only: [ :index ]
    end
  end

  resources :favorites

  og:title
  og:description
  og:type
  og:url
  og:image
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
