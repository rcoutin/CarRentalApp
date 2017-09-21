Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :customers
  resources :login, only: [:new, :create], as: :login

  root 'login#new'
end
