Rails.application.routes.draw do
  resources :tasks
  # SESSION
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  # USER
  get 'sign_up', to: 'users#new'
  resources :users, only: [:new, :create]
  root to: "tasks#index"
end
