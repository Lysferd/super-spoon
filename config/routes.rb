Rails.application.routes.draw do

  root to: 'home#index'
  get 'dev' => 'home#dev'

  resources :appointments
  resources :visitors
  resources :hosts
  resources :users
  resources :facilities
  
  get '/signup' => 'users#new'
  post '/users' => 'users#create'
  
end
