Rails.application.routes.draw do

  resources :visitors
  root to: 'home#index'
  get 'dev' => 'home#dev'

  resources :appointments
  resources :employees
  resources :residents
  resources :users
  resources :facilities
  resources :companies
  resources :sessions, only: [ :new, :create, :destroy ]
  
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  
end
