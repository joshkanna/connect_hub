Rails.application.routes.draw do
  get 'search', to: "search#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  root to: "application#home"

  get "password", to: "passwords#edit", as: :edit_password
  patch "password", to: "passwords#update"

  get "main", to: "main#index"
  get "/sign_up", to: "registrations#new"
  post "/sign_up", to: "registrations#create"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  delete "logout", to: "sessions#destroy"

  resources :users do
    resources :posts do
      resources :comments
    end

    member do
      get "profile"
      patch "update"
      post "send_friend_request"
      post "accept_friend_request"
      post "reject_friend_request"
      delete "cancel_friend_request", to: "users#cancel_friend_request"
      delete "remove_friend", to: "users#remove_friend"
      delete "delete", to: "users#delete"
    end
  end
end
