Rails.application.routes.draw do
  default_url_options host: "localhost:3000"
  root "books#index"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  # devise_for :user do
  #  get "/login", :to => "devise/sessions#new"
  #  get "/logout", :to => "devise/sessions#destroy"
  #  get "/register", :to => "devise/registrations#new"
  # end
  # devise_for :users, controllers: {sessions: "sessions"}
  # devise_for :users, controllers: { sessions: 'devise/sessions' }, skip: [:sessions]
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  # as :user do
  #   get 'signin', to: 'devise/sessions#new', as: :new_user_session
  #   post 'signin', to: 'devise/sessions#create', as: :user_session
  #   delete 'signout', to: 'devise/sessions#destroy', as: :destroy_user_session
  # end

  resources :users
  resources :books
  resources :authors
  resources :publishers
  resources :categories
  resources :requests do
    member do
      get "accept_request"
      patch "deny_request"
    end
  end

  namespace :admin do
    resources :books
    resources :requests
  end

  resources :request_details, only: [:create, :update, :destroy]
  resource :cart, only: [:show]

  #routesLike_Comment
  resources :users do
    resources :likes
    resources :create_comment
  end

  get "user_reviews/new"
  get "user_reviews/edit"

  resources :books do
    resources :likes
    resources :comments
    resources :user_reviews
  end
end
