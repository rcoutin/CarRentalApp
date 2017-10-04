Rails.application.routes.draw do
  get 'unauthorized/show'
  get 'application/sign_out'
  get 'reservations/cancel'
  get 'reservations/checkout'
  get 'reservations/return'
  get 'car_approvals/approve'
  get 'customers/pay'

  resources :customers
  resources :login, only: [:new, :create], as: :login
  resources :admins_login, only: [:new, :create], as: :admins_login
  resources :admins
  resources :cars
  resources :reservations
  resources :reservation_history
  resources :notifications
  resources :car_approvals

  root 'login#new'
end
