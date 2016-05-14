Rails.application.routes.draw do
  resources :players, only: [:index, :show, :create, :new]
  resources :games, only: [:index, :new, :create, :show, :destroy]
  resources :clubs, only: [:new]
  resources :tournaments, only: [:index, :new, :update, :create, :show] do
    resources :matchups, only: [:edit, :update]
    post '/matchups/new', to: 'matchups#create'
  end

  root 'players#index'
end
