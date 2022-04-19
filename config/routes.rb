Rails.application.routes.draw do
  root 'pages#index'

  namespace :api do
    namespace :v1 do
      resources :hotels, param: :slug
      resources :reservations, only: [:index, :show]
      resources :admins, only: [:index, :show]
      resources :customers, only: [:index, :show]
    end
  end

  get '*path', to: 'pages#index', via: :all
end
