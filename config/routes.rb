Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  ressources :associations do
    ressources :missions, only: [:new, :create, :delete]
  end


  ressources :users do
    ressources :favorites, only: :index
  end

  ressources :missions, only: :show do
    ressources :favorites, only: :create
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
