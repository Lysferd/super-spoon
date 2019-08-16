Rails.application.routes.draw do

  root to: 'home#index'
  get 'dev' => 'home#dev'

  get 'next' => 'home#next'

  resources :facilities
  resources :companies
  resources :residents
  resources :employees
  resources :visitors
  resources :appointments
  resources :users
  resources :sessions, only: [ :new, :create, :destroy ]
  
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  
end
