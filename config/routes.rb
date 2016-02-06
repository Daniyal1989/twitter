Rails.application.routes.draw do
  resources :users do
    member do
      get :following, :followers
    end
  end
  
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts, only: [:create, :destroy]
   resources :relationships, only: [:create, :destroy]
  root  'pages#home'
  match '/signup',  to: 'users#new',            via: :get
  match '/signin',  to: 'sessions#new',         via: :get
  match '/signout', to: 'sessions#destroy',     via: :delete
  
  match '/signup', to: 'users#new', via: :get

  resources :users
  match '/about', to: 'pages#about', via: :get
  match '/contacts', to: 'pages#contacts', via: :get
  match '/help', to: 'pages#help', via: :get
end
