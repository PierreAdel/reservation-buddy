Rails.application.routes.draw do
  get '', to: 'hello_world#index'
  root 'pages#index'

  namespace :api do
    namespace :v1 do
      resources :sessions, only: [:create]
      resources :registrations, only: [:create]

      post '/sessions/admin_login', to: 'sessions#admin_login'
      post 'sessions/user_login', to: 'sessions#user_login'

      delete '/sessions/admin_logout', to: 'sessions#admin_logout'
      delete '/sessions/user_logout', to: 'sessions#user_logout'

      get '/sessions/admin_logged_in', to: 'sessions#admin_logged_in'
      get '/sessions/user_logged_in', to: 'sessions#user_logged_in'

      resources :hotels, param: :slug
      resources :customers, param: :email

      get '/reservations', to: 'reservations#get_all_reservations'
      get '/reservations/my_reservations',
          to: 'reservations#get_all_my_reservations'
      post '/reservations/:slug', to: 'reservations#create'

      resources :admins, only: %i[index show]
      resources :customers, only: %i[index show]
    end
  end

  get '*path', to: 'hello_world#index', via: :all
end
