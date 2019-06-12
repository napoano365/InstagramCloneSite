Rails.application.routes.draw do
  get 'sessions/new'
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  get '/auth/facebook/callback', to: 'users#auth_done', as: :auth_done
  get '/auth/failure',  to: 'users#auth_failure', as: :auth_failure
  
  resources :users do
    member do
      get :following, :followers, :password_change
    end
  end
  resources :posts
  resources :comments
  resources :favorites
  resources :relationships,       only: [:create, :destroy]
end
