Rails.application.routes.draw do
  get 'unauthorized/show'
  get 'application/sign_out'

  resources :customers
  resources :login, only: [:new, :create], as: :login
  resources :admins_login, only: [:new, :create], as: :admins_login
  resources :admins
  resources :cars
  resources :reservations
  
  root 'login#new'
end
