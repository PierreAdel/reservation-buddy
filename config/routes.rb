Rails.application.routes.draw do
  get 'hello_world', to: 'hello_world#index'
  root 'pages#index'

  namespace :api do
    namespace :v1 do
      resources :sessions, only: [:create]
      resources :registrations, only: [:create]
      delete '/sessions/logout', to: "sessions#logout"
      get "sessions/logged_in", to: "sessions#logged_in"
      resources :hotels, param: :slug
      resources :reservations, only: [:index, :show]
      resources :admins, only: [:index, :show]
      resources :customers, only: [:index, :show]
    end
  end

  get '*path', to: 'pages#index', via: :all
end
